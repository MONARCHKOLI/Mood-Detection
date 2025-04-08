class CreateMoodDetections < ActiveRecord::Migration[7.1]
  def change
    create_table :mood_detections do |t|
      t.string :user_name
      t.string :mood
      t.float :confidence

      t.timestamps
    end
  end
end
