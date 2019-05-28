
class JokeCLI
    
    def initialize

    end

    def run
        puts "Welcome to the game"
        present_menu
    end

    def present_menu_list
        puts "1. Give me a random joke"
        puts "2. Quit"
    end

    def present_menu
        is_running = true
        while is_running 
            present_menu_list
            choice = STDIN.gets.chomp.to_i
            if choice == 1
                puts "loser"
                is_running = false
            elsif choice == 2
                is_running = false
            end
        end
    end






end