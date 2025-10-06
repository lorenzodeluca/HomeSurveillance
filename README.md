# HomeSurveillance
yawcamai configurations and helper scripts

Some basic info:
- as a program to manage IP cameras and webcams https://www.yawcam.com/
- Nvidia RTX graphics card to run face recognition model
- nssm to run yawcam as a service without the need for a logged-in user
- frp(fast reverse proxy) to control the system remotely under a nat3 network
- Telegram bot to receive alerts from video cameras with photos
- The computer is configured to restart automatically after a power outage. I also use smart plugs to manually override the power if necessary and monitor the status of the electrical grid.
