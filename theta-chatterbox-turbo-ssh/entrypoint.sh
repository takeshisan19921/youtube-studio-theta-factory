#!/usr/bin/env bash
set -Eeuo pipefail

mkdir -p /var/run/sshd /root/.ssh
chmod 0700 /root/.ssh

if [[ -n "${SSH_PUBLIC_KEY:-}" ]]; then
  printf '%s\n' "$SSH_PUBLIC_KEY" > /root/.ssh/authorized_keys
  chmod 0600 /root/.ssh/authorized_keys
else
  echo "warning: SSH_PUBLIC_KEY is empty; SSH login will not be authorized" >&2
fi

ssh-keygen -A >/dev/null

python3 - <<'PY'
import json
import torch
from chatterbox.tts_turbo import ChatterboxTurboTTS

print(json.dumps({
    "THETA_IMAGE": "chatterbox_turbo_ssh",
    "torch": torch.__version__,
    "cuda_available": torch.cuda.is_available(),
    "cuda_device": torch.cuda.get_device_name(0) if torch.cuda.is_available() else None,
    "chatterbox_turbo_import": ChatterboxTurboTTS is not None,
}, sort_keys=True), flush=True)
PY

exec /usr/sbin/sshd -D -e
