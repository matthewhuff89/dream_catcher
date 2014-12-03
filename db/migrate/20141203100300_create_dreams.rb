class CreateDreams < ActiveRecord::Migration
  def change
    create_table :dreams do |t|
      t.string :title
      t.text :description
      t.date :dream_date
      t.references :user

      t.timestamps
    end
  end
end
