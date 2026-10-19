# cork-e.eu

The public website of Cork-e: a placeholder page (logo + name) and the privacy
policy (Dutch + English). Plain HTML and CSS, no build step. Served by the
server's shared Caddy (`../server`), next to `app.cork-e.eu`.

```
site/                      what is published (index.html, privacy*.html, en/, styles, fonts, logo)
deploy/cork-e-site.caddy   Caddy site file for cork-e.eu and www.cork-e.eu
deploy/deploy.sh           upload site/ + the Caddy file and reload Caddy (from the Mac)
.github/workflows/         uploads site/ on every push to main (restricted key)
```

## URL rules (deploy/cork-e-site.caddy)

| Request | Result |
|---|---|
| `www.cork-e.eu/…` | 301 → `cork-e.eu/…` |
| `cork-e.eu/klok`, `/klok/…` (also via www) | 301 → `app.cork-e.eu/klok/…`, path and query kept |
| `cork-e.eu/kalender`, `/kalender/…` (also via www) | 301 → `app.cork-e.eu/kalender/…` |
| anything else | the file from `site/`; a folder without `/` gets a redirect to `…/` |

(The trailing-slash rule for `app.cork-e.eu/klok/…` lives in
`../cork-e-platform/deploy/cork-e.caddy`.)

## Preview locally

```bash
python3 -m http.server 8710 --bind 127.0.0.1 --directory site
```

## Deploy

```bash
deploy/deploy.sh
```

## Automatic deploys (GitHub Actions)

`.github/workflows/deploy.yml` uploads `site/` when it changes on `main`. Its
key may only rsync into `/opt/www/cork-e/site`. One-time setup:

1. Make a key pair just for this (no passphrase), on the Mac:
   `ssh-keygen -t ed25519 -N "" -C github-actions-cork-e -f ~/.ssh/cork-e-site-deploy`
2. On the server, append to `/home/deploy/.ssh/authorized_keys` (one line):
   `command="/usr/bin/rrsync /opt/www/cork-e/site",restrict ssh-ed25519 AAAA… github-actions-cork-e`
   (the `AAAA…` part from `~/.ssh/cork-e-site-deploy.pub`).
3. In GitHub, repo **Settings → Secrets and variables → Actions**, add:
   - `DEPLOY_SSH_KEY`: the contents of `~/.ssh/cork-e-site-deploy` (the private key);
   - `DEPLOY_KNOWN_HOSTS`: the output of `ssh-keyscan -t ed25519 app.cork-e.eu`.
4. Run the workflow once by hand (**Actions → Deploy cork-e.eu → Run workflow**).

## Privacy policy

Three pages, each in Dutch (`site/`) and English (`site/en/`):

| Page | Covers | Link from |
|---|---|---|
| `privacy.html` | Cork-e itself: controller, account and cookies, family and children, processors, rights, deletion | Google's OAuth consent screen, the placeholder, both tools |
| `privacy-klok.html` | routines, the copy on the device, Chromecast | KinderKlok |
| `privacy-kalender.html` | people and photos, calendar settings, pictures, Google Calendar (scopes, Limited Use) | KinderKalender |

Not every Klok user uses the Kalender, so tool-specific data stays on the tool's
page. They describe what `../cork-e-platform` stores and where it runs. When
that changes, update both languages and the date.
