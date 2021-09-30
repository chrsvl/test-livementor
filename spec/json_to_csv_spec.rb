# frozen_string_literal: true
require 'spec_helper'

describe JsonToCsv do
  describe 'convert' do
    it 'raises an error when no json file path is provided' do
      expect { described_class.convert(nil) }.to raise_error(ArgumentError, 'You must at least provide a JSON file path')
    end

    it 'calls the converter' do
      expect(JsonToCsv::Converter).to receive(:to_json).with('json_file_path', 'csv_file_path')
      described_class.convert('json_file_path', 'csv_file_path')
    end
  end
end