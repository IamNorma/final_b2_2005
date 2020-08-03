class AddTimeToFlights < ActiveRecord::Migration[5.1]
  def change
    add_column :flights, :time, :string
  end
end
