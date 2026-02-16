# Feral iOS Customization Summary

This document summarizes all customizations applied to transform Element X iOS into Feral iOS.
**Keep this updated after every change** so customizations can be re-applied after upstream merges.

---

## 1. App Name & Identifiers

### project.pbxproj (ElementX.xcodeproj/project.pbxproj)
- `APP_DISPLAY_NAME` = `Feral` (was "Element X")
- `PRODUCTION_APP_NAME` = `Feral` (was "Element")
- `BASE_BUNDLE_IDENTIFIER` = `io.feral.app` (was "io.element.elementx")
- `APP_GROUP_IDENTIFIER` = `group.io.feral` (was "group.io.element")

### app.yml
- `APP_DISPLAY_NAME: Feral`
- `PRODUCTION_APP_NAME: Feral`
- `BASE_BUNDLE_IDENTIFIER: io.feral.app`
- `APP_GROUP_IDENTIFIER: group.io.feral`

**Note**: `app.yml` is only used when regenerating the project with xcodegen. The actual build uses values from `project.pbxproj`.

---

## 2. Xcode Scheme Rename

- Renamed `ElementX.xcodeproj/xcshareddata/xcschemes/ElementX.xcscheme` to `Feral.xcscheme`
- The scheme appears as "Feral" in Xcode's scheme selector
- **Important**: The `.xcodeproj` folder and target names remain "ElementX" — do NOT rename these through Xcode UI as it breaks the project

---

## 3. Localized Strings

### InfoPlist.strings (35 files)
- **All languages**: Replaced "Element X" with "Feral" in permission descriptions (camera, location, microphone)
- **Files**: `ElementX/Resources/Localizations/*/InfoPlist.strings`

### Localizable.strings (38 files)
- **All languages**: Replaced "Element X" with "Feral" in app-facing strings
- **All languages**: Replaced `screen_qr_code_login_initial_state_subtitle` from "Only available if your account provider supports it." to "Scan the QR code with your other device."
- **Files**: `ElementX/Resources/Localizations/*/Localizable.strings`

---

## 4. Landing Page (Authentication Start Screen)

### AuthenticationStartScreen.swift
**File**: `ElementX/Sources/Screens/Authentication/StartScreen/View/AuthenticationStartScreen.swift`

**Changes**:
- Title: "FERAL" in New York Black serif, 44pt, 6pt letter tracking, all caps, white
- Subtitle: "FOR FERALISTS" in New York Regular serif, 13pt, 4pt tracking, uppercase, white at 45% opacity
- Background: Custom dark gradient (not the shared image asset), so the white logo/text is always visible regardless of system light/dark mode
- Buttons: Custom frosted glass style — `Color.white.opacity(0.1)` background with `RoundedRectangle(cornerRadius: 14)` and white border at 25% opacity
- Create account button: Text only, white at 60% opacity
- Version text: Completely hidden (invisible tap area preserved for 7-tap debug gesture)
- Layout: Logo and title grouped together in upper-center, balanced spacing

### AuthenticationStartLogo.swift
**File**: `ElementX/Sources/Screens/Authentication/StartScreen/View/AuthenticationStartLogo.swift`

**Changes**:
- Removed glass container, rounded square overlay, shadows, and blur effects
- Logo displayed directly: `Image(asset: Asset.Images.appLogo)` resizable at 160x160pt, white foreground color
- Clean white icon on dark background, no container

### AuthenticationStartScreenBackgroundImage.swift
**File**: `ElementX/Sources/Screens/Authentication/StartScreen/View/AuthenticationStartScreenBackgroundImage.swift`

**Changes**: None — restored to original (uses `Asset.Images.launchBackground` image). The landing page uses its own inline dark gradient instead of this shared component.

---

## 5. Login Screen

### LoginScreen.swift
**File**: `ElementX/Sources/Screens/Authentication/LoginScreen/View/LoginScreen.swift`

**Changes**:
- Added members-only notice between header and login form: "Access is reserved for members of the Feralism community."
- Font: New York serif, 13pt, regular weight, 1pt tracking (matches landing page subtitle style)
- Color: `compound.textSecondary` (adapts to light/dark mode)
- Centered, with 24pt horizontal padding and 24pt bottom padding

---

## 6. App Icon

### AppIcon.png
**File**: `ElementX/Resources/AppIcon.icon/Assets/AppIcon.png`

- Resized from 800x800 to 1024x1024 to fill the full iOS icon canvas
- Prevents visible white border when iOS applies the rounded rectangle mask
- Format: 1024x1024 PNG, black background with white Feral logo (figure, moon, fire, water drop)

