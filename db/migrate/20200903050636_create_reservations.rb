class CreateReservations < ActiveRecord::Migration[6.0]
  def change
    create_table :reservations do |t|
      t.integer :num_tables
      t.string :checkin_date
      t.belongs_to :restaurant, foreign_key: true
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
