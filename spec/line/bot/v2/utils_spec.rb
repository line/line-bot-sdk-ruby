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

    it 'fixes reserved words' do
      input = { '_and' => 123, '___FILE__' => 'example', '_hoge': 123 }
      expected_output = { and: 123, __FILE__: 'example', _hoge: 123 }
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

    it 'converts hashes in array with snake_case keys' do
      input = [{ outer_key: { inner_key: 'value', inner_array: [{ core_key: 'value' }] } }]
      expected_output = [{ outerKey: { innerKey: 'value', innerArray: [{ coreKey: 'value' }] } }]
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

    it 'removes empty hashes, but keeps empty array' do
      input = { key1: [], key2: {} }
      expected_output = { key1: []}
      expect(Line::Bot::V2::Utils.deep_compact(input)).to eq(expected_output)
    end

    it 'compacts nested structures' do
      input = { key1: { key2: nil, key3: 'value' }, key4: [] }
      expected_output = { key1: { key3: 'value' }, key4: [] }
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

  describe '.deep_convert_reserved_words' do
    before do
      stub_const('Line::Bot::V2::RESERVED_WORDS', %i(id type))
    end

    it 'prefixes reserved keys with an underscore' do
      input = { 'id' => 123, 'other' => 'value', 'type' => 'example' }
      expected_output = { '_id' => 123, 'other' => 'value', '_type' => 'example' }
      expect(Line::Bot::V2::Utils.deep_convert_reserved_words(input)).to eq(expected_output)
    end

    it 'handles nested hashes' do
      input = {
        'id' => 123,
        'nested' => { 'type' => 'inner', 'normalKey' => 'value' }
      }
      expected_output = {
        '_id' => 123,
        'nested' => { '_type' => 'inner', 'normalKey' => 'value' }
      }
      expect(Line::Bot::V2::Utils.deep_convert_reserved_words(input)).to eq(expected_output)
    end

    it 'handles arrays of hashes' do
      input = [
        { 'id' => 1, 'type' => 'one' },
        { 'id' => 2, 'otherKey' => 'value' }
      ]
      expected_output = [
        { '_id' => 1, '_type' => 'one' },
        { '_id' => 2, 'otherKey' => 'value' }
      ]
      expect(Line::Bot::V2::Utils.deep_convert_reserved_words(input)).to eq(expected_output)
    end

    it 'does not modify non-reserved words' do
      input = { 'hello' => 'world' }
      expected_output = { 'hello' => 'world' }
      expect(Line::Bot::V2::Utils.deep_convert_reserved_words(input)).to eq(expected_output)
    end
  end

  describe '.hash_to_struct' do
    it 'converts a simple hash to a struct' do
      input = { foo: 'bar', baz: 'qux' }
      result = Line::Bot::V2::Utils.hash_to_struct(input)

      expect(result).to be_a(Struct)
      expect(result.foo).to eq('bar')
      expect(result.baz).to eq('qux')
    end

    it 'handles nested hashes' do
      input = {
        outer: {
          inner: 'value'
        },
        another_key: 123
      }
      result = Line::Bot::V2::Utils.hash_to_struct(input)

      expect(result.outer).to be_a(Struct)
      expect(result.outer.inner).to eq('value')
      expect(result.another_key).to eq(123)
    end

    it 'includes arrays as-is' do
      input = {
        list: [1, 2, 3],
        info: {
          data: [4, 5]
        }
      }
      result = Line::Bot::V2::Utils.hash_to_struct(input)

      expect(result.list).to eq([1, 2, 3])
      expect(result.info.data).to eq([4, 5])
    end
  end

  describe '.deep_symbolize' do
    it 'converts string keys to symbol keys' do
      input = { 'foo' => 'bar', 'baz' => 'qux' }
      expected_output = { foo: 'bar', baz: 'qux' }
      expect(Line::Bot::V2::Utils.deep_symbolize(input)).to eq(expected_output)
    end

    it 'handles nested hashes' do
      input = { 'outer' => { 'inner' => 'value' } }
      expected_output = { outer: { inner: 'value' } }
      expect(Line::Bot::V2::Utils.deep_symbolize(input)).to eq(expected_output)
    end

    it 'handles arrays of hashes' do
      input = [
        { 'foo' => 'bar' },
        { 'baz' => 'qux' }
      ]
      expected_output = [
        { foo: 'bar' },
        { baz: 'qux' }
      ]
      expect(Line::Bot::V2::Utils.deep_symbolize(input)).to eq(expected_output)
    end

    it 'does not modify non-hash values' do
      input = 'string'
      expected_output = 'string'
      expect(Line::Bot::V2::Utils.deep_symbolize(input)).to eq(expected_output)
    end
  end
end
