#!/bin/bash

# ==============================================================================
# Configuration
# ==============================================================================

NAME_PATTERN="[a-z][a-z0-9_-]*[a-z0-9]"
EXTENSIONS='py|txt|js|java|c|md' # Додамо md, бо в проєкті є такі файли
FILE_PATTERN="$NAME_PATTERN\.($EXTENSIONS)"
ERRORS=0

# ==============================================================================
# Usage and Validation
# ==============================================================================

if [ -z "$1" ]; then
    echo "[СИСТЕМА] Помилка: Необхідно вказати шлях до директорії."
    exit 1
fi

TARGET_DIR="$1"

if [ ! -d "$TARGET_DIR" ]; then
    echo "[СИСТЕМА] Помилка: Вказаний шлях '$TARGET_DIR' не є дійсною директорією."
    exit 1
fi

# ==============================================================================
# Directory Validation Logic
# ==============================================================================

# Знаходимо всі директорії, крім службових (.git, .)
find "$TARGET_DIR" -type d \( -path "$TARGET_DIR/.git" -o -path "$TARGET_DIR/." -o -path "$TARGET_DIR/.." \) -prune -o -print | while IFS= read -r DIR_PATH; do
    DIR_NAME=$(basename "$DIR_PATH")
    
    # Перевіряємо, що назва директорії (DIR_NAME) відповідає патерну NAME_PATTERN
    if [[ ! "$DIR_NAME" =~ ^$NAME_PATTERN$ ]]; then
        # Виводимо тільки повідомлення про помилку
        echo "[ПОМИЛКА] Директорія не відповідає конвенції: $DIR_PATH"
        ERRORS=$((ERRORS + 1))
    fi
done

# ==============================================================================
# File Validation Logic
# ==============================================================================

FIND_REGEX=".*\.\($EXTENSIONS\)"
find "$TARGET_DIR" -type f -regex "$FIND_REGEX" | while IFS= read -r FILE_PATH; do
    FILENAME=$(basename "$FILE_PATH")

    # Перевіряємо, що назва файлу (без шляху) відповідає патерну FILE_PATTERN
    if [[ ! "$FILENAME" =~ ^$FILE_PATTERN$ ]]; then
        # Виводимо тільки повідомлення про помилку
        echo "[ПОМИЛКА] Файл не відповідає конвенції: $FILE_PATH"
        ERRORS=$((ERRORS + 1))
    fi
done

# Виводимо фінальний звіт (Exit Code буде оброблятися в main.yml)
echo "--- ПЕРЕВІРКА ЗАВЕРШЕНА: Знайдено $ERRORS порушень ---"