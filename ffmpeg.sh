######Record n min segments from online camera######
#!/bin/bash

CAM="rtsp://usr:domain@172.16.0.6/live"
VIDLOC=/path_to/ffmpeg/to_pro
FPS=15
DURATION=00:05:00

while true; do
    NOW=$(date +"%Y%m%d-%H%M%S")
    VIDNAME=video_$NOW.mp4
    echo $VIDNAME
    ffmpeg -hide_banner -loglevel 0 -i $CAM \
    -an -to $DURATION -r 15 -s 1280x720 -c:v copy -map 0 $VIDNAME
    OUT=$?
    if [ $OUT -eq 0 ];then
        echo "Recorded!"
    else
        echo "Not Recorded!"
    fi
done

######Extract a segemnt from a video######
####this way does not respect order####
ffmpeg -ss 00:00:05 -i videp.mp4 -t 00:01:30 -vcodec copy out.mp4
ffmpeg -r 14 -f image2 -s 1920x1080 -start_number 1 -i detect_%03d.jpg -vframes 198 -vcodec libx264 -crf 20  -pix_fmt yuv420p ../out.mp4

######Create video from images######
CONCAT=$(echo $(ls *.png | sort -n -t _ -k 2) | sed -e "s/ /|/g")
ffmpeg -pattern_type glob -i '*.jpg' -c:v libx264 -r 15 -pix_fmt yuv420p out.mp4

######Take a shot######
ffmpeg -f avfoundation -video_size 1280x720 -framerate 30 -i "0" -vframes 1 live.jpg

######Record video webcam######
ffmpeg -f v4l2 -r 25 -s 640x480 -i /dev/video0 out.avi

######Change framerate######
ffmpeg -y -i video.mp4 -r 15 -s 1280x958 -c:v libx264 -b:v 3M -strict -2 -movflags faststart out.mp4

######Record on rpi######
ffmpeg -f video4linux2 -input_format h264 -video_size 1280x720 -framerate 24 -i /dev/video0 -vcodec copy -an -to 00:00:05 test.mp4

#####Extract image frames from video#####
ffmpeg -i "%1" frames/out-%03d.jpg

#raspberry pi command rtsp stream
raspivid -o - -t 0 -w 960 -h 540 | cvlc -vvv stream:///dev/stdin --sout '#rtp{sdp=rtsp://:8554/}' :demux=h264

#Create chucks video only
ffmpeg -i input.mp4 -c copy -map 0 -f segment -segment_time 600 -reset_timestamps 1 out_%03d.mp4

#Create chucks 2
ffmpeg -i input.mp4 -c copy -f segment -segment_time 1800 -reset_timestamps 1 output_%03d.mp4
