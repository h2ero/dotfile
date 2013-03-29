Xephyr -ac -screen 1024x768 -br -reset -terminate 2> /dev/null :1 & 
sleep 1
DISPLAY=:1.0 
awesome -c ~/.config/awesome/rc.lua
