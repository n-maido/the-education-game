from facial_emotion_recognition import EmotionRecognition

import cv2 as cv
import sys

def ResizeWithAspectRatio(image, width=None, height=None, inter=cv.INTER_AREA):
    dim = None
    (h, w) = image.shape[:2]

    if width is None and height is None:
        return image
    if width is None:
        r = height / float(h)
        dim = (int(w * r), height)
    else:
        r = width / float(w)
        dim = (width, int(h * r))

    return cv.resize(image, dim, interpolation=inter)

er = EmotionRecognition(device='gpu', gpu_id=0)

img = cv.imread(cv.samples.findFile("big_man2.jpg"))

if img is None:
    sys.exit("Could not read the image")

#cv.imshow("Display Window", img)
k = cv.waitKey(0)

#if k == ord("s"):
    #cv.imwrite("test.jpg", img)

#success, frame = cam.read()

frame = er.recognise_emotion(img, return_type='BGR')
cv.namedWindow("frame", cv.WINDOW_NORMAL)
frameS = ResizeWithAspectRatio(frame, width=1920)
cv.imshow("frame", frameS)

while True:
    key = cv.waitKey(10)
    if key & 0xff == 27:
        break

