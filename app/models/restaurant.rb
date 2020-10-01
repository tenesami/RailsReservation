class Restaurant < ApplicationRecord
    belongs_to :user
    has_many :reservations
    has_many :users, through: :reservations

    validates :restaurant_name,  presence: true

    validate :too_many_restaurants

    scope :alpha, -> {order(:restaurant_name)} 
    
    scope :most_reservations, -> { 
        Restaurant.left_joins(:reservations)
        .group('restaurants.id')
        .order('count(restaurants.id) desc')
    }
    def self.search(search)
        if search   
            Restaurant.where("restaurant_name like ?", "%#{search}%")
        else
            Restaurant.all
        end
    end
    
    def too_many_restaurants
        #binding.pry
        today_restaurants = user.restaurants.select do |r|
            r.created_at.try(:to_date) == Date.today
        end
        
        if today_restaurants.size > 5
            errors.add(:restaurants_id, "can not be added more than 5 times per day")
        end
    end

end
