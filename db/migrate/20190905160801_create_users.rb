class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :uid
      t.string :provider
      t.string :password_digest
      t.string :recovery_password_digest

      t.timestamps
    end

    add_index :users, :uid
  end
end
