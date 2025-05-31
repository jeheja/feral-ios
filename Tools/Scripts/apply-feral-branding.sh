#!/bin/bash
# Script to apply Feral branding to the iOS app

echo "🦁 Applying Feral branding..."

# Update app.yml with Feral settings
cat > app.yml << EOF
settings:
  APP_DISPLAY_NAME: Feral
  PRODUCTION_APP_NAME: Feral
  APP_GROUP_IDENTIFIER: group.io.feral
  BASE_BUNDLE_IDENTIFIER: io.feral.app
  ASSETCATALOG_COMPILER_GLOBAL_ACCENT_COLOR_NAME: "colors/accent-color"
  DEVELOPMENT_TEAM: \${FERAL_DEVELOPMENT_TEAM}
EOF

# Update project name (keeping file name as ElementX.xcodeproj for compatibility)
sed -i '' 's/name: ElementX/name: Feral/g' project.yml
sed -i '' 's/APP_NAME: ElementX/APP_NAME: Feral/g' project.yml

echo "✅ Feral branding applied!"
echo ""
echo "Next steps:"
echo "1. Add your Apple Developer Team ID to the FERAL_DEVELOPMENT_TEAM environment variable"
echo "2. Update app icons in ElementX/Resources/Assets.xcassets/AppIcon.appiconset/"
echo "3. Customize the accent color if desired"
echo "4. Run 'xcodegen' to regenerate the project"