### App Logo (in-app)
**File**: `ElementX/Resources/Assets.xcassets/images/app-logo.imageset/app-logo.pdf`

- Vector PDF of the Feral logo used on authentication screens
- White on transparent — rendered with `.foregroundColor(.white)` on the landing page

---

## 7. CI/CD Configuration

### codemagic.yaml
- `XCODE_SCHEME` changed from "ElementX" to "Feral" in all workflow configurations

---

## 8. Server Configuration (from previous work)

### AppSettings.swift
- Locale-based server selection with `getFeralAccountProviders()` function
- All URLs updated from element.io to feralisme.fr domains
- Multiple Feral servers configured (feralisme.fr, feralism.net, etc.)

### AuthenticationService.swift
- `isAllowedFeralServer()` function validates only Feral servers
- Allowed servers: feralisme.fr, feralism.net, feralism.eu, feral.chat

---

## Files Changed (for re-applying after upstream merge)

### Critical files (must re-apply Feral customizations):
| File | What to re-apply |
|------|-----------------|
| `ElementX.xcodeproj/project.pbxproj` | APP_DISPLAY_NAME, PRODUCTION_APP_NAME, BASE_BUNDLE_IDENTIFIER, APP_GROUP_IDENTIFIER |
| `ElementX.xcodeproj/xcshareddata/xcschemes/` | Rename ElementX.xcscheme to Feral.xcscheme |
| `ElementX/Sources/Screens/Authentication/StartScreen/View/AuthenticationStartScreen.swift` | Full landing page redesign (typography, buttons, gradient, hidden version) |
| `ElementX/Sources/Screens/Authentication/StartScreen/View/AuthenticationStartLogo.swift` | Simplified logo (no glass container, 160x160pt white icon) |
| `ElementX/Sources/Screens/Authentication/LoginScreen/View/LoginScreen.swift` | Members-only notice text |
| `ElementX/Resources/AppIcon.icon/Assets/AppIcon.png` | Feral icon at 1024x1024 |
| `codemagic.yaml` | XCODE_SCHEME: "Feral" |

### Bulk replacements (can be scripted):
| Files | Replacement |
|-------|------------|
| `ElementX/Resources/Localizations/*/InfoPlist.strings` | "Element X" → "Feral" |
| `ElementX/Resources/Localizations/*/Localizable.strings` | "Element X" → "Feral" |
| `ElementX/Resources/Localizations/*/Localizable.strings` | QR subtitle → "Scan the QR code with your other device." |

---

## Re-apply Script (after upstream merge)

```bash
# 1. Replace "Element X" in all .strings files
find ElementX/Resources/Localizations -name "InfoPlist.strings" -exec sed -i '' 's/Element X/Feral/g' {} +
find ElementX/Resources/Localizations -name "Localizable.strings" -exec sed -i '' 's/Element X/Feral/g' {} +

# 2. Replace QR code subtitle
find ElementX/Resources/Localizations -name "Localizable.strings" -exec sed -i '' 's/"screen_qr_code_login_initial_state_subtitle" = ".*";/"screen_qr_code_login_initial_state_subtitle" = "Scan the QR code with your other device.";/g' {} +

# 3. Rename scheme (if overwritten)
mv ElementX.xcodeproj/xcshareddata/xcschemes/ElementX.xcscheme ElementX.xcodeproj/xcshareddata/xcschemes/Feral.xcscheme

# 4. Update project.pbxproj build settings (if overwritten)
# These need manual verification — check APP_DISPLAY_NAME, PRODUCTION_APP_NAME,
# BASE_BUNDLE_IDENTIFIER, APP_GROUP_IDENTIFIER in project.pbxproj

# 5. Rebuild
xcodebuild -project ElementX.xcodeproj -scheme Feral -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone 17 Pro' clean build
```

---

## Testing Checklist
- [ ] App launches with FERAL branding on dark landing page
- [ ] Logo displays as white icon, no glass container
- [ ] Buttons have frosted glass appearance
- [ ] Version text is hidden
- [ ] "FOR FERALISTS" subtitle visible below title
- [ ] Login page shows "Access is reserved for members of the Feralism community."
- [ ] QR code page shows "Scan the QR code with your other device."
- [ ] Other screens (after login page) follow system light/dark mode
- [ ] App icon shows correctly on home screen (no white border)
- [ ] Server selection shows Feral servers
- [ ] Cannot add custom non-Feral servers
