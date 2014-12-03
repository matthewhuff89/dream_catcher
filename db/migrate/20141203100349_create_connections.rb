class CreateConnections < ActiveRecord::Migration
  def change
    create_table :connections do |t|
      t.references :dream
      t.references :symbol

      t.timestamps
    end
  end
end
