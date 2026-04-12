#!/usr/bin/env python3
"""
Send EPUB files to Kindle via email using Gmail SMTP
"""

import smtplib
import sys
import os
from email.mime.multipart import MIMEMultipart
from email.mime.base import MIMEBase
from email.mime.text import MIMEText
from email import encoders

def send_to_kindle(epub_file, kindle_email, gmail_address, gmail_app_password):
    """Send EPUB file to Kindle email address via Gmail"""

    if not os.path.exists(epub_file):
        print(f"Error: File not found: {epub_file}")
        return False

    # Create message
    msg = MIMEMultipart()
    msg['From'] = gmail_address
    msg['To'] = kindle_email
    msg['Subject'] = os.path.basename(epub_file)

    # Add body
    body = "Sent from Obsidian"
    msg.attach(MIMEText(body, 'plain'))

    # Attach EPUB file
    try:
        filename = os.path.basename(epub_file)
        with open(epub_file, 'rb') as f:
            part = MIMEBase('application', 'epub+zip')
            part.set_payload(f.read())
            encoders.encode_base64(part)
            part.add_header('Content-Disposition', 'attachment', filename=filename)
            part.add_header('Content-Type', 'application/epub+zip', name=filename)
            msg.attach(part)
    except Exception as e:
        print(f"Error attaching file: {e}")
        return False

    # Send email
    try:
        with smtplib.SMTP_SSL('smtp.gmail.com', 465) as server:
            server.login(gmail_address, gmail_app_password)
            server.send_message(msg)
        return True
    except Exception as e:
        print(f"Error sending email: {e}")
        return False

if __name__ == "__main__":
    # Load configuration from scripts folder
    SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
    CONFIG_FILE = os.path.join(SCRIPT_DIR, ".kindle-config")

    if not os.path.exists(CONFIG_FILE):
        print("Error: Configuration file not found")
        print(f"Please create {CONFIG_FILE} with:")
        print("KINDLE_EMAIL=your-kindle@kindle.com")
        print("GMAIL_ADDRESS=your-email@gmail.com")
        print("GMAIL_APP_PASSWORD=your-app-password")
        sys.exit(1)

    # Load config
    config = {}
    with open(CONFIG_FILE) as f:
        for line in f:
            line = line.strip()
            if line and not line.startswith('#'):
                key, value = line.split('=', 1)
                config[key] = value

    if len(sys.argv) < 2:
        print("Usage: send-to-kindle.py <epub-file>")
        sys.exit(1)

    epub_file = sys.argv[1]

    print(f"Sending {os.path.basename(epub_file)} to Kindle...")

    success = send_to_kindle(
        epub_file,
        config['KINDLE_EMAIL'],
        config['GMAIL_ADDRESS'],
        config['GMAIL_APP_PASSWORD']
    )

    if success:
        print("✓ Successfully sent to Kindle!")
    else:
        print("✗ Failed to send to Kindle")
        sys.exit(1)
