import cv2
import argparse


def track_object(input_file):
    # Create a video capture object to read input video file
    cap = cv2.VideoCapture(input_file)

    # Initialize the tracker with a bounding box drawn on the first frame
    ret, frame = cap.read()
    bbox = cv2.selectROI("Select Object to Track", frame)
    tracker = cv2.TrackerCSRT_create()
    tracker.init(frame, bbox)

    # Create a video writer object to write output video file
    # Get video frame dimensions
    frame_width = int(cap.get(cv2.CAP_PROP_FRAME_WIDTH))
    frame_height = int(cap.get(cv2.CAP_PROP_FRAME_HEIGHT))
    frame_fps = int(cap.get(cv2.CAP_PROP_FPS))

    fourcc = cv2.VideoWriter_fourcc(*"mp4v")
    out = cv2.VideoWriter(input_file.replace(".mp4", "_tracked.mp4"), fourcc, 30, (frame_width, frame_height))

    # Loop over each frame of the input video
    while True:
        # Read the next frame from the input video
        ret, frame = cap.read()
        if not ret:
            break

        # Update the tracker with the current frame
        success, bbox = tracker.update(frame)

        # Draw the bounding box on the current frame
        if success:
            # Tracking successful, draw the bounding box
            x, y, w, h = [int(i) for i in bbox]
            cv2.rectangle(frame, (x, y), (x + w, y + h), (0, 255, 0), 2)
        else:
            # Tracking failed, print an error message
            cv2.putText(frame, "Tracking Failed", (100, 80), cv2.FONT_HERSHEY_SIMPLEX, 0.75, (0, 0, 255), 2)

        # Write the current frame to the output video file
        out.write(frame)

        # Display the current frame with the bounding box
        cv2.imshow("Object Tracking", frame)
        if cv2.waitKey(1) == 27:
            break

    # Release the video capture, video writer, and close all windows
    cap.release()
    out.release()
    cv2.destroyAllWindows()


if __name__ == '__main__':
    # Construct the argument parser and parse the arguments
    ap = argparse.ArgumentParser()
    ap.add_argument("-i", "--input", required=True, help="path to input video file")
    args = vars(ap.parse_args())

    # Call the track_object function with the input file path as argument
    track_object(args["input"])
