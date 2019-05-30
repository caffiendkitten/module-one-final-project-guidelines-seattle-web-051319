class Joke < ActiveRecord::Base
    has_many :favorties
    has_many :dislikes


end