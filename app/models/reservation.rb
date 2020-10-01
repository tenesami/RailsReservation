class Reservation < ApplicationRecord
    belongs_to :restaurant
    belongs_to :user
    
    validates :checkin_date, presence: true
    validates :num_tables, presence: true
    
    scope :last_7_reserved, -> {order(updated_at: :desc).limit(7)}
   

end
