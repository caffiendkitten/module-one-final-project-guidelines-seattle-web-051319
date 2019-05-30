require_relative '../config/environment'

class JokeCLI
    
    attr_accessor :user, :full_joke, :favorites, :dislikes, :excluded_list

    def initialize
        @full_joke = full_joke
        @excluded_list = excluded_list
    end

    def run
        system('clear')
        Ascii.welcome_page
        puts "Welcome to Joke Generator!"
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
            system('clear')
            puts "Hello #{user_name}! What would you like to do?"
        end
        puts
    end

    def present_menu_list
        puts "1. Give me a random Joke"
        puts "2. Get a Joke by Category"
        puts "3. List My Favorites"
        puts "4. Clear My favorites"
        puts "5. List Dislikes"
        puts "6. Clear Dislikes"
        puts "7. Quit"
    end

    def present_menu
        is_running = true
        while is_running 
            present_menu_list
            choice = STDIN.gets.chomp.to_i
            if choice == 1
                get_joke_excluding_dislikes
            elsif choice == 2
                get_joke_by_category
            elsif choice == 3
                list_favorites
            elsif choice == 4
                clear_favorites
            elsif choice == 5
                list_dislikes
            elsif choice == 6
                clear_dislikes
            elsif choice == 7
                is_running = false
            end
        end
    end

    def ask_for_preference
        puts "How do you feel about this one?"
        puts "1. Save to my favorites!"
        puts "2. Booooo.... Dislike!"
        puts "3. Just give me a new one"
        puts "4. Main Menu"
        input = STDIN.gets.chomp.to_i
        if input == 1
            Favorite.create(user_id: @user.id, joke_id: @full_joke[:id])
            get_joke_excluding_dislikes
        elsif input == 2
            Dislike.create(user_id: @user.id, joke_id: @full_joke[:id])
            get_joke_excluding_dislikes
        elsif input == 3
            get_joke_excluding_dislikes
        else

        end
        system('clear')
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

    def list_dislikes
        system('clear')
        @dislikes = []
        @user = User.find(@user.id)
        @user.dislikes.each do |x|
            dislike_joke = Joke.find_by(id: x.joke_id)
            @dislikes << dislike_joke
        end
        if @dislikes.length > 0
            @dislikes.each.with_index do |joke, index|
                puts "#{index + 1}. #{joke.setup}"
                puts "      -#{joke.punchline}"
                puts
            end
        else
            puts "You haven't disliked any jokes yet! Maybe that's a good thing..."
            puts
        end
    end 


    def get_joke(category = nil)
        if category == 'general' || category == 'programming' || category == 'knock-knock'
            category_jokes = Joke.all.where(category: category)
            @full_joke = category_jokes.sample
                puts @full_joke[:setup]
                puts @full_joke[:punchline]
        end
    end

    def prompt_categories
        puts "Which category would you like?"
        puts
        puts "1. General Humor"
        puts "2. Cringy Programming Jokes"
        puts "3. Knock Knock Jokes"
        puts
    end

    def get_joke_by_category
        system('clear')
        prompt_categories
        input = STDIN.gets.chomp.to_i
        if input == 1
            system('clear')
            get_joke('general')
            puts
            ask_for_preference
        elsif input == 2
            system('clear')
            get_joke('programming')
            puts
            ask_for_preference
        elsif input == 3
            system('clear')
            get_joke('knock-knock')
            puts
            ask_for_preference
        end
    end

    def clear_favorites 
        @user.favorites.clear
        system('clear')
    end

    def clear_dislikes 
        @user.dislikes.clear
        system('clear')
    end

    def get_joke_excluding_dislikes
        disliked_jokes = @user.dislikes.map {|dislike| dislike.joke}
        @excluded_list = Joke.all.select do |joke|
            disliked_jokes.include?(joke) == false
        end
         @full_joke = @excluded_list.sample
         system('clear')
         puts @full_joke[:setup]
         puts @full_joke[:punchline]
         puts
         ask_for_preference
    end
end