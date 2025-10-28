# HomeSurveillance
yawcamai configurations and helper scripts

Some basic info:
- Yawcam as a program to manage IP cameras and webcams https://www.yawcam.com/
- Nvidia RTX graphics card to run face recognition model
- nssm to run yawcam as a service without the need for a logged-in user
- frp(fast reverse proxy) to control the system remotely under a nat3 network
- Telegram bot to receive alerts from video cameras with photos
- The computer is configured to restart automatically after a power outage. I also use smart plugs to manually override the power if necessary and monitor the status of the electrical grid.

# How to create the telegram bot (LLM generated)
### 1. **Create a Telegram Bot**

1. Open Telegram and search for `@BotFather`.
2. Send `/newbot` and follow the instructions.
3. You'll receive a **bot token** like:

   ```
   123456789:ABCdefGHIjkLMNOPqrsTUVwxyz123456789
   ```

### 2. **Get Your Chat ID**

1. Start a chat with your bot (just send any message).
2. Visit this URL (replace `YOUR_BOT_TOKEN`):

   ```
   https://api.telegram.org/botYOUR_BOT_TOKEN/getUpdates
   ```
3. Find the `"chat":{"id":<your_chat_id>}` in the response.

### 3. **Configure Yawcam**

1. Open **Yawcam**.
2. Go to **Settings > Motion Detection > Actions**.
3. Enable “**Run**”.
4. Set the path to your `.bat` or `.ps1` script. (for ps1 scripts you need to create a bat script that runs the ps1 script , i tried running the ps1 script directly but it didn't work)


### 4. other infos
usefull cmd: mklink /D "C:{{userhomefolderpath}}\.yawcam-ai" "L:\surveillance\.yawcam-ai"
