class CreateProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :profiles do |t|
      t.references :user
      t.integer :age
      t.date :birthday
      t.string :hometown
      t.string :current_location
      t.string :sex
      t.text :bio

      t.timestamps
    end
  end
end
