import face_recognition
import sys
import os
import json

def load_known_faces(known_faces_dir):
    known_encodings = []
    known_labels = []

    for filename in os.listdir(known_faces_dir):
        if filename.endswith(".jpg") or filename.endswith(".png"):
            image_path = os.path.join(known_faces_dir, filename)
            image = face_recognition.load_image_file(image_path)
            encoding = face_recognition.face_encodings(image)
            if encoding:
                known_encodings.append(encoding[0])
                known_labels.append(os.path.splitext(filename)[0])
    return known_encodings, known_labels

def recognize_face(test_image_path, known_faces_dir):
    known_encodings, known_labels = load_known_faces(known_faces_dir)
    test_image = face_recognition.load_image_file(test_image_path)
    test_encodings = face_recognition.face_encodings(test_image)

    if not test_encodings:
        return {"match": False, "error": "No face found in test image"}

    test_encoding = test_encodings[0]
    results = face_recognition.compare_faces(known_encodings, test_encoding)
    
    match = any(results)
    return {"match": match}

# ✅ This part should be AFTER all function definitions
if __name__ == "__main__":
    test_image_path = sys.argv[1]
    known_faces_dir = os.path.join(os.path.dirname(__file__), "face_recognition_data")
    
    try:
        result = recognize_face(test_image_path, known_faces_dir)
        print(json.dumps(result))
    except Exception as e:
        print(json.dumps({"match": False, "error": str(e)}))
