class AddFaceMatchToMoodDetections < ActiveRecord::Migration[7.1]
  def change
    add_column :mood_detections, :face_match, :boolean
    add_column :mood_detections, :face_match_error, :text
  end
end
