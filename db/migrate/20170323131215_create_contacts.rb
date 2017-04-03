class CreateContacts < ActiveRecord::Migration
  def change
  	create_table :contacts do |t|
  		t.integer :user_id, :null => false
  		t.integer :friend_id, :null => false

  		t.timestamps
  	end
  end
end
