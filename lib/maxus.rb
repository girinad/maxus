require "maxus/version"

module Maxus
  autoload 'Builder', 'maxus/builder'
  autoload 'Creator', 'maxus/creator'

  def self.build(&block)
    result = Builder.build(&block)
    Creator.create(result)
  end

  class EmptyBlock < RuntimeError ; end
end
