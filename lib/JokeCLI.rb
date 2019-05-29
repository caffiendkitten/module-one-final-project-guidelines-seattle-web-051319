require_relative '../config/environment'

class JokeCLI
    
    attr_accessor :user, :full_joke, :favorites

    def initialize

    end

    def run
        system('clear')
        puts "Welcome to the game"
        puts
        get_user
        present_menu
    end

    def get_user
        puts "What's your name?"
        user_name = STDIN.gets.chomp.downcase
        name = User.find_by(name: user_name)
        if name
            @user = name
            system("clear")
            puts "Welcome back #{user_name}!"
        else
            @user = User.create(name: user_name)
            sstem('clear')
            puts "Hello #{user_name}"
        end
        puts
    end

    def present_menu_list
        puts "1. Give me a random joke"
        puts "2. Get a joke by category"
        puts "3. List my favorites"
        puts "4. Quit"
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
                get_joke_by_category
            elsif choice == 3
                list_favorites
            elsif choice == 4
                is_running = false
            end
        end
    end

    def get_random_joke
        system('clear')
        @full_joke = Joke.all.sample 
        puts @full_joke[:setup]
        puts @full_joke[:punchline].strip
        puts
        ask_for_favorite
    end

    def ask_for_favorite
        puts "Do you wanna add this to your favorites?"
        puts "1. Yes!"
        puts "2. Not particiulary."
        input = STDIN.gets.chomp.to_i
        if input == 1
            Favorite.create(user_id: @user.id, joke_id: @full_joke[:id])
        else
            system('clear')
        end
    end

    def get_joke_by_category
        system('clear')
        puts "Which category would you like?"
        puts
        puts "1. General Humor"
        puts "2. Cringy Programming Jokes"
        puts "3. Knock Knock Jokes"
        
        input = STDIN.gets.chomp.to_i
        if input == 1 
            system('clear')
            general_jokes = Joke.all.where(category: 'general')
            general_joke = general_jokes.sample
            puts general_joke[:setup]
            puts general_joke[:punchline]
            puts
            ask_for_favorite
        elsif input == 2
            system('clear')
            programming_jokes = Joke.all.where(category: 'programming')
            programming_joke = programming_jokes.sample
            puts programming_joke[:setup]
            puts programming_joke[:punchline]
            puts
            ask_for_favorite
        elsif
            input == 3
            system('clear')
            knock_jokes = Joke.all.where(category: 'knock-knock')
            knock_knock = knock_jokes.sample
            puts knock_knock[:setup]
            puts knock_knock[:punchline]
            puts
            ask_for_favorite
        end
    end

    def list_favorites
        system('clear')
        @favorites = []
        @user = User.find(@user.id)
        @user.favorites.each do |x|
            favorite_joke = Joke.find_by(id: x.joke_id)
            favorites << favorite_joke
        end
        if favorites.length > 0
            favorites.each.with_index do |joke, index|
                puts "#{index + 1}. #{joke.setup}"
                puts "      -#{joke.punchline}"
                puts
            end
        else
            puts "You haven't saved any jokes yet!"
            puts
        end
    end 






end