require 'spec_helper'

class TestObject
  attr_accessor :first_name, :last_name

  def initialize(first_name, last_name)
    @first_name = first_name
    @last_name = last_name
  end
end

class NestedObject
  attr_accessor :inner

  def initialize(inner)
    @inner = inner
  end
end

class ArrayObject
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

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

  describe '.deep_to_hash' do
    it 'converts an object with instance variables to a hash' do
      input = TestObject.new('John', 'Doe')
      expected_output = { first_name: 'John', last_name: 'Doe' }
      expect(Line::Bot::V2::Utils.deep_to_hash(input)).to eq(expected_output)
    end

    it 'converts nested objects to hashes' do
      inner_object = NestedObject.new('value')
      outer_object = NestedObject.new(inner_object)
      expected_output = { inner: { inner: 'value' } }
      expect(Line::Bot::V2::Utils.deep_to_hash(outer_object)).to eq(expected_output)
    end

    it 'handles arrays of objects' do
      input = [ArrayObject.new('Alice'), ArrayObject.new('Bob')]
      expected_output = [{ name: 'Alice' }, { name: 'Bob' }]
      expect(Line::Bot::V2::Utils.deep_to_hash(input)).to eq(expected_output)
    end
  end

  describe '.deep_camelize' do
    it 'converts snake_case keys to camelCase' do
      input = { snake_case_key: 'value' }
      expected_output = { snakeCaseKey: 'value' }
      expect(Line::Bot::V2::Utils.deep_camelize(input)).to eq(expected_output)
    end

    it 'converts nested hashes with snake_case keys' do
      input = { outer_key: { inner_key: 'value' } }
      expected_output = { outerKey: { innerKey: 'value' } }
      expect(Line::Bot::V2::Utils.deep_camelize(input)).to eq(expected_output)
    end

    it 'handles empty hashes' do
      input = {}
      expected_output = {}
      expect(Line::Bot::V2::Utils.deep_camelize(input)).to eq(expected_output)
    end

    it 'does not modify non-hash values' do
      input = { key: ['array', 'of', 'values'] }
      expected_output = { key: ['array', 'of', 'values'] }
      expect(Line::Bot::V2::Utils.deep_camelize(input)).to eq(expected_output)
    end
  end

  describe '.deep_compact' do
    it 'removes nil values from a hash' do
      input = { key1: 'value', key2: nil }
      expected_output = { key1: 'value' }
      expect(Line::Bot::V2::Utils.deep_compact(input)).to eq(expected_output)
    end

    it 'removes empty arrays and hashes' do
      input = { key1: [], key2: {} }
      expected_output = {}
      expect(Line::Bot::V2::Utils.deep_compact(input)).to eq(expected_output)
    end

    it 'compacts nested structures' do
      input = { key1: { key2: nil, key3: 'value' }, key4: [] }
      expected_output = { key1: { key3: 'value' } }
      expect(Line::Bot::V2::Utils.deep_compact(input)).to eq(expected_output)
    end

    it 'handles arrays with nil values' do
      input = [nil, 'value', nil]
      expected_output = ['value']
      expect(Line::Bot::V2::Utils.deep_compact(input)).to eq(expected_output)
    end
  end

  describe '.camelize' do
    it 'converts snake_case to camelCase' do
      input = 'snake_case_string'
      expected_output = 'snakeCaseString'
      expect(Line::Bot::V2::Utils.camelize(input)).to eq(expected_output)
    end

    it 'handles strings without underscores' do
      input = 'simple'
      expected_output = 'simple'
      expect(Line::Bot::V2::Utils.camelize(input)).to eq(expected_output)
    end

    it 'handles empty strings' do
      input = ''
      expected_output = nil
      expect(Line::Bot::V2::Utils.camelize(input)).to eq(expected_output)
    end
  end
end
