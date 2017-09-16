module DryValidationForm
  attr_reader :result

  class ValidationError < StandardError; end

  def initialize(params)
    @result = after_validate(validate(before_validate(params)))
  end

  def valid?
    result.success?
  end

  def validate!
    raise ValidationError, error_message if result.failure?
  end

  def attributes
    result.output
  end

  def errors
    result.messages(full: true).values.flatten
  end

  def error_message
    errors.join('. ')
  end

  private

  def before_validate(params)
    params.to_unsafe_hash
  end

  def after_validate(result)
    result
  end

  def validate(params)
    schema.call(params)
  end

  def schema
    self.class::Schema
  end
end
