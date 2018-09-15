class CreateAnimals < ActiveRecord::Migration[5.2]
  def change
    create_table :animals do |t|
      t.integer :cites_id
      t.text :common_name
      t.text :kingdom
      t.text :phylum
      t.text :class
      t.text :order
      t.text :family

      t.timestamps
    end
    add_index :animals, :cites_id, unique: true
  end
end
