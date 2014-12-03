class CreateConnections < ActiveRecord::Migration
  def change
    create_table :connections do |t|
      t.references :dream
      t.references :word

      t.timestamps
    end
  end
end
