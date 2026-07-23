# Task: Spring Initializr screenshot for the Spring Boot API quickstart guide

## Context

Richard reviewed the FusionAuth Spring Boot API quickstart guide (`fusionauth-site` PR #388, branch
`ritza/migrate-java-springboot-api-bluehawk`) and suggested a screenshot of the Spring Initializr
form to make the "Generate the Project" section clearer — specifically so a reader can see exactly
which fields need to change from Initializr's defaults, since this is what determines the Java
package path used throughout the rest of the guide (see `PanicResponse.java`'s "base package"
location).

This is **not** the FusionAuth admin UI — it's a screenshot of a third-party public site
(`https://start.spring.io/`). The rest of this repo (`fa-screenshot.sh`, `docker-compose.yml`,
`kickstart.json`) was built for a different, unrelated task (Azure AD B2C admin-UI screenshots) —
ignore those files for this task except for `fa-screenshot.sh` itself, which is reused here purely
for its window-sizing/capture mechanics.

Full write-up of the guide review (Richard's original feedback + what was fixed + the root cause of
his "couldn't get the final demo to work" report) is in the main `fusionauth` repo at
`~/ritza/fusionauth/analysis/qa-quickstarts/richard-springboot-reply-2026-07-23.md` — read that
first for the full picture if useful, but it's not required to complete this screenshot task.

## What the screenshot needs to show

**Not the default landing page.** Several fields must be explicitly changed from Initializr's
defaults before capturing:

| Field | Required value | Default (what you'll see before changing it) |
|---|---|---|
| Project | Maven | Usually already Maven — verify |
| Language | Java | Java (no change needed) |
| Spring Boot | **4.0.7** | Defaults to the newest stable — must be explicitly selected |
| Group | **`io.fusionauth.quickstart`** | `com.example` |
| Artifact | **`springapi`** | `demo` |
| Name | **`FusionAuthQuickstart`** | Auto-fills from Artifact — must be explicitly overwritten |
| Packaging | Jar | Jar (no change needed) |
| Java | **17** | Defaults to the newest LTS — must be explicitly selected |
| Dependencies | **OAuth2 Resource Server** and **Spring Web** added | none selected by default |

Once dependencies are added via the search box, they show as small chips/tags near the top of the
form — make sure both are visible and selected in the shot.

## Steps

1. Go to `https://start.spring.io/` in Safari.
2. Set every field above to its required value.
3. Add both dependencies via the dependency search box on the right.
4. Run the sizing script from this repo's directory:

   ```bash
   ./fa-screenshot.sh -u "https://start.spring.io/" -f spring-initializr-config
   ```

   This resizes the Safari window to the standard FusionAuth-docs dimensions (1080×1100, per
   `fa-screenshot.sh`), disables wallpaper tinting if needed, and saves the screenshot to
   `~/Desktop/screenshots/spring-initializr-config.png` at 1600px wide (matching
   `fusionauth-site`'s `CONTRIBUTING.md` screenshot convention).

   Note: passing `-u` navigates Safari's front document to that URL right before capture — so
   configure all the fields in step 2 in a Safari tab first, *then* run the script, since it will
   navigate to a fresh copy of the page. **Better approach:** configure the form manually in Safari
   first, then run `./fa-screenshot.sh -f spring-initializr-config` *without* `-u` — this resizes the
   window and screenshots whatever is already showing, without re-navigating and losing your
   selections. Only use `-u` if you want it to load a blank Initializr page for you to then configure
   *inside* the resized window.

5. If the form is too tall to fit inside the script's window and gets cut off at the bottom: don't
   make the window narrower — drag it taller instead, then capture manually with
   `CMD+Shift+4+Space` (click the Safari window rather than dragging a selection box) instead of
   relying on the script's own screenshot. Note whether you cropped top or bottom afterward.
6. Crop top/bottom only in Preview.app if needed (never crop the sides). Track which edge you
   cropped — the doc will need a `top-cropped` or `bottom-cropped` class on the image if so.
7. Send the final PNG back — it'll be added under the guide's image folder alongside the
   "Generate the Project" section, with a full-sentence alt text describing the form's contents per
   `fusionauth-site/CONTRIBUTING.md`'s image rules (e.g. "The Spring Initializr form configured with
   Group io.fusionauth.quickstart, Artifact springapi, Name FusionAuthQuickstart, Spring Boot 4.0.7,
   Java 17, and the OAuth2 Resource Server and Spring Web dependencies added.").

## Full style reference

See `FUSIONAUTH-CONTRIBUTING.md` in this same repo for the complete FusionAuth screenshot style
guide (light mode, wallpaper tinting off, 1600px final width, red-rectangle-weight-5 highlights,
etc.) if anything above is unclear.
