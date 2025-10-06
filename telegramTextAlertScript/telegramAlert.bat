@echo off
set BOT_TOKEN=123:asd
set CHAT_ID=123
set MESSAGE=Motion+detected!!!%21

curl -s -X POST https://api.telegram.org/bot%BOT_TOKEN%/sendMessage -d chat_id=%CHAT_ID% -d text=%MESSAGE%