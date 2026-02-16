# Feral iOS Icon & Assets Guide

## Current Icon Setup

### App Icon (Home Screen)
- **File**: `ElementX/Resources/AppIcon.icon/Assets/AppIcon.png`
- **Format**: 1024x1024 PNG
- **Current**: Black background, white Feral logo (figure, moon, fire, water drop)
- **Config**: `ElementX/Resources/AppIcon.icon/icon.json` — single background layer
- iOS automatically applies the rounded rectangle mask

### In-App Logo (Landing Page)
- **File**: `ElementX/Resources/Assets.xcassets/images/app-logo.imageset/app-logo.pdf`
- **Format**: Vector PDF, white on transparent
- **Used in**: `AuthenticationStartLogo.swift` — rendered at 160x160pt with `.foregroundColor(.white)`
- The landing page has a dark gradient background, so the white logo is always visible

## To Replace Icons

### App Icon
```bash
# Replace with a 1024x1024 PNG — must fill the entire canvas edge-to-edge
cp /path/to/new-icon.png ElementX/Resources/AppIcon.icon/Assets/AppIcon.png
```
- Must be exactly 1024x1024
- Background should extend to all edges (iOS crops to rounded rect)
- No transparency — use solid background color

### In-App Logo
```bash
# Replace with a vector PDF — white artwork on transparent background
cp /path/to/new-logo.pdf ElementX/Resources/Assets.xcassets/images/app-logo.imageset/app-logo.pdf
```
- Should be white on transparent (rendered with foregroundColor in code)
- Vector PDF for crisp rendering at all sizes

### After Replacing
1. Clean build folder: **Shift+Cmd+K** in Xcode
2. Delete app from simulator
3. Rebuild: **Cmd+R**
