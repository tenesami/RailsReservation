class User < ApplicationRecord
    has_many :restaurants
    has_many :reservations 
    has_many :reserved_restaurants, through: :reservations, source: :restaurant 

    #since active record take of the validation 
    #we don't need to validate twice 
    has_secure_password
    validates :username, uniqueness: true, presence: true
        
end
