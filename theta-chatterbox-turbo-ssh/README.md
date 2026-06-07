# Theta Chatterbox Turbo SSH Image

Theta EdgeCloud worker image for Chatterbox Turbo technical smoke tests and future audio workers.

Includes PyTorch 2.6 CUDA 12.4, `chatterbox-tts==0.1.7`, a cached `ResembleAI/chatterbox-turbo` model snapshot, SSH, ffmpeg, git, curl, rsync, libsndfile, and tini.

Does not include secrets, voice references, scripts, IDrive credentials, generated media, or final packages.
