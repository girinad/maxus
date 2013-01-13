module Maxus

  class Creator

    attr_reader :_result

    def self.create(hash)
      creator = new(hash)
      creator._result
    end

    def initialize(hash)
      @_result = Object.new

      hash.each do |name, value|
        @_result = create_smth(name, value, @_result)
      end
    end

    def create_object (data)
      env = Object.new
      data.each do |name, value|
        env = create_smth(name, value, env)
      end
      env
    end

    def create_method(name, value, obj)
      obj.define_singleton_method(name) {value}
      obj
    end

    def create_smth(name, value, result)
      if value.is_a?(Array)
        result = create_method(name, value.first, result)
      else
        obj = create_object(value)
        result = create_method(name, obj, result)
      end

      result
    end

  end

end