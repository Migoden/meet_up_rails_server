class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :description
      t.timestamp :start_time
      t.decimal :latitute
      t.decimal :longitude
      t.string :address

      t.timestamps
    end
  end
end
