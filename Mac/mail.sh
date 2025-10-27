#!/bin/bash
osascript <<EOF
tell application "Mail"
set unreadCount to unread count of inbox
end tell
EOF

