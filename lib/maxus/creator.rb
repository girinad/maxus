module Maxus

  class Creator

    attr_reader :_result

    def self.create(envs)
      creator = new(envs)
      creator._result
    end

    def initialize(envs)
      @_result = Object.new

      envs.each do |name, data|
        env = create_object(name, data)
        @_result = create_method(name, env, @_result)
      end
    end

    def create_object (name, data)
      env = Object.new
      data.each do |name, value|

        if value.is_a?(Array)
          env = create_method(name, value.first, env)
        else
          obj = create_object(name, value)
          env = create_method(name, obj, env)
        end
      end
      env
    end

    def create_method(name, value, obj)
      obj.define_singleton_method(name) {value}
      obj
    end

  end

end