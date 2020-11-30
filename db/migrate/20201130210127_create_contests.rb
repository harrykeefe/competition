class CreateContests < ActiveRecord::Migration[6.0]
  def change
    create_table :contests do |t|
      t.string :name, null: false

      t.belongs_to :user
      t.timestamps
    end
  end
end
