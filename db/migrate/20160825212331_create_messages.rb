class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :description
      t.string :hashtags
      t.string :targets
      t.string :notes
      t.datetime :deadline

      t.timestamps null: false
    end
  end
end
