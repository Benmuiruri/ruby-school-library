class Person
  def initialize(name = "Unknown", age, parent_permission = true)
    @id = Random.rand(1..1000)
    @name = name
    @age = age
  end
  attr_reader :id, :name, :age
  attr_writer :name, :age

  def can_use_services?
    is_of_age? || parent_permission
  end

  private
  def is_of_age?
    @age >= 18 ? true : false
   end
  end
end 