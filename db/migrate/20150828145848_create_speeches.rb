class CreateSpeeches < ActiveRecord::Migration
  def change
    create_table :speeches do |t|
      t.string :name
      t.text :grammar

      t.timestamps null: false
    end
  end
end
