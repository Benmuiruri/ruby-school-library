require './person'
require './student'
require './teacher'
require './classroom'
require './book'
require './rental'

class App
  attr_accessor :books, :people

  def initialize
  @people = []
    @books = []
    @rentals = []
    @class = Classroom.new('Grade 7')
  end
  
  def add_person(person_option, age, name, arg)
    case person_option
    when 1
      student = Student.new(age, name, @class, arg)
      @people << student unless @people.include?(student)
    when 2
      teacher = Teacher.new(age, name, arg)
      @people << teacher unless @people.include?(teacher)
    end
  end

  def add_book(title, author)
    book = Book.new(title, author)
    @books << book unless @books.include?(book)
  end

  def add_rental(date, person_id, book_id)
    @book = @books[book_id]
    @person = @people[person_id]
    rental = Rental.new(date, @person, @book)
    @rentals << rental unless @rentals.include?(rental)
  end

end
