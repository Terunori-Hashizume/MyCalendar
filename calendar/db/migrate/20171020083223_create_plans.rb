class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.date :date, null: false
      t.time :start_time, null: false
      t.time :end_time, null: false
      t.string :title, null: false
      t.text :detail
      t.timestamps null: false
    end
  end
end
