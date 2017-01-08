class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.string :title, default: 'Untitled'
      t.boolean :completed, default: false
      t.timestamp :deadline, default: Time.now
      t.string :tags, array: true

      t.timestamps
    end
  end
end
