class CreateRestaurants < ActiveRecord::Migration[6.0]
  def change
    create_table :restaurants do |t|
      t.string :restaurant_name
      t.boolean :available_table

      t.belongs_to :user, foreign_key: true
      t.timestamps
    end
  end
end
