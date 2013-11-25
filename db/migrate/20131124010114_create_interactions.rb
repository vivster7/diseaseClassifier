class CreateInteractions < ActiveRecord::Migration
  def change
    create_table :interactions do |t|
      t.string :name
      t.integer :count
      t.timestamps
    end
  end
end
