class Presenter < SimpleDelegator

  def initialize(obj)
    obj.extend(self.class::Decorators) if defined?(self.class::Decorators)

    super(obj)
  end

  def to_json(opts = {})
    merge_decorators(opts)

    super(opts)
  end

  def as_json(opts = {})
    merge_decorators(opts)

    super(opts)
  end

  protected

  def merge_decorators(opts = {})
    return unless defined?(self.class::Decorators)

    opts.merge!(methods: self.class::Decorators.instance_methods)
  end

end
