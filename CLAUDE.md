# cork-e.eu website: context for Claude

Public website of Cork-e, served from the VPS by the shared Caddy (not GitHub
Pages any more). See README.md for the layout, URL rules, deploying and the
GitHub Action. Workspace-wide context (brand, vision, hosting plan) is in
`../CLAUDE.md`.

## Current state: placeholder only

`main` is a deliberately bare page: logo and name, no information about the
tools or the audience, `noindex`. The owner doesn't want to publish more yet.

The **privacy policy** is on `main`, split in three (2026-10-19), because not
every Klok user uses the Kalender: `site/privacy.html` (Cork-e: account, family,
rights; the URL Google's consent screen links to, keep it stable),
`site/privacy-klok.html` and `site/privacy-kalender.html`, each mirrored in
`site/en/`, styled by `site/privacy.css`. It was
written on 2026-10-18 from the actual code and server (tables in
`../cork-e-platform/corke/db.py`, Google scopes in `corke/gcal.py`, cookies in
`corke/auth.py`, no visitor IP logging, backups 30 days). Re-check it against
those whenever data, cookies, Google scopes, processors or hosting change, and
update the date and both languages.

The full landing page is kept on the local branch **`full-site`** (its own,
older privacy text there is superseded by `main`). Do not push that branch
while the repo is public: anything pushed to a public repo is readable on
GitHub even if Pages doesn't serve it.

## Planned next version of the page

Two buttons: **KinderKlok** and **KinderKalender** (names may change).
- Not signed in → the button opens a demo of the tool (no account, sample data).
- Signed in → it opens the full tool with the family's own data.
The page can ask `GET /api/me` (401 = not signed in) once the site and the tools
share an origin, or the tools themselves decide demo vs. full at their own URL.

## Conventions

- Plain HTML/CSS, no build step, no cookies, no third-party requests (fonts are
  self-hosted). The privacy policy says so; keep it true.
- The privacy policy must be online **before** test families sign in
  (GDPR, and Google requires it for a production OAuth app). When it goes
  back, check it still matches what `../cork-e-platform` stores and where it runs.
- Contact address: info@cork-e.eu. Data controller: Jessa Bekker (private
  person) until a business is registered.
- Preview on port 8710 (`python3 -m http.server 8710 --bind 127.0.0.1 --directory site`).
- Only `site/` is published. The GitHub Action's key can only write into
  `/opt/www/cork-e/site`; Caddy changes (`deploy/cork-e-site.caddy`) go by hand
  with `deploy/deploy.sh`.
- `/klok` and `/kalender` on cork-e.eu redirect to app.cork-e.eu; never put
  files under `site/klok/` or `site/kalender/`.
