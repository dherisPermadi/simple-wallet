# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :username, null: false, default: ""
      t.datetime :remember_created_at

      t.timestamps null: false
    end

    add_index :users, :username, unique: true
  end
end
