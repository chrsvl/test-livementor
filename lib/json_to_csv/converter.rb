require 'json'
require 'csv'

module JsonToCsv
  class Converter
    # Converts a JSON file into a CSV file
    # This is where we really perform the conversion.
    #
    # @param json_file_path [String]: path to the JSON file
    # @opt csv_file_path [String]: path to use for the generated
    #   CSV file.
    def self.to_json(json_file_path, csv_file_path)
      raise FileNotFound, "File '#{json_file_path}' could not be found" unless File.exist?(json_file_path)
  
      csv_file_path = json_file_path.gsub('.json', '.csv') unless csv_file_path
      json_file = File.open(json_file_path)
      # Improvement: use lazy method for big files
      json_raw = json_file.read
      json_parsed = self.parse_json(json_raw)

      CSV.open(csv_file_path, 'w') do |csv_line|
        should_add_headers = true
        json_parsed.each do |item|
          header_and_values = item.each_with_object({}) do |(key, value), accumulator|
            formatted_keys, formatted_values = extract_headers_and_values(key, value)
            formatted_values = Array(formatted_values)
            Array(formatted_keys).each do |formatted_key|
              accumulator[formatted_key] = formatted_values.shift
            end
          end
      
          if should_add_headers
            csv_line << header_and_values.keys
            should_add_headers = false
          end
          csv_line << header_and_values.values
        end
      end
    end

    private

    # Parse a raw JSON string.
    #
    # @param json_raw [String]: the raw JSON string
    #   to parse
    # @return [Hash]: the parsed JSON as a hash
    # @raise NonValidJSON if the JSON is not valid
    def self.parse_json(json_raw)
      JSON.parse(json_raw)
    rescue JSON::ParserError => _
      raise NonValidJSON, 'Make sure you provided a valid JSON'
    end

    # Extract the headers and values to be added to the CSV file.
    # 
    # For hash values, it will recursively run traverse the hash until
    # it reaches a non-hash value.
    #
    # @param key [String]
    # @param value [Any]
    # @optional parent_key [nil | String]: the parent key to use a suffix
    #   in case of a hash traversal. For nested objects, we will build the
    #   absolute path using the parent_key.
    def self.extract_headers_and_values(key, value, parent_key = nil)
      if value.is_a?(Array)
        [parent_key || key, value.join(',')]
      elsif value.is_a?(Hash)
        headers_and_values = value.each_with_object({}) do |(the_key, the_value), accumulator|
          formatted_key, formatted_value = extract_headers_and_values(the_key, the_value, parent_key ? "#{key}.#{the_key}" : key)
          formatted_key = "#{parent_key}.#{formatted_key}" if parent_key
          accumulator[formatted_key] = formatted_value
        end
        [headers_and_values.keys.flatten, headers_and_values.values.flatten]
      else
        [parent_key || key, value]
      end
    end
  end
end