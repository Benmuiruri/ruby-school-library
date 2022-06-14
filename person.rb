require "./nameable"

class Person < Nameable
  attr_reader :id, :name, :age
  attr_writer :name, :age

  def initialize(age, name = 'Unknown', parent_permission: true)
    @id = Random.rand(1..1000)
    @name = name
    @age = age
    @parent_permission = parent_permission
  end

  def can_use_services?
    of_age? || @parent_permission
  end

  def correct_name
    name
  end

  private

  def of_age?
    @age >= 18
  end
end

class Decorator < Nameable
  attr_accessor :component

  def initialize(component)
    @component = component
  end

  def correct_name
    @component.correct_name
  end
end

class CapitalizeDecorator < Decorator
  def correct_name
    @component.correct_name.capitalize
  end
end

class TrimmerDecorator < Decorator
  def correct_name
    @component.correct_name.capitalize[0..9]
  end
end
