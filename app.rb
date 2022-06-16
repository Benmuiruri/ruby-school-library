require './teacher'
require './student'
require './book'
require './rental'
require './classroom'

class App
  def initialize
    @people = []
    @books = []
    @rentals = []
  end

  def run
    puts 'Welcome to School Library App (Another Ben Project)'
    sleep 0.5
    display_options
  end
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
    display_options
  when '2'
    puts 'Loading the list of all people...'
    sleep 0.75
    display_options
  when '3'
    puts 'Great, let\'s add a person...'
    sleep 0.5
    create_person
  when '4'
    puts 'Great, let\'s add a book...'
    sleep 0.5
    display_options
  when '5'
    puts 'Great, let\'s rent a book...'
    sleep 0.5
    display_options
  when '6'
    puts 'Loading the list of all rented books...'
    sleep 0.75
    display_options
  when '7'
    puts 'Thank you for using the School Library App. See you next time!'
    sleep 0.75
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

def person_name_input
  print 'Name: '
  name = gets.chomp
  name.empty? ? person_name_input : name
end

def person_age_input
  print 'Age: '
  age = gets.chomp.to_i
  (1..130).include?(age) ? age : person_age_input
end

def create_student
  age = person_age_input
  name = person_name_input
  print 'Has parent permission? [Y/N]: '
  parent_permission = gets.chomp.downcase
  # puts `#{age} #{name} #{parent_permission}, #{@class}`
  student = Student.new(age, name, parent_permission)
  # student = Student.new(age, @class, name, parent_permission)
  # @people << student
  # puts `Student #{student.name} created successfully`
  # sleep 0.5
  # display_options
end

def create_teacher
  age = person_age_input
  name = person_name_input
  print 'Area of specialization: '
  specialization = gets.chomp
  teacher = Teacher.new(age, name, specialization)
  @people << teacher
  puts `Teacher #{student.name} created successfully`
  sleep 0.5
  display_options
end
