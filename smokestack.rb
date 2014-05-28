class Factory < BasicObject
  attr_reader :attributes

  def initialize
    @attributes = {}
  end

  def method_missing(name, *args, &block)
    attributes[name] = args[0]
  end
end

class DefinitionProxy
  def factory(factory_class, &block)
    factory = Factory.new
    if block_given?
      factory.instance_eval(&block)
    end
    World.registry[factory_class] = factory
  end
end

module World
  @registry = {}

  def self.registry
    @registry
  end

  def self.define(&block)
    definition_proxy = DefinitionProxy.new
    definition_proxy.instance_eval(&block)
  end

  def self.build(factory_class, overrides = {})
    instance = factory_class.new

    factory = registry[factory_class]
    attributes = factory.attributes.merge(overrides)
    attributes.each do |attribute_name, value|
      instance.send("#{attribute_name}=", value)
    end

    instance
  end
end

class User
  attr_accessor :name, :nickname
end

