class MenusAvailable

    def self.present_menu_list
        puts <<-FACE


    ---------------------------------------
    |                                     |
    |  1. Give me a random Joke.          |
    |  2. Get a Joke by Category          |
    |  3. List My favorites               |
    |  4. Clear My favorites              |
    |  5. List Dislikes                   |
    |  6. Clear Dislikes                  |
    |  7. Quit                            |
    |                                     |
    ---------------------------------------
		FACE
    end

    def self.ask_for_preference
        puts <<-FACE

    ---------------------------------------
    |                                     |
    |  How do you feel about this one?    |
    |  1. Save to my favorites!           |
    |  2. Booooo.... Dislike!             |
    |  3. Just give me a new one          |
    |  4. Main Menu                       |
    |                                     |
    |                                     |
    |                                     |
    |                                     |
    ---------------------------------------
		FACE
    end


    def self.prompt_categories
        puts <<-FACE

    ---------------------------------------
    |                                     |
    |  Which category would you like?     |
    |  1. General Humor.                  |
    |  2. Cringy Programming Jokes        |
    |  3. Knock Knock Jokes.              |
    |                                     |
    |                                     |
    |                                     |
    |                                     |
    |                                     |
    ---------------------------------------
		FACE
    end
end