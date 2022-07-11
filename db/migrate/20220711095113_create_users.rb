class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|

      t.timestamps

      t.string :name,      null: false, default: ""
      t.string :emai,      null: false, default: ""
      t.string :password_digest,    null: false, default: ""
    end
  end
end
