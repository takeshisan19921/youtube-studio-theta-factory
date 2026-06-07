# YouTube Studio Theta Factory

Theta EdgeCloud worker images for YouTube Studio.

Provider policy:

- Theta is the default GPU lane for new YouTube Studio GPU work.
- Do not launch Salad workers from this repo.
- Do not bake secrets, voice references, scripts, generated media, IDrive credentials, or final packages into images.
- Durable outputs must sync to IDrive E2 under `youtube-studio/output/...`.
- Image existence is not upload-ready proof. READY/PASS still requires the project QC gates.

Images:

```text
ghcr.io/takeshisan19921/youtube-studio-theta-factory:theta-torch212-cu126
ghcr.io/takeshisan19921/youtube-studio-theta-factory:theta-chatterbox-turbo-017-cu124
```
