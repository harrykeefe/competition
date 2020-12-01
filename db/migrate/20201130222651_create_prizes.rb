class CreatePrizes < ActiveRecord::Migration[6.0]
  def change
    create_table :prizes do |t|
      t.string :name, null: false
      t.decimal :value, precision: 10, scale: 2, null: false

      t.belongs_to :contest
      t.timestamps
    end
  end
end
