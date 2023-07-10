=begin
#LINE Messaging API(Insight)

#This document describes LINE Messaging API(Insight).

The version of the OpenAPI document: 0.0.1

Generated by: https://openapi-generator.tech
OpenAPI Generator version: 6.6.0

=end

require 'date'
require 'time'

module LINE::Client::Insight
  class GetMessageEventResponseMessage
    # Bubble's serial number.
    attr_accessor :seq

    # Number of times the bubble was displayed.
    attr_accessor :impression

    # Number of times audio or video in the bubble started playing.
    attr_accessor :media_played

    # Number of times audio or video in the bubble started playing and was played 25% of the total time.
    attr_accessor :media_played25_percent

    # Number of times audio or video in the bubble started playing and was played 50% of the total time.
    attr_accessor :media_played50_percent

    # Number of times audio or video in the bubble started playing and was played 75% of the total time.
    attr_accessor :media_played75_percent

    # Number of times audio or video in the bubble started playing and was played 100% of the total time.
    attr_accessor :media_played100_percent

    # Number of users that started playing audio or video in the bubble.
    attr_accessor :unique_media_played

    # Number of users that started playing audio or video in the bubble and played 25% of the total time.
    attr_accessor :unique_media_played25_percent

    # Number of users that started playing audio or video in the bubble and played 50% of the total time.
    attr_accessor :unique_media_played50_percent

    # Number of users that started playing audio or video in the bubble and played 75% of the total time.
    attr_accessor :unique_media_played75_percent

    # Number of users that started playing audio or video in the bubble and played 100% of the total time.
    attr_accessor :unique_media_played100_percent

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'seq' => :'seq',
        :'impression' => :'impression',
        :'media_played' => :'mediaPlayed',
        :'media_played25_percent' => :'mediaPlayed25Percent',
        :'media_played50_percent' => :'mediaPlayed50Percent',
        :'media_played75_percent' => :'mediaPlayed75Percent',
        :'media_played100_percent' => :'mediaPlayed100Percent',
        :'unique_media_played' => :'uniqueMediaPlayed',
        :'unique_media_played25_percent' => :'uniqueMediaPlayed25Percent',
        :'unique_media_played50_percent' => :'uniqueMediaPlayed50Percent',
        :'unique_media_played75_percent' => :'uniqueMediaPlayed75Percent',
        :'unique_media_played100_percent' => :'uniqueMediaPlayed100Percent'
      }
    end

    # Returns all the JSON keys this model knows about
    def self.acceptable_attributes
      attribute_map.values
    end

    # Attribute type mapping.
    def self.openapi_types
      {
        :'seq' => :'Integer',
        :'impression' => :'Integer',
        :'media_played' => :'Integer',
        :'media_played25_percent' => :'Integer',
        :'media_played50_percent' => :'Integer',
        :'media_played75_percent' => :'Integer',
        :'media_played100_percent' => :'Integer',
        :'unique_media_played' => :'Integer',
        :'unique_media_played25_percent' => :'Integer',
        :'unique_media_played50_percent' => :'Integer',
        :'unique_media_played75_percent' => :'Integer',
        :'unique_media_played100_percent' => :'Integer'
      }
    end

    # List of attributes with nullable: true
    def self.openapi_nullable
      Set.new([
        :'impression',
        :'media_played',
        :'media_played25_percent',
        :'media_played50_percent',
        :'media_played75_percent',
        :'media_played100_percent',
        :'unique_media_played',
        :'unique_media_played25_percent',
        :'unique_media_played50_percent',
        :'unique_media_played75_percent',
        :'unique_media_played100_percent'
      ])
    end

    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    def initialize(attributes = {})
      if (!attributes.is_a?(Hash))
        fail ArgumentError, "The input argument (attributes) must be a hash in `LINE::Client::Insight::GetMessageEventResponseMessage` initialize method"
      end

      # check to see if the attribute exists and convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h|
        if (!self.class.attribute_map.key?(k.to_sym))
          fail ArgumentError, "`#{k}` is not a valid attribute in `LINE::Client::Insight::GetMessageEventResponseMessage`. Please check the name to make sure it's valid. List of attributes: " + self.class.attribute_map.keys.inspect
        end
        h[k.to_sym] = v
      }

      if attributes.key?(:'seq')
        self.seq = attributes[:'seq']
      end

      if attributes.key?(:'impression')
        self.impression = attributes[:'impression']
      end

      if attributes.key?(:'media_played')
        self.media_played = attributes[:'media_played']
      end

      if attributes.key?(:'media_played25_percent')
        self.media_played25_percent = attributes[:'media_played25_percent']
      end

      if attributes.key?(:'media_played50_percent')
        self.media_played50_percent = attributes[:'media_played50_percent']
      end

      if attributes.key?(:'media_played75_percent')
        self.media_played75_percent = attributes[:'media_played75_percent']
      end

      if attributes.key?(:'media_played100_percent')
        self.media_played100_percent = attributes[:'media_played100_percent']
      end

      if attributes.key?(:'unique_media_played')
        self.unique_media_played = attributes[:'unique_media_played']
      end

      if attributes.key?(:'unique_media_played25_percent')
        self.unique_media_played25_percent = attributes[:'unique_media_played25_percent']
      end

      if attributes.key?(:'unique_media_played50_percent')
        self.unique_media_played50_percent = attributes[:'unique_media_played50_percent']
      end

      if attributes.key?(:'unique_media_played75_percent')
        self.unique_media_played75_percent = attributes[:'unique_media_played75_percent']
      end

      if attributes.key?(:'unique_media_played100_percent')
        self.unique_media_played100_percent = attributes[:'unique_media_played100_percent']
      end
    end

    # Show invalid properties with the reasons. Usually used together with valid?
    # @return Array for valid properties with the reasons
    def list_invalid_properties
      invalid_properties = Array.new
      invalid_properties
    end

    # Check to see if the all the properties in the model are valid
    # @return true if the model is valid
    def valid?
      true
    end

    # Checks equality by comparing each attribute.
    # @param [Object] Object to be compared
    def ==(o)
      return true if self.equal?(o)
      self.class == o.class &&
          seq == o.seq &&
          impression == o.impression &&
          media_played == o.media_played &&
          media_played25_percent == o.media_played25_percent &&
          media_played50_percent == o.media_played50_percent &&
          media_played75_percent == o.media_played75_percent &&
          media_played100_percent == o.media_played100_percent &&
          unique_media_played == o.unique_media_played &&
          unique_media_played25_percent == o.unique_media_played25_percent &&
          unique_media_played50_percent == o.unique_media_played50_percent &&
          unique_media_played75_percent == o.unique_media_played75_percent &&
          unique_media_played100_percent == o.unique_media_played100_percent
    end

    # @see the `==` method
    # @param [Object] Object to be compared
    def eql?(o)
      self == o
    end

    # Calculates hash code according to all attributes.
    # @return [Integer] Hash code
    def hash
      [seq, impression, media_played, media_played25_percent, media_played50_percent, media_played75_percent, media_played100_percent, unique_media_played, unique_media_played25_percent, unique_media_played50_percent, unique_media_played75_percent, unique_media_played100_percent].hash
    end

    # Builds the object from hash
    # @param [Hash] attributes Model attributes in the form of hash
    # @return [Object] Returns the model itself
    def self.build_from_hash(attributes)
      new.build_from_hash(attributes)
    end

    # Builds the object from hash
    # @param [Hash] attributes Model attributes in the form of hash
    # @return [Object] Returns the model itself
    def build_from_hash(attributes)
      return nil unless attributes.is_a?(Hash)
      attributes = attributes.transform_keys(&:to_sym)
      self.class.openapi_types.each_pair do |key, type|
        if attributes[self.class.attribute_map[key]].nil? && self.class.openapi_nullable.include?(key)
          self.send("#{key}=", nil)
        elsif type =~ /\AArray<(.*)>/i
          # check to ensure the input is an array given that the attribute
          # is documented as an array but the input is not
          if attributes[self.class.attribute_map[key]].is_a?(Array)
            self.send("#{key}=", attributes[self.class.attribute_map[key]].map { |v| _deserialize($1, v) })
          end
        elsif !attributes[self.class.attribute_map[key]].nil?
          self.send("#{key}=", _deserialize(type, attributes[self.class.attribute_map[key]]))
        end
      end

      self
    end

    # Deserializes the data based on type
    # @param string type Data type
    # @param string value Value to be deserialized
    # @return [Object] Deserialized data
    def _deserialize(type, value)
      case type.to_sym
      when :Time
        Time.parse(value)
      when :Date
        Date.parse(value)
      when :String
        value.to_s
      when :Integer
        value.to_i
      when :Float
        value.to_f
      when :Boolean
        if value.to_s =~ /\A(true|t|yes|y|1)\z/i
          true
        else
          false
        end
      when :Object
        # generic object (usually a Hash), return directly
        value
      when /\AArray<(?<inner_type>.+)>\z/
        inner_type = Regexp.last_match[:inner_type]
        value.map { |v| _deserialize(inner_type, v) }
      when /\AHash<(?<k_type>.+?), (?<v_type>.+)>\z/
        k_type = Regexp.last_match[:k_type]
        v_type = Regexp.last_match[:v_type]
        {}.tap do |hash|
          value.each do |k, v|
            hash[_deserialize(k_type, k)] = _deserialize(v_type, v)
          end
        end
      else # model
        # models (e.g. Pet) or oneOf
        klass = LINE::Client::Insight.const_get(type)
        klass.respond_to?(:openapi_one_of) ? klass.build(value) : klass.build_from_hash(value)
      end
    end

    # Returns the string representation of the object
    # @return [String] String presentation of the object
    def to_s
      to_hash.to_s
    end

    # to_body is an alias to to_hash (backward compatibility)
    # @return [Hash] Returns the object in the form of hash
    def to_body
      to_hash
    end

    # Returns the object in the form of hash
    # @return [Hash] Returns the object in the form of hash
    def to_hash
      hash = {}
      self.class.attribute_map.each_pair do |attr, param|
        value = self.send(attr)
        if value.nil?
          is_nullable = self.class.openapi_nullable.include?(attr)
          next if !is_nullable || (is_nullable && !instance_variable_defined?(:"@#{attr}"))
        end

        hash[param] = _to_hash(value)
      end
      hash
    end

    # Outputs non-array value in the form of hash
    # For object, use to_hash. Otherwise, just return the value
    # @param [Object] value Any valid value
    # @return [Hash] Returns the value in the form of hash
    def _to_hash(value)
      if value.is_a?(Array)
        value.compact.map { |v| _to_hash(v) }
      elsif value.is_a?(Hash)
        {}.tap do |hash|
          value.each { |k, v| hash[k] = _to_hash(v) }
        end
      elsif value.respond_to? :to_hash
        value.to_hash
      else
        value
      end
    end

  end

end
