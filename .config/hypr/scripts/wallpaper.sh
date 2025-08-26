#!/usr/bin/env bash

# Путь к папке с обоями
WALLPAPER_DIR="$HOME/.local/share/wallpapers"

# Проверяем, что папка существует
if [ ! -d "$WALLPAPER_DIR" ]; then
    #notify-send "Ошибка" "Папка с обоями не найдена: $WALLPAPER_DIR"
    exit 1
fi

# Выбираем случайный файл (jpg/png/webp)
WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.webp" \) | shuf -n 1)

# Проверяем, что файл выбран
if [ -z "$WALLPAPER" ]; then
    #notify-send "Ошибка" "В папке нет подходящих изображений"
    exit 1
fi

# Устанавливаем обои с анимацией
swww img "$WALLPAPER" \
    --transition-type "any" \
    --transition-duration 1 \
    --transition-fps 60 \
    --transition-angle 30 \
    --transition-pos "top-right"

# Уведомление о смене (опционально)
#notify-send "Обои изменены" "$(basename "$WALLPAPER")" -i "$WALLPAPER"