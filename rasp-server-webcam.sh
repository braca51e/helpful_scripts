#This file is ffserver.conf can be stored in /etc/ffserver.conf
HTTPPort 8000
RTSPPort 8001
HTTPBindAddress 127.0.0.1
RTSPBindAddress 127.0.0.1
MaxClients 100
MaxBandwidth 10000
NoDefaults

<Feed webcam.ffm>
   File /tmp/webcam.ffm
   FileMaxSize 20M
</Feed>

<Stream webcam.mp4>
   Feed webcam.ffm
   Format rtp
   VideoSize 1280x720
   VideoFrameRate 30
   NoAudio
</Stream>

<Stream webcam.mjpg>
  Feed webcam.ffm
  Format mpjpeg
  VideoBufferSize 8000
  VideoCodec mjpeg
  VideoFrameRate 24
  VideoSize 640x480
  NoAudio
</Stream>

#<Stream test.mp3>
#Feed feed1.ffm
#Format mp2
#AudioCodec mp3
#AudioBitRate 64
#AudioChannels 1
#AudioSampleRate 44100
#NoVideo
#</Stream>

# Real with audio and video at 64 kbits

#<Stream test.rm>
#Feed feed1.ffm
#Format rm
#AudioBitRate 32
#VideoBitRate 128
#VideoFrameRate 25
#VideoGopSize 25
#NoAudio
#</Stream>

#############################################
#Launch ffserver: 
ffserver -d -f ffserver.conf
######################################################################
#ffmpeg to open the built in camera and send a live feed to ffserver
ffmpeg -f avfoundation -framerate 30 -video_size 1280x720 -i "0" http://localhost:8000/webcam.ffm
ffmpeg -f video4linux2 -framerate 30 -video_size 1280x720 -i "0" http://localhost:8000/webcam.ffm
#####################################################################
#watch on vlc
rtsp://127.0.0.1:8001/webcam.mp4
