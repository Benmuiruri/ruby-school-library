def list_service(option)
  case option
  when 1
    list_books
    main
  when 2
    list_people
    main
  when 6
    list_rental_by_person_id
    main
  end
end

def list_books
  puts "There are no books in the library. Please add a book\n" if @my_app.books.empty?
  @my_app.books.each_with_index { |book, index| puts "#{index}) Title: #{book.title} by Author: #{book.author}" }
  sleep 0.75
end

def list_people
  puts "There are no people in the library. Please add a student or teacher\n" if @my_app.people.empty?
  @my_app.people.each_with_index do |person, index|
    puts "#{index} [#{person.class}] ID: #{person.id}, Name: #{person.name}, Age: #{person.age}"
  end
  sleep 0.75
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
end
