# Mood Detection App

This is a Ruby on Rails 7 application (Ruby 3.2) that detects the user's mood from an uploaded or camera-captured image using the [DeepFace](https://github.com/serengil/deepface) Python library.

## ✨ Features

- Upload or capture an image using your device's webcam.
- Detect facial expressions/mood from the image using DeepFace.
- Store detected mood and image in the database.
- Auto-create company records based on OCR (optional extension).
- Docker support (optional).

## 🛠️ Stack

- **Backend:** Ruby on Rails 7, Ruby 3.2
- **Database:** PostgreSQL
- **Frontend:** Turbo, Stimulus, HTML/CSS
- **Python:** DeepFace (via virtual environment)
- **Image Uploads:** Active Storage

---

## ⚙️ Setup Instructions

### 1. Clone and Install Dependencies

```bash
git clone https://github.com/your-username/mood_detection_app.git
cd mood_detection_app
bundle install
yarn install # if using webpack
```

### 2. Setup Database

```
rails db:create db:migrate
```

### 3. Set Up Python Environment

Install Python dependencies in a virtual environment (recommended):

```
python3 -m venv venv
source venv/bin/activate
pip install deepface opencv-python pillow numpy
```

- Ensure Python dependencies are installed within your project to avoid global system conflicts.

### 4. Run Rails Server

```
rails server
```

### 📸 Image Upload & Detection

You can upload an image or capture one via your webcam. On form submission:

- The image is stored via ActiveStorage.

- A background job or direct call sends the image to the Python backend.

- The DeepFace library processes the image and returns a predicted mood.

#### Example Flow

# User opens the mood detection form.

# Chooses to Upload or Capture an image.

# The app displays the predicted mood after analysis.

#### 🧠 To-Do

- Upload image via form

- Preview captured image

- Send image to Python backend for mood analysis

- Auto-link OCR company name (optional)

- Add Docker support for deployment

### 👨‍💻 Author

Developed by https://github.com/MONARCHKOLI
