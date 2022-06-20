require './person'
require './student'
require './teacher'
require './classroom'
require './book'
require './rental'
# rubocop:disable Metrics

class App
  def initialize
    @people = []
    @books = []
    @rentals = []
    @class = Classroom.new('Grade 7')
  end

  def run
    puts "Welcome to School Library App (Another Ben Project)\n\n"
    sleep 0.5
    display_options
  end

  def display_options
    puts 'Please choose an option by entering a number:'
    puts '1 - List all books'
    puts '2 - List all people'
    puts '3 - Create a person'
    puts '4 - Create a book'
    puts '5 - Create a rental'
    puts '6 - List all rentals for a given person id'
    puts '7 - Exit'

    option_no = gets.chomp
    puts "You have choosen option #{option_no}!"
    perform_action(option_no)
    sleep 0.5
  end

  def perform_action(option)
    case option
    when '1'
      puts 'Loading the list of all books...'
      sleep 0.75
      list_books
    when '2'
      puts 'Loading the list of all people...'
      sleep 0.75
      list_people
    when '3'
      puts 'Great, let\'s add a person...'
      sleep 0.5
      create_person
    when '4'
      puts 'Great, let\'s add a book...'
      sleep 0.5
      create_book
    when '5'
      puts 'Great, let\'s rent a book...'
      sleep 0.5
      create_rental
    when '6'
      puts 'List all rentals for a given person id'
      sleep 0.75
      list_rentals
    when '7'
      puts 'Thank you for using the School Library App. See you next time!'
      sleep 0.75
      exit
    else
      puts 'Invalid choice! Please enter a valid choice (1-7)'
    end
  end

  def create_person
    print 'Do you want to create a student (1) or a teacher (2) [Input the number]: '
    person_option = gets.chomp

    case person_option
    when '1'
      create_student
    when '2'
      create_teacher
    else
      puts 'Invalid input: Please type 1 or 2'
      create_person
    end
  end

  def person_age_input
    print 'Age: '
    age = gets.chomp.to_i
    (1..130).include?(age) ? age : person_age_input
  end

  def person_name_input
    print 'Name: '
    name = gets.chomp
    name.empty? ? person_name_input : name
  end

  def create_student
    age = person_age_input
    name = person_name_input
    print 'Has parent permission? [Y/N]: '
    parent_permission = gets.chomp.downcase
    puts 'Thank you for giving permission' if parent_permission
    student = Student.new(age, name, @class)
    @people << student
    puts "Student #{name} created successfully"
    sleep 0.5
    display_options
  end
end

def create_teacher
  age = person_age_input
  name = person_name_input
  print 'Area of specialization [e.g. Physics]: '
  specialization = gets.chomp
  teacher = Teacher.new(age, name, specialization)
  @people << teacher
  puts "Teacher #{name} created successfully"
  sleep 0.5
  display_options
end

def list_people
  puts "There are no people in the library. Please add a student or teacher\n" if @people.empty?
  @people.each_with_index do |person, index|
    puts "#{index} [#{person.class}] ID: #{person.id}, Name: #{person.name}, Age: #{person.age}"
  end
  sleep 0.75
  display_options
end

def create_book
  print 'Enter Title: '
  title = gets.chomp

  print 'Enter Author Name: '
  author = gets.chomp

  book = Book.new(title, author)
  @books << book

  puts "Book #{title} created successfully"
  display_options
end

def list_books
  puts "There are no books in the library. Please add a book\n" if @books.empty?
  @books.each_with_index { |book, index| puts "#{index}) Title: #{book.title} by Author: #{book.author}" }
  sleep 0.75
  display_options
end

def create_rental
  if @books.empty?
    puts "Please add a book first\n\n"
    create_book
  elsif @people.empty?
    puts "Please add a person first\n\n"
    create_person
  else
    puts 'Select a book from the following list of books [Enter book ID]: '
    @books.each_with_index { |book, index| puts "Index: #{index}) Title: #{book.title} by Author: #{book.author}" }
    book_id = gets.chomp.to_i
    puts 'Select the person renting the book [Enter Person Index not ID]: '
    @people.each_with_index do |person, index|
      puts "Index: #{index}) [#{person.class}] ID: #{person.id}, Name: #{person.name}, Age: #{person.age}"
    end
    person_id = gets.chomp.to_i
    puts 'Enter date (Format: 2020/05/04): '
    date = gets.chomp.to_s

    rental = Rental.new(date, @people[person_id], @books[book_id])
    @rentals << rental
    puts "Book: #{@books[book_id].title} rented successfully\n"
    sleep 0.75
  end
  display_options
end

def list_rentals
  if @rentals.empty?
    puts 'Please add a rental first.'
    create_rental
  else
    print 'Enter ID of person: '
    person_id = gets.chomp
    sleep 0.75
    binding.pry
    rental_list = @rentals.select { |rental| rental.person.id == person_id }
    if rental_list.empty?
      puts "No rentals found for person with ID: #{person_id}."
      puts "These are the available people in the library database\n\n"
      @people.each_with_index do |person, index|
        puts "Index: #{index}) [#{person.class}] ID: #{person.id}, Name: #{person.name}, Age: #{person.age}"
      end
    else
      puts "These are the rented books for Selected person\n\n"
      rental_list.each do |rental|
        puts "#{rental.person.name} rented \"#{rental.book.title}\" by \"#{rental.book.author}\" on #{rental.date},"
      end
    end
  end
  display_options
end
# rubocop:enable Metrics
