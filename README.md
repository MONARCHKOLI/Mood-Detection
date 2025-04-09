# 😊 Mood & Face Detection App

This Ruby on Rails application detects **facial expressions (moods)** and optionally performs **face recognition** from uploaded or captured images using integrated Python scripts powered by [DeepFace](https://github.com/serengil/deepface) and [face_recognition](https://github.com/ageitgey/face_recognition).

Users can upload or capture a photo, and the system identifies the user's **mood (e.g., happy, sad, neutral)** and whether the face matches a known individual.

---

## 🔍 Features

- 📸 Upload or capture a photo using webcam (HTML5-based)
- 😄 Detect mood (happy, sad, angry, neutral, etc.)
- 🧠 Face recognition from stored faces (`face_recognition_data/`)
- 📊 Displays confidence score
- 💾 Stores all results in a database
- 🪄 Background processing with `ActiveJob`
- 🧪 Optional emotion and face match testing via logs

---

## 🖼️ Demo

| Upload Page                | Result Page                |
| -------------------------- | -------------------------- |
| ![Upload](docs/upload.png) | ![Result](docs/result.png) |

---

## ⚙️ Tech Stack

- **Ruby on Rails 7**
- **Python 3.10 (DeepFace + face_recognition)**
- **PostgreSQL** (or compatible DB)
- **ActiveStorage** (for image upload)
- **Stimulus / JS** (for camera interaction)
- **RVM / Virtualenv** (for separate Ruby and Python envs)

---

## 🚀 Setup Instructions

### 1. Clone & Install Dependencies

```bash
git clone https://github.com/your-username/mood-detector.git
cd mood-detector

bundle install
yarn install # if you're using Webpacker or jsbundling
rails db:setup
```

### 2. Setup Python (Face & Mood Detection)

Create a Python virtual environment inside the Rails project:

```bash
cd python
python3.10 -m venv venv310
source venv310/bin/activate

pip install -r requirements.txt
```

`requirements.txt` content:

```txt
deepface
face_recognition
cmake
dlib

```

### 3. Prepare Known Faces

Place labeled images in `python/face_recognition_data/` directory:

```markdown
python/
└── face_recognition_data/
├── Alice.jpg
└── Bob.jpg
```

File name is treated as the person's name.

### 4. Run the App

```bash
rails server
```

Visit http://localhost:3000

### 🧪 Testing

Basic Rails tests can be run with:

```bash
rails test
```

You can also manually test Python scripts:

```bash
# Detect mood
python python/emotion_detector.py path/to/image.jpg

# Check face match
python python/face_recognizer.py path/to/image.jpg

```

### 📡 API Endpoints

If using JSON API:

| Method | Endpoint | Description |
| ------ | -------- | ----------- |

| POST | `/mood_detections` | Upload & analyze image |
| ---- | ------------------ | ---------------------- |

| GET | `/mood_detections/:id` | View mood & match results |
| --- | ---------------------- | ------------------------- |

---

### 🎯 How It Works

1. User uploads or captures a photo.

2. Image is stored via ActiveStorage.

3. ProcessMoodDetectionJob runs:

   - Calls Python script emotion_detector.py to detect mood.

   - Calls face_recognizer.py to check if face matches stored known faces.

4. Results (mood, confidence, face match, error) are saved to the database.

### 🔐 Environment Variables

Not required at this time — everything runs locally with proper file paths. But you can configure:

- `PYTHON_PATH` if you want to externalize the Python executable location.
- `KNOWN_FACES_DIR` if you relocate the directory.

---

### 🧩 Known Issues

- Webcam capture may not work on all mobile browsers.

- Face recognition requires clear face visibility.

- Lighting & angles can affect mood detection accuracy.

### 🚧 Future Improvements

- Live face detection preview

- Support multiple faces in one image

- Turbo Stream for live updates

- Add emotion history charts per user

- Dockerize for easier deployment

### 📦 Deployment

To deploy:

1.  Make sure Python dependencies are installed in production
2.  Add `python/venv310` to your Docker build or use system Python
3.  Precompile assets and migrate DB

### 🙌 Credits

- [DeepFace](https://github.com/serengil/deepface)
- [face_recognition](https://github.com/ageitgey/face_recognition)
- Ruby on Rails community ❤️
