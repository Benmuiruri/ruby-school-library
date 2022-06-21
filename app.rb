require './person'
require './student'
require './teacher'
require './classroom'
require './book'
require './rental'
require 'pry'

class App
  attr_accessor :books, :people

  def initialize
    @books = []
    @people = []
    @rentals = []
    @class = Classroom.new('Grade 7')
  end

   def all_books
    books
  end

  def all_people
    people
  end
  
  def add_person(person)
      @people << person unless @people.include?(person)
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
