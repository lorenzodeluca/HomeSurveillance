$botToken = "123:asd"
$chatId = "123"
$message = "Motion detected!"
Invoke-RestMethod -Uri "https://api.telegram.org/bot$botToken/sendMessage" -Method Post -ContentType "application/x-www-form-urlencoded" -Body @{chat_id=$chatId; text=$message}
