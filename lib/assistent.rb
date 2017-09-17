class Assistent
  class Nobody
    def name
    end

    def wants_to_say
    end
  end

  attr_reader :instance

  def initialize(type:)
    @instance = if type.present?
      "Assistent::#{type.camelize}".constantize.new
    else
      Nobody.new
    end
  end

  def name
    instance.name
  end

  def wants_to_say
    text = instance.wants_to_say
    return if text.blank?

    "#{instance.name}: #{text}"
  end
end
