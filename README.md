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

The CLI syncs a local folder to the live site on every save — no commit, no
push, no clicking.

```bash
gem install discourse_theme
discourse_theme watch .
```

First run asks for the site URL (`https://agentmaxing.org`) and an API key
from `/admin/api/keys`. It stores them in `~/.discourse_theme`.

Changes appear in the browser about a second after saving. Nothing is
committed automatically — git is still yours to drive.

## Notes

- `common.scss` ships an install-check rule that puts a colored bar under the
  site header. Delete it once you've confirmed the component is live.
- Extend core UI through **plugin outlets**, not by overriding core
  components. Outlets are a supported API and survive upgrades. Find them by
  searching the Discourse source for `<PluginOutlet @name=`.
- Anything needing server-side code — new routes, tables, endpoints — is a
  *plugin*, not a theme, and installs via `containers/app.yml` plus a
  `./launcher rebuild app`.
