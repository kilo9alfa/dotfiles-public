#!/bin/bash
# Convert Obsidian note to EPUB for Kindle and auto-send

set -e  # Exit on error

INPUT_FILE="$1"
FILENAME=$(basename "$INPUT_FILE" .md)
TEMP_DIR="/tmp/KindleEpub"
EPUB_FILE="$TEMP_DIR/$FILENAME.epub"

# Load configuration from scripts folder
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="$SCRIPT_DIR/.kindle-config"

# Read ARCHIVE_DIR from config file
if [ -f "$CONFIG_FILE" ]; then
    ARCHIVE_DIR=$(grep "^ARCHIVE_DIR=" "$CONFIG_FILE" | cut -d'=' -f2)

    # If ARCHIVE_DIR is relative, make it relative to the script directory
    if [[ ! "$ARCHIVE_DIR" = /* ]]; then
        ARCHIVE_DIR="$SCRIPT_DIR/../$ARCHIVE_DIR"
    fi
else
    # Default fallback
    ARCHIVE_DIR="$SCRIPT_DIR/../KindleArchive"
fi

echo "=== Obsidian → Kindle Automation ==="
echo ""

# Create directories if they don't exist
mkdir -p "$TEMP_DIR"
mkdir -p "$ARCHIVE_DIR"

# Step 1: Convert to EPUB
echo "1. Converting to EPUB..."
/opt/homebrew/bin/pandoc "$INPUT_FILE" \
    --from markdown \
    --to epub \
    -o "$EPUB_FILE" \
    --metadata title="$FILENAME"

if [ ! -f "$EPUB_FILE" ]; then
    echo "✗ Error: EPUB conversion failed"
    exit 1
fi

echo "   ✓ Created: $FILENAME.epub"
echo ""

# Step 2: Email to Kindle
echo "2. Sending to Kindle..."

# Use Python helper script to send via Gmail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if python3 "$SCRIPT_DIR/send-to-kindle.py" "$EPUB_FILE"; then
    echo "   ✓ Email sent to Kindle"

    # Mark source note's frontmatter with SentToKindle: yes
    python3 - "$INPUT_FILE" <<'PYEOF'
import sys, re, pathlib
p = pathlib.Path(sys.argv[1])
text = p.read_text(encoding="utf-8")
fm_re = re.compile(r"\A---\n(.*?)\n---\n", re.DOTALL)
m = fm_re.match(text)
if m:
    body = text[m.end():]
    fm = m.group(1)
    if re.search(r"^SentToKindle\s*:", fm, re.MULTILINE):
        fm = re.sub(r"^SentToKindle\s*:.*$", "SentToKindle: yes", fm, count=1, flags=re.MULTILINE)
    else:
        fm = fm + "\nSentToKindle: yes"
    new = f"---\n{fm}\n---\n{body}"
else:
    new = f"---\nSentToKindle: yes\n---\n\n{text}"
p.write_text(new, encoding="utf-8")
print("   ✓ Marked source note: SentToKindle: yes")
PYEOF
else
    echo "   ⚠ Warning: Failed to send email"
    echo "   → EPUB created but not emailed"
    echo "   → Check scripts/.kindle-config file"
fi

echo ""

# Step 3: Move to archive
echo "3. Archiving EPUB..."
mv "$EPUB_FILE" "$ARCHIVE_DIR/"
echo "   ✓ Moved to: $ARCHIVE_DIR/"

echo ""
echo "=== Complete! ==="
echo "→ Check your Kindle for: $FILENAME"