# Agentmaxxing

Discourse theme component for [agentmaxing.org](https://agentmaxing.org).

A *component* rather than a full theme: it layers on top of Discourse's
default theme, so upstream design updates keep arriving and this repo only
holds the differences.

## Layout

| Path | Purpose |
|---|---|
| `about.json` | Theme manifest. Discourse reads this first |
| `common/common.scss` | Styles for all devices |
| `desktop/desktop.scss` | Desktop-only styles |
| `mobile/mobile.scss` | Mobile-only styles |
| `javascripts/discourse/api-initializers/` | Frontend behavior |
| `locales/en.yml` | Translatable strings and setting descriptions |

## Installing on the forum

`/admin/customize/themes` → **Install** → **From a git repository** →

```
https://github.com/DavidChen-006/agentmaxxing-theme
```

Then add it as a component to the active theme. After that, **Check for
updates** pulls whatever has been pushed here.

## Local development

GitHub is the source of truth. The live theme on agentmaxing.org is
git-linked (theme id 1), so the only path from a local edit to the live site
is: commit, push, tell Discourse to pull.

```bash
./deploy.sh "what you changed"
```

That commits, pushes to `main`, triggers `remote_update` on the live theme,
and prints whether the live version matches the remote. Takes a few seconds.

The API key is read from `~/.discourse_theme` and never printed or committed.
Create one at `/admin/api/keys` (Single User, Global scope); the file is
written the first time you run `discourse_theme watch .`.

### Why not `discourse_theme watch`?

The CLI's watch mode pushes local files straight to the site over the API,
bypassing git entirely. That is faster — sub-second — but the live site then
drifts from GitHub, and the next `remote_update` silently overwrites it with
whatever is on `main`. Since this theme is git-linked, `deploy.sh` is the
path that keeps the two in agreement.

If you want the fast loop for a heavy CSS session, point `watch` at a
*separate* unattached theme, then move the result here and deploy. Do not
point it at theme 1.


## Notes

- The live component is theme id 1, attached to the **Foundation** theme.
  Installing a component only makes it available; it renders only once added
  under Components on the active theme.
- Extend core UI through **plugin outlets**, not by overriding core
  components. Outlets are a supported API and survive upgrades. Find them by
  searching the Discourse source for `<PluginOutlet @name=`.
- Anything needing server-side code — new routes, tables, endpoints — is a
  *plugin*, not a theme, and installs via `containers/app.yml` plus a
  `./launcher rebuild app`.
