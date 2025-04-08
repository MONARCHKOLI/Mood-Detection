import sys
from deepface import DeepFace

def main():
    img_path = sys.argv[1]
    analysis = DeepFace.analyze(img_path=img_path, actions=['emotion'])
    dominant = analysis[0]['dominant_emotion']
    confidence = analysis[0]['emotion'][dominant]
    print(f"{dominant}|{confidence}")

if __name__ == "__main__":
    main()