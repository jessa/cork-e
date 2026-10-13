# cork-e.eu website: context for Claude

Public website of Cork-e. See README.md for the file layout, local preview and
GitHub Pages setup. Workspace-wide context (brand, vision, hosting plan) is in
`../CLAUDE.md`.

## Current state: placeholder only

`main` is a deliberately bare page: logo and name, no information about the
tools or the audience, `noindex`. The owner doesn't want to publish more yet.

The full landing page and the privacy policy (Dutch + English) are kept on the
local branch **`full-site`**. Do not push that branch while the repo is public:
anything pushed to a public repo is readable on GitHub even if Pages doesn't
serve it.

## Planned next version of the page

Two buttons: **KinderKlok** and **KinderKalender** (names may change).
- Not signed in → the button opens a demo of the tool (no account, sample data).
- Signed in → it opens the full tool with the family's own data.
The page can ask `GET /api/me` (401 = not signed in) once the site and the tools
share an origin, or the tools themselves decide demo vs. full at their own URL.

## Conventions

- Plain HTML/CSS, no build step, no cookies, no third-party requests (fonts are
  self-hosted). The privacy policy on `full-site` says so; keep it true.
- The privacy policy must be online **before** test families sign in
  (GDPR, and Google requires it for a production OAuth app). When it goes
  back, check it still matches what `../platform` stores and where it runs.
- Contact address: info@cork-e.eu. Data controller: Jessa Bekker (private
  person) until a business is registered.
- Preview on port 8710 (`python3 -m http.server 8710 --bind 127.0.0.1`).
