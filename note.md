Restaurant
    - has_many: reservations

    -restaurant_name :stirng
    -avaliable_table :boolean
    -photo :string 
    

User
    - has_many :reviews
    - has_many :reservations
    - has_many :reviewed_reservations, through: :reviews, source: :restaurant

    -username
    -email
    -pasword_digest

Reservation
    - belongs_to :restaurant
    - belongs_to :user
    - has_many reviews
    - has_many :users, through: :reviews

    -restaurant_name :string
    -number_of_tables :integer
    -checkin_date :datetime
    -checkin_time :datetime
    -checkout_time :datetime
    -description :string


Review 
    - belongs_to :user
    - belongs_to :reservation

    -stars :integer
    -title :string
    -content :string


new resevarion 
resr

restaurants search 



{"q"=>"Nile", "commit"=>"Search", "controller"=>"restaurants", "action"=>"index"} permitted: false>

{"controller"=>"restaurants", "action"=>"index"} permitted: false>
contoller 

model

view