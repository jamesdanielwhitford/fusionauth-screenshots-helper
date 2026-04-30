# FusionAuth Screenshots Helper

This repo contains everything needed to take replacement screenshots for the FusionAuth Azure AD B2C migration docs guide. Read through the article first to understand the context of each screenshot before starting.

- **Docs guide** (branch `refresh/azure-ad-b2c-docs`): https://github.com/ritza-co/fusionauth-site/blob/refresh/azure-ad-b2c-docs/astro/src/content/docs/lifecycle/migrate-users/provider-specific/azureadb2c.mdx

## Step 1: Install dependencies

```bash
brew install imagemagick
```

Also make sure Docker Desktop is installed and running.

## Step 2: macOS settings

- System Settings > Appearance > set to **Light** mode
- System Settings > Appearance > turn **off** "Allow wallpaper tinting in windows"
- Make sure your desktop background is a light or neutral color -- the drop-shadow on screenshots is transparent, so a dark background will bleed through

## Step 3: Clone the fusionauth-site repo and check out the branch

```bash
git clone https://github.com/ritza-co/fusionauth-site.git
cd fusionauth-site
git checkout refresh/azure-ad-b2c-docs
```

## Step 4: Review which screenshots are needed

All screenshots go in `astro/public/img/docs/lifecycle/migrate-users/provider-specific/azureadb2c/`. These are the 9 to retake (all FusionAuth admin UI -- no Azure portal screenshots are needed):

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

## Step 5: Start FusionAuth

From this repo's directory:

```bash
docker compose up -d
```

Wait about 30 seconds for FusionAuth to start.

## Step 6: Log in to FusionAuth

Open Safari and go to `http://localhost:9011`. Log in with:

- Email: `admin@fusionauth.io`
- Password: `password`

The kickstart will have pre-populated 7 Silicon Valley users (Erlich Bachman, Richard Hendricks, Dinesh Chugtai, Bertram Gilfoyle, Jared Dunn, Monica Hall, Nelson Bighetti) all with password `password`.

## Step 7: Take each screenshot

For each screenshot in the table above:

**1. Run the sizing script** (from this repo's directory):

```bash
./fa-screenshot.sh
```

This resizes the Safari window to the correct dimensions, disables wallpaper tinting if needed, and saves an automatic screenshot to `~/Desktop/screenshots/` -- this is the screenshot you will use.

**2. Navigate Safari** to the relevant screen in the FusionAuth admin UI at `http://localhost:9011/admin`.

**3. Replace the URL** in the Safari address bar with the following before taking the screenshot -- the FusionAuth contributing guidelines require this hostname to appear in the bar. Copy this exactly so the spacing centers it correctly:

```
                                      local.fusionauth.io
```

**4. Use the script's screenshot** saved in `~/Desktop/screenshots/` -- it already has the correct dimensions.

If a screenshot needs to be taller than the script's window allows (content is cut off at the bottom), drag the Safari window taller -- do not make it narrower. Then use `CMD+Shift+4+Space` and click the Safari window to capture manually instead of using the script's screenshot. Do not run the script again as it will resize the window.

## Step 8: Set up the import tenant (for `list-users.png` only)

The `list-users.png` screenshot shows a user that has been migrated into a tenant called "AD B2C Import". After starting FusionAuth and logging in, run:

```bash
./setup-import-tenant.sh
```

This creates the "AD B2C Import" tenant and adds a user with the correct email, name, and Azure AD B2C username to match the original screenshot. Then go to Users, search for "test", and take the screenshot from there.

## Step 9: Crop if needed

Open the screenshot in Preview.app and crop top/bottom only -- never crop the sides. If you crop, note which edge so the `top-cropped` or `bottom-cropped` class can be added in the MDX.

## Full style guide

See `FUSIONAUTH-CONTRIBUTING.md` for the full FusionAuth screenshot requirements.
