require 'pry'

def create_service(option)
  case option
  when 3
    create_person
  when 4
    create_book
  when 5
    create_rental
  end
end

def create_person
  print 'Do you want to create a student (1) or a teacher (2) [Input the number]: '
  person_option = gets.chomp.to_i

  case person_option
  when 1
    create_student(person_option)
  when 2
    create_teacher(person_option)
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

def create_student(person_option)
  age = person_age_input
  name = person_name_input
  print 'Has parent permission? [Y/N]: '
  _parent_permission = gets.chomp.downcase
  puts 'Thank you for giving permission'
  student = Student.new(age, name, @my_app.class)
  @my_app.add_person(student)
  puts "Student #{name} created successfully"
  sleep 0.5
end

def create_teacher(person_option)
  age = person_age_input
  name = person_name_input
  print 'Area of specialization [e.g. Physics]: '
  specialization = gets.chomp
  teacher = Teacher.new(age, specialization, name)
  @my_app.add_person(teacher)
  puts "Teacher #{name} created successfully"
  sleep 0.5
end

def create_book
  print 'Enter Title: '
  title = gets.chomp
  print 'Enter Author Name: '
  author = gets.chomp
  @my_app.add_book(title, author)
  puts "Book #{title} created successfully"
end

def create_rental
  if @my_app.books.empty?
    puts "Please add a book first\n\n"
    create_book
  elsif @my_app.people.empty?
    puts "Please add a person first\n\n"
    create_person
  else
    puts 'Select a book from the following list of books [Enter book ID]: '
    @my_app.books.each_with_index do |book, index|
      puts "Index: #{index}) Title: #{book.title} by Author: #{book.author}"
    end
    book_id = gets.chomp.to_i
    puts 'Select the person renting the book [Enter Person Index not ID]: '
    @my_app.people.each_with_index do |person, index|
      puts "Index: #{index}) [#{person.class}] ID: #{person.id}, Name: #{person.name}, Age: #{person.age}"
    end
    person_id = gets.chomp.to_i
    puts 'Enter date (Format: 2020/05/04): '
    date = gets.chomp.to_s
    @my_app.add_rental(date, person_id, book_id)
    puts "Book: #{@books[book_id].title} rented successfully\n"
    sleep 0.75
  end
end
