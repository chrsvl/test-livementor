# frozen_string_literal: true
require 'json_to_csv/version'
require 'json_to_csv/converter'
require 'json_to_csv/errors'

module JsonToCsv
  # Converts a JSON file into a CSV file
  #
  # @param json_file_path [String]: path to the JSON file
  # @opt csv_file_path [String | nil]: path to use for the generated
  #   CSV file. If not provided, we will use the JSON file path with the
  #   .json replaced by .csv
  def self.convert(json_file_path, csv_file_path = nil)
    raise ArgumentError, 'You must at least provide a JSON file path' unless json_file_path
    
    Converter.to_json(json_file_path, csv_file_path)
  end
end