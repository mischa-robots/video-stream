# Video-Stream

Video streaming Jetson Nano cameras with mediamtx

1. download [mediamtx](https://github.com/bluenviron/mediamtx/releases) and copy it to this directory.

2. make mediamtx executable `chmod a+x mediamtx`

### Start manually

To run mediamtx manually (for development, debugging, etc)

`.\mediamtx`

For debugging, you can also set the `GST_DEBUG` level in the `gstlaunch_camX.sh` files.

### Start automatically

To start automatically at computer startup every time, install the mediamtx service:

`sudo install-service.sh`

## Streaming Format

Check out [mediamtx docs](https://github.com/bluenviron/mediamtx) for streaming protocols, all are enabled by default.

Edit the mediamtx.yml to disable protocols if not required.

Edit the gstlaunch_camX.sh files to change the streaming format etc.

By default the stream is 720p 30fps h264 encoded with 3k constant quality.

**Note:** setting the quality higher with both cameras will shutdown the Jetson Nano due to some GPU driver bug (I actually don't know really why, as the logs leave no trace).

If using only one camera, it is save to set the quality higher though.

## Example

To access the video stream via webrtc in your browser (any browser supports it) simply open this address in a new tab for cam0:

`http://<jetson-ip>:8889/cam0`

or for cam1:

`http://<jetson-ip>:8889/cam1`

Of course your computer should have a connection to the Jetson device (via LAN or WiFi) and no firewall is blocking the stream.
