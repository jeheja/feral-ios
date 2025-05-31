# Feral iOS Customization Summary

This document summarizes all customizations applied to transform Element iOS into Feral iOS.

## 1. App Name Customization ✅
- **File**: `project.yml`
  - Changed app name to "Feral"
- **File**: `app.yml`
  - Updated `APP_DISPLAY_NAME` to "Feral"
  - Updated `PRODUCTION_APP_NAME` to "Feral"
  - Updated bundle identifier to `io.feral.app`
  - Updated app group identifier to `group.io.feral`

## 2. Server Configuration ✅
- **File**: `ElementX/Sources/Application/AppSettings.swift`
  - Implemented locale-based server selection with `getFeralAccountProviders()` function
  - Updated all URLs from element.io to feralisme.fr domains
  - Configured multiple Feral servers (feralisme.fr, feralism.net, etc.)
  - Pre-selection based on user's locale (French users get feralisme.fr, others get feralism.net)

## 3. Server Validation ✅
- **File**: `ElementX/Sources/Services/Authentication/AuthenticationService.swift`
  - Added `isAllowedFeralServer()` function to validate only Feral servers are allowed
  - Prevents users from connecting to non-Feral Matrix servers
  - Allowed servers: feralisme.fr, feralism.net, feralism.eu, feral.chat

## 4. Color/Theme Customization ✅
- **File**: `ElementX/Resources/Assets.xcassets/colors/accent-color.colorset/Contents.json`
  - Updated accent color to Feral golden (#D4AF37)
  - RGB values: R: 0.831, G: 0.686, B: 0.216
- **File**: `ElementX/Resources/Assets.xcassets/colors/background-color.colorset/Contents.json`
  - Updated dark mode background to deep forest (#0F2C1E)
  - RGB values: R: 0.059, G: 0.173, B: 0.118

## 5. Icon/Branding Changes 📝
- Created `ICON_REPLACEMENT_GUIDE.md` with instructions for manual icon replacement
- Icons that need replacement:
  - App Icon: `AppIcon.appiconset/AppIcon.png` (1024x1024 PNG)
  - App Logo: `app-logo.imageset/app-logo.pdf` (Vector PDF)

## 6. Additional Configurations
- Push gateway URL updated to feralisme.fr
- OIDC redirect URL updated to feralisme.fr
- Web hosts updated for Feral domains
- Analytics and privacy policy URLs updated

## Testing Checklist
- [ ] App launches with Feral branding
- [ ] Server selection shows Feral servers based on locale
- [ ] Cannot add custom non-Feral servers
- [ ] Colors appear correctly in light and dark mode
- [ ] All links point to Feral domains
- [ ] Authentication works with Feral servers

## Next Steps
1. Replace icon files as per ICON_REPLACEMENT_GUIDE.md
2. Test on various iOS devices and locales
3. Verify all customizations work as expected
4. Consider adding more regional Feral servers as they become available