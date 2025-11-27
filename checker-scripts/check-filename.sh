#!/bin/bash

# ==============================================================================
# Configuration
# ==============================================================================

NAME_PATTERN="[a-z][a-z0-9_-]*[a-z0-9]"
EXTENSIONS='py|txt|js|java|c'
FILE_PATTERN="$NAME_PATTERN\.($EXTENSIONS)"
ERRORS=0

# ==============================================================================
# Validation
# ==============================================================================

if [ -z "$1" ]; then
    exit 1
fi
TARGET_DIR="$1"

# ==============================================================================
# Directory Validation Logic
# ==============================================================================

find "$TARGET_DIR" -type d \( -path "$TARGET_DIR/.git" \) -prune -o -print | while IFS= read -r DIR_PATH; do
    DIR_NAME=$(basename "$DIR_PATH")
    if [ -z "$DIR_NAME" ]; then continue; fi
    if [[ ! "$DIR_NAME" =~ ^$NAME_PATTERN$ ]]; then
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
    if [[ ! "$FILENAME" =~ ^$FILE_PATTERN$ ]]; then
        echo "[ПОМИЛКА] Файл не відповідає конвенції: $FILE_PATH"
        ERRORS=$((ERRORS + 1))
    fi
done

# ==============================================================================
# Exit Code
# ==============================================================================

if [ "$ERRORS" -eq 0 ]; then
    echo "SUCCESS: Всі файли та директорії пройшли перевірку."
    exit 0
else
    echo "FAILURE: Перевірка завершилася помилкою. Знайдено порушень: $ERRORS."
    exit 1
fi
