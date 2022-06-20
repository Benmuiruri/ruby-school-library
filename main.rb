require_relative 'app'
require_relative 'create_service'
require_relative 'list_service'

@my_app = App.new

def main
  display_options
  option_no = gets.chomp.to_i
  puts "You have choosen option #{option_no}!"
  perform_action(option_no)
  sleep 0.5
end

def display_options
  puts "Welcome to School Library App\n\n"
  puts 'Please choose an option by entering a number:'
  puts '1 - List all books'
  puts '2 - List all people'
  puts '3 - Create a person'
  puts '4 - Create a book'
  puts '5 - Create a rental'
  puts '6 - List all rentals for a given person id'
  puts '7 - Exit'
end

def perform_action(option)
  case option
  when 1..2, 6
    list_service(option)
    main
  when 3..5
    create_service(option)
    main
  when 7
    puts 'Thank you for using the School Library App. See you next time!'
    sleep 0.75
    exit
  else
    puts 'Invalid choice! Please enter a valid choice (1-7)'
  end
end

main
