#!/bin/bash

# Конфигурация (можно менять)
PHONE_IP="192.168.0.55"  # Основной IP телефона
PORT="5555"               # Стандартный порт ADB
BITRATE="6M"              # Оптимальный битрейт для Wi-Fi
RESOLUTION="1280"         # 720p (1280x720)
FPS="60"                  # Кадры в секунду

# Проверка доступности телефона
if ! ping -c 1 "$PHONE_IP" &> /dev/null; then
    notify-send "Scrcpy" "⚠️ Проверьте отладку по USB!" -t 3000
    exit 1
fi

# Настройка ADB-подключения
notify-send "Scrcpy" "🔄 Подключаюсь к телефону $PHONE_IP..." -t 3000
adb kill-server
adb tcpip $PORT

# Попытка подключения с таймаутом
timeout 5 adb connect "$PHONE_IP:$PORT"
if [ $? -ne 0 ]; then
    notify-send "Scrcpy" "⚠️ Не удалось подключиться по ADB" -t 3000
    exit 1
fi

# Запуск scrcpy с оптимальными параметрами
notify-send "Scrcpy" "🚀 Запуск scrcpy (${RESOLUTION}p@${FPS}fps, битрейт $BITRATE)..." -t 3000
scrcpy \
    --window-title='telephone' \
    --video-codec=h265 \
    --video-bit-rate=$BITRATE \
    --max-size=$RESOLUTION \
    --max-fps=$FPS \
    --turn-screen-off \
    --keyboard=uhid \
    --shortcut-mod=lctrl \
    --window-borderless \

# Автоматическое отключение при завершении
adb disconnect "$PHONE_IP:$PORT"
adb kill-server
