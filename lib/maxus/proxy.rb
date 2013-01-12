module Maxus

  class Proxy < BasicObject

    attr_reader :_result

    def self.build(&block)
      proxy = new(&block)
      proxy._result
    end

    def initialize(&block)
      @_result ||= {}
      instance_eval(&block)
    end

    def method_missing (name, *args, &block)

      key = name.to_sym
      value = args

      @_result[key] = block ? Proxy.build(&block) :  value

    end


  end

end