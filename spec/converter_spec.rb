# frozen_string_literal: true
require 'spec_helper'

describe JsonToCsv do
  def csv_file_path
    path_to('test.csv')
  end

  def json_file_path
    path_to('test.json')
  end

  def path_to(filename)
    File.expand_path("#{filename}", File.dirname(__FILE__))
  end

  before(:all) do
    next unless File.exist?(csv_file_path)
    File.delete(csv_file_path)
  end
  after(:each) { Dir.glob('**/*.csv').each { |file_path| File.delete(file_path) } }

  describe 'convert' do
    it 'raises an error when no file exists for the provided json file path' do
      expect { described_class.convert('non-existing-file') }.to raise_error(FileNotFound, "File 'non-existing-file' could not be found")
    end

    it 'uses the json filename for the csv file when no csv file path is provided' do
      expect { described_class.convert(json_file_path) }.to change { File.exist?(csv_file_path) }.from(false).to(true)
    end

    it 'uses the provided csv file path for the csv file when a csv file path is provided' do
      provided_csv_file_path = File.expand_path('../awesome_file.csv', File.dirname(__FILE__))
      described_class.convert(json_file_path, provided_csv_file_path)
      expect(File.exist?(provided_csv_file_path))
    end

    it 'build a proper CSV with one header and several data rows' do
      described_class.convert(json_file_path, csv_file_path)
      rows = []
      CSV.foreach(csv_file_path) { |row| rows << row }
      expect(rows[0]).to match_array(%w(id hash.other_hash.item_1 hash.other_hash.item_2 hash.other_hash.array string))
      expect(rows[1]).to match_array(%w(1 9 bb 1,2 stringa))
      expect(rows[2]).to match_array(%w(2 10 dd 3,4 stringb))
    end
  end
end