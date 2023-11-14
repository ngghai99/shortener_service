class CreateShortens < ActiveRecord::Migration[7.0]
  def change
    create_table :shortens do |t|
      t.string :original_url, null: false
      t.string :shortened_url, null: false

      t.timestamps
    end
    add_index :shortens, :original_url, unique: true
    add_index :shortens, :shortened_url, unique: true
  end
end
