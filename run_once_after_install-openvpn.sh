#!/bin/bash -eu
eval "$(/opt/homebrew/bin/brew shellenv)"
readonly OPENVPN_HOME=/usr/local/openvpn
readonly OPENVPN_PLIST_NAME=jp.theport.openvpn
sudo mkdir -p $OPENVPN_HOME{,/sbin,/log,/etc}
cd "$(dirname "$0")"
cat <<EOF | sudo tee /Library/LaunchDaemons/$OPENVPN_PLIST_NAME.plist >/dev/null
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>KeepAlive</key>
    <false/>
    <key>Label</key>
    <string>$OPENVPN_PLIST_NAME</string>
    <key>UserName</key>
    <string>root</string>
    <key>ProgramArguments</key>
    <array>
        <string>$OPENVPN_HOME/sbin/run-openvpn-port</string>
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
cat <<EOF | op inject | sudo tee $OPENVPN_HOME/etc/user_password.txt >/dev/null
{{ op://Personal/PORT_OPENVPN_AUTH_USER_PASS/username }}
{{ op://Personal/PORT_OPENVPN_AUTH_USER_PASS/password }}
EOF
sudo chmod 600 $OPENVPN_HOME/etc/user_password.txt
cat <<EOF | op inject | sudo tee $OPENVPN_HOME/etc/port_openvpn.conf >/dev/null
{{ op://Personal/port_openvpn/port_openvpn.conf }}
auth-user-pass $OPENVPN_HOME/etc/user_password.txt
EOF
cat <<EOF | sudo tee $OPENVPN_HOME/sbin/run-openvpn-port >/dev/null
#!/bin/bash -euC
$(brew --prefix)/sbin/openvpn --config $OPENVPN_HOME/etc/port_openvpn.conf
EOF
sudo chmod +x $OPENVPN_HOME/sbin/run-openvpn-port
sudo launchctl load /Library/LaunchDaemons/$OPENVPN_PLIST_NAME.plist
