class CreateChores < ActiveRecord::Migration
  def change
    create_table :chores do |t|
      t.datetime          :chore_date
      t.boolean           :complete ,      :default => false
      t.integer           :user_id
      t.timestamps
    end
  end
end
