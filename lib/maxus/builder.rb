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
      @_inheritance = {}

      instance_eval &block

      if @_inheritance
        @_inheritance.each do |child, parent|
          @_hash[child] = hash_deep_merge(@_hash[parent], @_hash[child], parent)
        end
      end

    end

    def env(name, parent = nil, &block)
      @_hash[name.to_sym] = Proxy.build(&block)

      @_inheritance[name] = parent[:parent] if parent
    end

    def hash_deep_merge(parent_hash, child_hash, parent)
      child_hash = parent_hash.deep_merge(child_hash)
      parent = @_inheritance[parent]

      if parent
        parent_hash = @_hash[parent]
        hash_deep_merge(parent_hash, child_hash, parent)
      end

      child_hash
    end

  end

end