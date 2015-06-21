class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, limit: 30
      t.string :email, limit: 30
      t.string :password_digest
      t.string :authentication_token
      t.string :firstname, limit: 30
      t.string :lastname, limit: 30
      t.boolean :admin, default: false

      t.timestamps null: false
    end
  end
end
