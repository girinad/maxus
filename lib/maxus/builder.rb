module Maxus
  autoload 'Proxy', 'maxus/proxy'

  class Builder

    attr_reader :_hash

    def self.build(&block)
      builder = new(&block)

      if builder._hash.empty?
        raise EmptyBlock
      end

      builder._hash
    end

    def initialize(&block)
      @_hash = {}
      instance_eval &block
    end

    def env(name, &block)
      @_hash[name.to_sym] = Proxy.build(&block)
    end

  end

end