class CreateUsers < ActiveRecord::Migration
  #######################################
  #                                     #
  #     Do NOT change this schema.      #
  #                                     #
  #######################################
  def change
    create_table :users do |t|
      t.string :first_name, :null => false
      t.string :last_name, :null => false
      t.string :email, :null => false
      t.string :hashed_password, :null => false
      t.string :location, :null => false
      t.string :phone, :null => false
      t.string :looking_for_contacts, :null => false

      t.timestamps
    end
    add_index :users, :email, :unique => true
  end
end
