#!/bin/bash

# nasa-wallpaper.sh - Set NASA's Astronomy Picture of the Day as wallpaper

# ===== CONFIG =====
API_KEY="ocS6stGY2XYlxeZEHQ2ohpMSYAAV97PKwoiZHPNq"     # 🔑 Replace this with your actual NASA API key
TMP_DIR="/tmp"
WALLPAPER_PATH="$TMP_DIR/nasa_apod_$(date +%Y%m%d).jpg"  # Daily unique name
LOG_PATH="$TMP_DIR/nasa_apod.log"

# NASA APOD API endpoint
API_URL="https://api.nasa.gov/planetary/apod?api_key=$API_KEY"

echo "🔭 Fetching NASA Astronomy Picture of the Day..." | tee "$LOG_PATH"

# Step 1: Get metadata (JSON)
RESPONSE=$(curl -s "$API_URL")

# Check for API errors
if echo "$RESPONSE" | grep -q "error"; then
    ERROR_MSG=$(echo "$RESPONSE" | jq -r '.error.message // "Unknown error"')
    echo "❌ NASA API Error: $ERROR_MSG" | tee -a "$LOG_PATH"
    exit 1
fi

# Parse JSON (requires `jq`)
if ! command -v jq >/dev/null 2>&1; then
    echo "❌ 'jq' not installed. Install it with: sudo apt install jq" | tee -a "$LOG_PATH"
    exit 1
fi

# Extract fields
IMAGE_URL=$(echo "$RESPONSE" | jq -r '.url')
MEDIA_TYPE=$(echo "$RESPONSE" | jq -r '.media_type')
TITLE=$(echo "$RESPONSE" | jq -r '.title')
EXPLANATION=$(echo "$RESPONSE" | jq -r '.explanation')

# Validate media type
if [ "$MEDIA_TYPE" != "image" ]; then
    echo "⚠️ Today's APOD is not an image (media_type: $MEDIA_TYPE). Skipping." | tee -a "$LOG_PATH"
    echo "Title: $TITLE" | tee -a "$LOG_PATH"
    exit 0
fi

# Step 2: Download image
echo "📥 Downloading: $IMAGE_URL" | tee -a "$LOG_PATH"
if curl -s -o "$WALLPAPER_PATH" -L "$IMAGE_URL"; then
    echo "✅ Image saved: $WALLPAPER_PATH" | tee -a "$LOG_PATH"
else
    echo "❌ Failed to download image." | tee -a "$LOG_PATH"
    exit 1
fi

# Step 3: Set wallpaper with feh
if command -v feh >/dev/null 2>&1; then
    feh --bg-scale "$WALLPAPER_PATH"
    echo "🖼️ Wallpaper set successfully!" | tee -a "$LOG_PATH"

    # Optional: Desktop notification with title (requires notify-send)
    if command -v notify-send >/dev/null 2>&1; then
        notify-send "🌌 NASA Wallpaper Updated" "$TITLE" -i "$WALLPAPER_PATH"
    fi
else
    echo "❌ 'feh' not found. Install it with: sudo apt install feh" | tee -a "$LOG_PATH"
    exit 1
fi

# Optional: Print explanation to log (great for learning!)
echo "" >> "$LOG_PATH"
echo "📖 Title: $TITLE" >> "$LOG_PATH"
echo "📝 Explanation: $EXPLANATION" >> "$LOG_PATH"
echo "---" >> "$LOG_PATH"

echo "✨ Done! Enjoy today’s cosmic view." | tee -a "$LOG_PATH"

exit 0
