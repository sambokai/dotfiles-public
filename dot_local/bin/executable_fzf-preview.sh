#!/usr/bin/env bash

# Parameters
FILE="$1"
WIDTH="$2"
HEIGHT="$3"

# --- Helper Functions ---

# Check for command existence
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# --- Main Script ---

# 1. Handle Directories
if [[ -d "$FILE" ]]; then
    eza --tree --level=2 --icons --color=always "$FILE"
    exit 0
fi

# Get file extension in lowercase
ext="${FILE##*.}"
ext_lower=$(echo "$ext" | tr '[:upper:]' '[:lower:]')

# 2. Handle Images with chafa
case "$ext_lower" in
    png|jpg|jpeg|gif|webp|bmp|ico|tiff)
        if command_exists chafa; then
            # Auto-detect best format (sixel, kitty, iterm2, or symbols)
            chafa --size="${WIDTH}x${HEIGHT}" "$FILE"
        else
            echo "Image preview requires 'chafa'. Please install it."
        fi
        exit 0
        ;;
esac

# 3. Handle Text-Based Files with bat
case "$ext_lower" in
    txt|md|json|js|ts|py|go|rb|rs|c|cpp|h|sh|zsh|yaml|yml|xml|html|css|toml|ini|cfg|conf)
        if command_exists bat; then
            bat -n --color=always --line-range :500 "$FILE"
        else
            head -n 200 "$FILE"
        fi
        exit 0
        ;;
esac

# 4. Handle Specific File Types
case "$ext_lower" in
    pdf)
        if command_exists pdftotext; then
            pdftotext -layout "$FILE" - | head -n 200
        else
            echo "PDF preview requires 'pdftotext' from the 'poppler' package."
        fi
        exit 0
        ;;
    zip|tar|gz|bz2|xz|rar)
        if command_exists atool; then
            atool -l "$FILE"
        else
            echo "Archive preview requires 'atool'."
        fi
        exit 0
        ;;
esac

# 5. Fallback for other files (MIME type check)
if command_exists file; then
    mime_type=$(file --brief --mime-type "$FILE")
    if [[ "$mime_type" == text/* ]]; then
        if command_exists bat; then
            bat -n --color=always --line-range :500 "$FILE"
        else
            head -n 200 "$FILE"
        fi
        exit 0
    elif [[ "$mime_type" == image/* ]]; then
        if command_exists chafa; then
            chafa --size="${WIDTH}x${HEIGHT}" "$FILE"
        else
            echo "Image preview requires 'chafa'. Please install it."
        fi
        exit 0
    fi
fi

# 6. Default to binary file handler
echo "--- Binary File ---"
if command_exists file; then
    file "$FILE"
fi
if command_exists hexyl; then
    hexyl -n 256 "$FILE"
fi
exit 0
