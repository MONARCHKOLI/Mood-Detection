require "open3"

class ProcessMoodDetectionJob < ApplicationJob
  queue_as :default

  def perform(mood_detection_id)
    mood = MoodDetection.find(mood_detection_id)
    image_path = ActiveStorage::Blob.service.path_for(mood.image.key)

    python_path = "/Users/developer/Desktop/mood_detector/venv310/bin/python"

    # Step 1: Run emotion detection
    emotion_script_path = Rails.root.join("python/emotion_detector.py")
    stdout, stderr, status = Open3.capture3("#{python_path} #{emotion_script_path} #{image_path}")

    if status.success?
      mood_name, confidence = stdout.strip.split("|")
      mood.update(mood: mood_name, confidence: confidence.to_f)
    else
      Rails.logger.error("Emotion Detector Error: #{stderr}")
    end

    # Step 2: Run face recognition
    face_script_path = Rails.root.join("python/face_recognizer.py")
    known_faces_dir = Rails.root.join("python/face_recognition_data")

    stdout, stderr, status = Open3.capture3("#{python_path} #{face_script_path} #{image_path} #{known_faces_dir}")

    if status.success?
      result = JSON.parse(stdout.strip)
      mood.update(face_match: result["match"], face_match_error: result["error"])
    else
      Rails.logger.error("Face Recognition Error: #{stderr}")
    end
  end
end
