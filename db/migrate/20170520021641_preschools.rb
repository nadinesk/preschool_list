class Preschools < ActiveRecord::Migration[5.1]
  def change
  			create_table :preschools do |t|
      		t.string :name
      		t.text :address
      		t.integer :cost
          t.text :summary
      	end
  end
end
