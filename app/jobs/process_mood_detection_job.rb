require "open3"

class ProcessMoodDetectionJob < ApplicationJob
  queue_as :default

  def perform(mood_detection_id)
    mood = MoodDetection.find(mood_detection_id)
    image_path = ActiveStorage::Blob.service.path_for(mood.image.key)

    python_path = "/Users/developer/Desktop/mood_detector/venv310/bin/python"
    script_path = Rails.root.join("python/emotion_detector.py")
    stdout, stderr, status = Open3.capture3("#{python_path} #{script_path} #{image_path}")

    if status.success?
      mood_name, confidence = stdout.strip.split("|")
      mood.update(mood: mood_name, confidence: confidence.to_f)
    else
      Rails.logger.error("Python Error: #{stderr}")
    end
  end
end
