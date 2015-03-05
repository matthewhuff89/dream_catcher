class CreateInterpretations < ActiveRecord::Migration
  def change
    t.text :content
    t.references :user
    t.references :dream

    t.timestamps
  end
end
