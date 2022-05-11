class CreateDish < ActiveRecord::Migration[5.2]
  def change
    create_table :dishes do |t|
      t.string :name
      t.boolean :in_season
      t.integer :cost

      t.timestamps
    end
  end
end
