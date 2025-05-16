#!/bin/sh
for file in *.mp4; do
    palette="${file%.mp4}-palette.png"
    gif="${file%.mp4}.gif"
    # Generate palette
    ffmpeg -i "$file" -vf "fps=15,scale=640:-1:flags=lanczos,palettegen" -y "$palette"
    # Use palette to create high-quality GIF
    ffmpeg -i "$file" -i "$palette" -lavfi "fps=15,scale=640:-1:flags=lanczos [x]; [x][1:v] paletteuse" -y "$gif"
    # Cleanup palette
    rm "$palette"
done

