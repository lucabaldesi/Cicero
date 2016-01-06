class AddUserRefToSpeeches < ActiveRecord::Migration
  def change
    add_reference :speeches, :user, index: true, foreign_key: true
  end
end
