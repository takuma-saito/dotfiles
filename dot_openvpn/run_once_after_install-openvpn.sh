#!/bin/bash -eu
eval $(/opt/homebrew/bin/brew shellenv)
readonly OPENVPN_HOME=~/.openvpn
cd "$(dirname $0)"
cat <<EOF | tee ~/Library/LaunchAgents/$(id -un).openvpn.plist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>KeepAlive</key>
    <true/>
    <key>Label</key>
    <string>$(id -un).openvpn</string>
    <key>ProgramArguments</key>
    <array>
        <string>$OPENVPN_HOME/bin/run-openvpn-port</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>StandardErrorPath</key>
    <string>$OPENVPN_HOME/log/stderr.log</string>
    <key>StandardOutPath</key>
    <string>$OPENVPN_HOME/log/stdout.log</string>
    <key>WorkingDirectory</key>
    <string>$OPENVPN_HOME</string>
</dict>
</plist>
EOF
echo "%admin ALL = (root) NOPASSWD: $(which openvpn)" | sudo tee /private/etc/sudoers.d/openvpn
cat <<EOF | op inject > $OPENVPN_HOME/user_password.txt # TODO
{{ op://Personal/PORT_OPENVPN_AUTH_USER_PASS/username }}
{{ op://Personal/PORT_OPENVPN_AUTH_USER_PASS/password }}
EOF
chmod 600 $OPENVPN_HOME/user_password.txt
cat <<EOF | op inject >$OPENVPN_HOME/port_openvpn.conf
{{ op://Personal/port_openvpn/port_openvpn.conf }}
auth-user-pass $HOME/.openvpn/user_password.txt
EOF

