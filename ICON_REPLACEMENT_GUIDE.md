# Feral iOS Icon Replacement Guide

This guide documents the steps needed to replace the Element icons with Feral branding.

## Required Icon Files

### 1. App Icon
- **Location**: `ElementX/Resources/Assets.xcassets/AppIcon.appiconset/AppIcon.png`
- **Format**: PNG
- **Size**: 1024x1024 pixels
- **Description**: The main app icon shown on the home screen

### 2. App Logo
- **Location**: `ElementX/Resources/Assets.xcassets/images/app-logo.imageset/app-logo.pdf`
- **Format**: PDF (vector)
- **Description**: The logo shown in the app during authentication and other screens

### 3. Server Selection Icon (Optional)
- **Location**: `ElementX/Resources/Assets.xcassets/images/authentication/server-selection-icon.imageset/`
- **Description**: Icon shown during server selection

## Replacement Steps

1. **Prepare Feral Icons**:
   - Create a 1024x1024 PNG of the Feral logo for the app icon
   - Export the Feral logo as a vector PDF for the in-app logo
   - Use the Feral logo from `/home/eheyu/Documents/feralism-copie/logo/` as the source

2. **Replace App Icon**:
   ```bash
   cp /path/to/feral-icon-1024x1024.png ElementX/Resources/Assets.xcassets/AppIcon.appiconset/AppIcon.png
   ```

3. **Replace App Logo**:
   ```bash
   cp /path/to/feral-logo.pdf ElementX/Resources/Assets.xcassets/images/app-logo.imageset/app-logo.pdf
   ```

4. **Clean and Rebuild**:
   - Clean the build folder in Xcode (Shift+Cmd+K)
   - Delete derived data if necessary
   - Rebuild the project

## Icon Design Guidelines

Based on the Feral Android branding:
- Primary colors: Golden (#D4AF37) and Deep Forest (#0F2C1E)
- The icon should work well on both light and dark backgrounds
- Consider using the golden color for the icon with transparent background
- Ensure the icon is recognizable at small sizes

## Notes

- The iOS app uses a single 1024x1024 icon that is automatically scaled down for different uses
- The PDF format for the in-app logo ensures crisp rendering at all sizes
- Make sure to test the icons in both light and dark mode