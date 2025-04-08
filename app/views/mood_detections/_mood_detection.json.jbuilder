json.extract! mood_detection, :id, :user_name, :mood, :confidence, :image, :created_at, :updated_at
json.url mood_detection_url(mood_detection, format: :json)
json.image url_for(mood_detection.image)
