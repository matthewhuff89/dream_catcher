class CreateInterpretations < ActiveRecord::Migration
  def change
    create_table :interpretations do |t|
      t.text :content
      t.references :user
      t.references :dream

      t.timestamps
    end
  end
end
