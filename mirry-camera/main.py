import os
from tokenize import Number
import face_recognition
import cv2
import numpy as np
import requests
from dotenv import load_dotenv

load_dotenv()

BASE_URL = os.getenv('BASE_URL')
API_KEY = os.getenv('API_KEY')
USERS_PHOTOS_DIR = os.getenv('USERS_PHOTOS_DIR')

RECOGNIZED_URI = '/recognized'
LEFT_URI = '/left'


video_capture = cv2.VideoCapture(0)

known_face_encodings = []
known_face_names = []

face_locations = []
face_encodings = []
face_name = None
process_this_frame = True
count_of_users = 0

def get_count_of_users() -> int:
    return len([name for name in os.listdir(USERS_PHOTOS_DIR)])

def setup_script():
    for name in os.listdir(USERS_PHOTOS_DIR):
        image = face_recognition.load_image_file(f'{USERS_PHOTOS_DIR}/{name}')
        image_encoded = face_recognition.face_encodings(image)[0]

        known_face_encodings.append(image_encoded)
        known_face_names.append(name.split('.')[0])


while True:
    if get_count_of_users() != count_of_users:
        count_of_users = get_count_of_users()
        setup_script()

    ret, frame = video_capture.read()

    if process_this_frame:
        small_frame = cv2.resize(frame, (0, 0), fx=0.25, fy=0.25)

        rgb_small_frame = small_frame[:, :, ::-1]
        
        face_locations = face_recognition.face_locations(rgb_small_frame)
        face_encodings = face_recognition.face_encodings(rgb_small_frame, face_locations)

        if len(face_encodings) == 0:
            if face_name != None:
                requests.post(url=BASE_URL + LEFT_URI, headers={'Authorization':API_KEY})
            face_name = None
            
        for face_encoding in face_encodings:
            matches = face_recognition.compare_faces(known_face_encodings, face_encoding)
            name = "Unknown"

            face_distances = face_recognition.face_distance(known_face_encodings, face_encoding)
            best_match_index = np.argmin(face_distances)
            if matches[best_match_index]:
                name = known_face_names[best_match_index]
            
            if name != face_name:
                face_name = name
                requests.post(url=BASE_URL + RECOGNIZED_URI, json={'username':name}, headers={'Authorization':API_KEY})

    process_this_frame = not process_this_frame