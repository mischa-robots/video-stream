#!/bin/bash

#export GST_DEBUG=3

gst-launch-1.0 nvarguscamerasrc sensor-id=1 ! \
    'video/x-raw(memory:NVMM), width=1280, height=720, format=NV12, framerate=30/1' ! \
    nvv4l2h264enc bitrate=3000000 preset-level=1 ! \
    h264parse ! \
    rtspclientsink latency=0 protocols=tcp location=rtsp://localhost:8554/video1
