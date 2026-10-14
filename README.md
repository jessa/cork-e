# cork-e.eu

The public website of Cork-e. For now a placeholder page with only the logo
and name. Plain HTML and CSS, no build step, served by GitHub Pages.

```
index.html        placeholder page
style.css         styles; palette from KinderKlok
logo.svg          logo and favicon
fonts/            Nunito ExtraBold (SIL Open Font License, see fonts/OFL.txt)
CNAME             custom domain for GitHub Pages
.nojekyll         serve files as-is, without Jekyll
```

The full landing page and privacy policy (Dutch + English) are on the local
branch `full-site`. Keep that branch local while the repo is public.

## Preview locally

```bash
python3 -m http.server 8710 --bind 127.0.0.1
```

Then open http://localhost:8710.

## Publish on GitHub Pages (one-time)

1. Create a **public** repo `cork-e` on GitHub and push only `main`
   (`git push -u origin main`).
   (GitHub Pages on a private repo needs a paid plan.)
2. Repo **Settings → Pages**: Source = *Deploy from a branch*, branch `main`,
   folder `/ (root)`. The custom domain `cork-e.eu` is picked up from `CNAME`.
3. In **Combell → DNS** for `cork-e.eu`, remove any existing A/AAAA records for
   the bare domain and `www`, then add:

   | Type | Name | Value |
   |---|---|---|
   | A | `@` | `185.199.108.153` |
   | A | `@` | `185.199.109.153` |
   | A | `@` | `185.199.110.153` |
   | A | `@` | `185.199.111.153` |
   | AAAA | `@` | `2606:50c0:8000::153` |
   | AAAA | `@` | `2606:50c0:8001::153` |
   | AAAA | `@` | `2606:50c0:8002::153` |
   | AAAA | `@` | `2606:50c0:8003::153` |
   | CNAME | `www` | `jessa.github.io.` |

   Leave the **MX** (mail) records alone.
4. Once GitHub shows the domain as verified (can take up to an hour), tick
   **Enforce HTTPS** in Settings → Pages.
5. Recommended: verify `cork-e.eu` for your GitHub account
   (GitHub **Settings → Pages → Add a domain**), so nobody else can claim it.

`cork-e.be` and `cork-e.com` should redirect (301) to `https://cork-e.eu`;
set that up in Combell's web-forwarding settings.

## Privacy policy

The privacy policy (on `full-site`) must be published before test families
sign in. It describes what the backend in `../cork-e-platform` stores and where it is
hosted (EU); when either changes, update both language versions and the date.
