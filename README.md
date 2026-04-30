# FusionAuth Screenshots Helper

This repo contains everything needed to take replacement screenshots for two FusionAuth articles being refreshed.

## The article

- **Docs guide** (branch `refresh/azure-ad-b2c-docs`): https://github.com/ritza-co/fusionauth-site/blob/refresh/azure-ad-b2c-docs/astro/src/content/docs/lifecycle/migrate-users/provider-specific/azureadb2c.mdx

## Screenshots needed

All screenshots go in `astro/public/img/docs/lifecycle/migrate-users/provider-specific/azureadb2c/` in the `ritza-co/fusionauth-site` repo on the `refresh/azure-ad-b2c-docs` branch.

These are the 9 screenshots to retake (all FusionAuth admin UI, no Azure portal screenshots needed):

| Filename | What to capture |
|---|---|
| `configured-generic-connector.png` | Settings -> Connectors -> Generic Connector config screen |
| `connector-policies.png` | Tenants -> [tenant] -> Connectors tab, policy list |
| `add-connector-policy.png` | Add connector policy modal, filled in |
| `connector-policy-list-after-adding.png` | Connectors tab after policy has been added |
| `find-login-url.png` | Applications -> [app] -> OAuth tab, login URL field |
| `add-api-key.png` | Settings -> API Keys -> Add API key screen |
| `set-api-key-permissions.png` | API key permissions screen with POST /api/user/import selected |
| `list-of-tenants-delete-highlighted.png` | Tenants list with the delete button highlighted in red |
| `list-users.png` | Users list showing imported users |

Read through the docs article linked above to see the context around each screenshot before taking it.

## macOS setup (do once)

### 1. System settings

- System Settings > Appearance > set to **Light** mode
- System Settings > Appearance > turn **off** "Allow wallpaper tinting in windows"

The `fa-screenshot.sh` script will also disable wallpaper tinting automatically if it detects it is on.

### 2. Add hosts entry

```bash
echo "127.0.0.1 local.fusionauth.io" | sudo tee -a /etc/hosts
```

### 3. Install ImageMagick (required by the screenshot script)

```bash
brew install imagemagick
```

## Start FusionAuth

```bash
docker compose up -d
```

Wait about 30 seconds, then open http://local.fusionauth.io:9011 in Safari.

Login with:
- Email: `admin@fusionauth.io`
- Password: `password`

The kickstart will have pre-populated 7 Silicon Valley users (Erlich Bachman, Richard Hendricks, Dinesh Chugtai, Bertram Gilfoyle, Jared Dunn, Monica Hall, Nelson Bighetti) all with password `password`.

## Taking screenshots

### Step 1: Run the sizing script

```bash
./fa-screenshot.sh
```

This will:
- Resize the Safari window to the correct dimensions (1080x1100px)
- Disable wallpaper tinting if needed
- Take an automatic screenshot (ignore this one)

### Step 2: Navigate Safari to the right screen

Navigate to the FusionAuth admin UI at http://local.fusionauth.io:9011/admin and go to the relevant screen for each screenshot.

### Step 3: Capture

Use `CMD+Shift+4+Space` then click the Safari window to capture with drop-shadow. Screenshots save to `~/Desktop/` by default.

### Step 4: Resize to 1600px wide

```bash
sips --resampleWidth 1600 your-screenshot.png
```

### Step 5: Crop if needed

Open in Preview.app and crop top/bottom only (never sides) to remove unnecessary content. If you crop, note which edge was cropped -- the image will need a `top-cropped` or `bottom-cropped` class added in the MDX.

## Screenshot requirements (from FusionAuth CONTRIBUTING.md)

See `FUSIONAUTH-CONTRIBUTING.md` for the full style guide. Key screenshot rules:

- Light mode only
- Window width: 1080px (script handles this)
- Capture with `CMD+Shift+4+Space` for drop-shadow style
- Resize to 1600px wide after capture
- Crop top/bottom only, never sides
- Highlights (if needed) should be red rectangles, line weight 5, drawn in Preview
- Do not use cropping and drop-shadow on the same image
- Images must be PNG
