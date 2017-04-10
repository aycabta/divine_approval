class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :uid
      t.string :provider
      t.string :nickname
      t.string :email
      t.string :name
      t.string :image_url

      t.timestamps

      t.index :uid, unique: true
      t.index :nickname, unique: true
      t.index :email, unique: true
    end
  end
end
