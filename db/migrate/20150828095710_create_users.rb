class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :mail
      t.string :shadow

      t.timestamps null: false
    end
  end
end
