# Feral iOS Git Workflow

This document describes how to maintain the Feral fork while incorporating upstream Element X updates.

## Branch Structure

- `feral-main` - Stable Feral releases based on Element X stable releases
- `feral-develop` - Active Feral development with customizations
- `develop` - Tracks upstream Element X develop branch (DO NOT MODIFY)
- `main` - Tracks upstream Element X main branch (DO NOT MODIFY)

## Initial Setup (Already Done)

```bash
# Add upstream remote
git remote add upstream https://github.com/element-hq/element-x-ios.git

# Fetch upstream
git fetch upstream --tags
```

## Creating Feral Branches

```bash
# Create feral-develop from current state
git checkout -b feral-develop

# Create feral-main for stable releases
git checkout -b feral-main
git push origin feral-main
git push origin feral-develop
```

## Feral Customizations

All Feral-specific changes should be made in separate, well-documented commits:

1. **App Branding**
   - Update app name to "Feral"
   - Change bundle identifier
   - Update icons and assets

2. **Configuration**
   - Codemagic CI/CD setup
   - Custom server configurations
   - Feature flags

3. **Custom Features**
   - Any Feral-specific functionality

## Updating from Upstream

### 1. Update tracking branches
```bash
# Update upstream tracking
git fetch upstream

# Update local tracking branches
git checkout develop
git merge upstream/develop --ff-only

git checkout main  
git merge upstream/main --ff-only
```

### 2. Merge upstream changes into Feral
```bash
# Merge latest stable into feral-main
git checkout feral-main
git merge upstream/main --no-ff -m "Merge Element X stable release"

# Or merge develop changes into feral-develop
git checkout feral-develop
git merge upstream/develop --no-ff -m "Merge Element X develop updates"
```

### 3. Resolve conflicts
When conflicts occur, prioritize Feral customizations:
- Keep Feral branding (app name, bundle ID)
- Keep Feral-specific features
- Accept upstream bug fixes and improvements

### 4. Test thoroughly
After merging:
1. Run all tests
2. Build the app
3. Test Feral-specific features
4. Verify branding is intact

## Release Process

1. When Element X releases a new stable version:
   ```bash
   git checkout feral-main
   git merge upstream/main --no-ff
   # Resolve conflicts, test
   git tag feral-v1.0.0
   git push origin feral-main --tags
   ```

2. Regular development:
   ```bash
   git checkout feral-develop
   # Make changes
   git commit -m "feat: Add Feral-specific feature"
   git push origin feral-develop
   ```

## Best Practices

1. **Keep customizations isolated**
   - Use clear commit messages prefixed with `feral:`
   - Document why each change was made
   - Keep changes minimal and targeted

2. **Regular syncing**
   - Sync with upstream weekly during active development
   - Always sync before starting new features

3. **Conflict resolution**
   - Document conflict resolutions in commit messages
   - Create scripts to automate common conflicts (e.g., app name)

4. **Testing**
   - Maintain Feral-specific tests
   - Run full test suite after each merge

## Emergency Rollback

If an upstream merge breaks Feral:
```bash
git checkout feral-develop
git reset --hard HEAD~1  # Undo the merge
git push origin feral-develop --force-with-lease
```

## Automation Ideas

Consider creating scripts for:
- Automated branding updates after merge
- Conflict resolution for known patterns
- CI/CD integration for merge validation