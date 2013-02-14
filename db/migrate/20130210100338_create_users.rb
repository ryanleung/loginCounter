class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user
      t.string :password
      t.integer :count, :default => 1 
  
      t.timestamps
    end
  end
end
