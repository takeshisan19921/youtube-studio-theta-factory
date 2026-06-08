FROM pytorch/pytorch:2.6.0-cuda12.4-cudnn9-runtime

ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    HF_HOME=/opt/chatterbox-cache/huggingface \
    XDG_CACHE_HOME=/opt/chatterbox-cache \
    THETA_CHATTERBOX_TURBO_SSH_IMAGE=1

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      ca-certificates curl ffmpeg git libsndfile1 openssh-server rsync tini && \
    rm -rf /var/lib/apt/lists/*

RUN ln -sf "$(command -v python)" /usr/local/bin/python3 && \
    python --version && \
    python3 --version

RUN python -m pip install --upgrade pip setuptools wheel && \
    python -m pip install --no-cache-dir chatterbox-tts "torchvision==0.21.0"

RUN python - <<'PY'
import json
import torch
import torchaudio
from chatterbox.tts_turbo import ChatterboxTurboTTS

print(json.dumps({
    "torch": torch.__version__,
    "torchaudio": torchaudio.__version__,
    "cuda_build": torch.version.cuda,
    "chatterbox_turbo_import": True,
}, sort_keys=True), flush=True)

# Cache model weights in the image so Theta jobs do not pay the download cost.
model = ChatterboxTurboTTS.from_pretrained(device="cpu")
print(json.dumps({
    "chatterbox_turbo_cached": True,
    "sample_rate": getattr(model, "sr", None),
}, sort_keys=True), flush=True)
PY

COPY entrypoint.sh /usr/local/bin/theta-chatterbox-turbo-entrypoint
RUN chmod 0755 /usr/local/bin/theta-chatterbox-turbo-entrypoint

WORKDIR /workspace
EXPOSE 22

ENTRYPOINT ["/usr/bin/tini", "--", "/usr/local/bin/theta-chatterbox-turbo-entrypoint"]
