require_relative '../config/environment'

class JokeCLI
    
    attr_accessor :user

    def initialize

    end

    def run
        puts "Welcome to the game"
        puts
        present_menu
    end

    def present_menu_list
        puts "1. Give me a random joke"
        puts "2. Quit"
        puts
    end

    def present_menu
        is_running = true
        while is_running 
            present_menu_list
            choice = STDIN.gets.chomp.to_i
            if choice == 1
                get_random_joke
            elsif choice == 2
                is_running = false
            end
        end
    end

    def self.check_username(user_input)
        user_name = User.find_by(name: user_input)
        binding.pry
        if user_name == nil
            User.create(name: user_name)
        else
            @user = user_name
        end
    end

    def self.add_favorite

    end

    def get_random_joke
        full_joke = Joke.all.sample 
        puts full_joke[:setup]
        puts full_joke[:punchline]
        puts
    end

    def self.get_joke_by_category(input_category)

    end






end