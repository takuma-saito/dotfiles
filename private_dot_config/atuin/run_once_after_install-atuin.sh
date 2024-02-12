#!/bin/bash -euC
cat <<EOF | op inject | sh
atuin login \
  --username "{{ op://Personal/atuin/username }}" \
  --password "{{ op://Personal/atuin/password }}" \
  --key "{{ op://Personal/atuin/key }}"
atuin sync -f
atuin status
EOF
