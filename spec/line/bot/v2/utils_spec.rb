require 'spec_helper'

describe Line::Bot::V2::Utils do
  describe '.deep_underscore' do
    it 'converts camelCase keys to snake_case' do
      input = { 'camelCaseKey' => 'value' }
      expected_output = { camel_case_key: 'value' }
      expect(Line::Bot::V2::Utils.deep_underscore(input)).to eq(expected_output)
    end

    it 'converts CamelCase keys to snake_case' do
      input = { 'CamelCaseKey' => 'value' }
      expected_output = { camel_case_key: 'value' }
      expect(Line::Bot::V2::Utils.deep_underscore(input)).to eq(expected_output)
    end

    it 'converts nested hashes with camelCase keys' do
      input = { 'outerKey' => { 'innerKey' => 'value' } }
      expected_output = { outer_key: { inner_key: 'value' } }
      expect(Line::Bot::V2::Utils.deep_underscore(input)).to eq(expected_output)
    end

    it 'converts nested hashes with CamelCase keys' do
      input = { 'OuterKey' => { 'InnerKey' => 'value' } }
      expected_output = { outer_key: { inner_key: 'value' } }
      expect(Line::Bot::V2::Utils.deep_underscore(input)).to eq(expected_output)
    end

    it 'handles empty hashes' do
      input = {}
      expected_output = {}
      expect(Line::Bot::V2::Utils.deep_underscore(input)).to eq(expected_output)
    end

    it 'handles hashes with no camelCase or CamelCase keys' do
      input = { 'simple_key' => 'value' }
      expected_output = { simple_key: 'value' }
      expect(Line::Bot::V2::Utils.deep_underscore(input)).to eq(expected_output)
    end

    it 'does not modify non-hash values' do
      input = { 'key' => ['array', 'of', 'values'] }
      expected_output = { key: ['array', 'of', 'values'] }
      expect(Line::Bot::V2::Utils.deep_underscore(input)).to eq(expected_output)
    end
  end
end
