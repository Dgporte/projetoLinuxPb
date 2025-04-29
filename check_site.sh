#!/bin/bash
#PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

URL="http://localhost"
LOG_FILE="/mnt/d/projetoLinuxPb/meu_script.log"
DISCORD_WEBHOOK="https://discord.com/api/webhooks/1364322138013831261/i7YeE7OFFsh8U395jXPKtiswGdJQ3xaIgfCMbrWM8UwDS8lYtQyZD3porGu0NNj1nzL4"

TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

send_discord_alert() {
  MESSAGE="$1"
  curl -H "Content-Type: application/json" \
       -X POST \
       -d "{\"content\": \"$MESSAGE\"}" \
       "$DISCORD_WEBHOOK"
}

echo "$TIMESTAMP - Verificando o site..." >> $LOG_FILE

STATUS_CODE=$(curl -s -o /dev/null -w "%{http_code}" $URL)

if [ "$STATUS_CODE" -ne 200 ]; then
  LOG_MSG="$TIMESTAMP - Site fora do ar (status: $STATUS_CODE)"
  echo "$LOG_MSG" >> $LOG_FILE
  send_discord_alert ":warning: $LOG_MSG"
else
  LOG_MSG="$TIMESTAMP - Site online (status: $STATUS_CODE)"
  echo "$LOG_MSG" >> $LOG_FILE
  send_discord_alert ":white_check_mark: $LOG_MSG"
fi

