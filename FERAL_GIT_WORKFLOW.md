# Feral iOS — Git Workflow & Upstream Sync Guide

This document describes how to maintain the Feral iOS fork while incorporating upstream Element X updates.

## Repository Setup

```bash
# Clone the fork
git clone https://github.com/jeheja/feral-ios.git
cd feral-ios

# Add upstream remote (Element X iOS)
git remote add upstream https://github.com/element-hq/element-x-ios.git

# Verify remotes
git remote -v
# origin    https://github.com/jeheja/feral-ios.git (fetch/push)
# upstream  https://github.com/element-hq/element-x-ios.git (fetch/push)
```

## Branch Structure

- `feral-develop` — Active Feral development with customizations (main working branch)
- `feral-main` — Stable Feral releases
- `develop` — Tracks upstream Element X develop branch (DO NOT MODIFY)
- `main` — Tracks upstream Element X main branch (DO NOT MODIFY)

## Syncing with Upstream

We use **merge** (not rebase) to incorporate upstream changes. This preserves our custom commits as distinct history.

### Step-by-step update process

```bash
# 1. Make sure you're on feral-develop
git checkout feral-develop

# 2. Fetch latest upstream
git fetch upstream

# 3. Merge upstream develop into feral-develop
git merge upstream/develop

# 4. Resolve any conflicts (see Conflict Resolution below)

# 5. Push
git push origin feral-develop
```

### For stable releases

```bash
git checkout feral-main
git merge upstream/main --no-ff -m "Merge Element X stable release"
# Resolve conflicts, test
git tag feral-v1.x.x
git push origin feral-main --tags
```

## Conflict Resolution Strategy

When conflicts occur, follow these rules:

| File type | Resolution |
|-----------|-----------|
| **Feral-branded files** (custom SwiftUI views, Feral assets) | **Always keep ours** — these are 100% custom |
| **OnboardingScreen / WelcomeScreen** | Keep Feral UI (dark gradient, frosted glass, "FERAL" title). Accept new upstream features and integrate with Feral styling |
| **Login views** | Keep members-only notice. Accept upstream form/API changes |
| **Localizable.strings** (all `.lproj/`) | Keep Feral translations for welcome/title/subtitle. Accept new upstream strings |
| **Config / plist files** | Keep Feral app name, bundle ID, server config |
| **Everything else** | **Take upstream** — bug fixes, new features, dependency updates |

## What's Customized

### 1. Onboarding Screen (matches Android exactly)
- **Dark gradient background** — near-black gradient
- **White Feral logo** — no container, tinted white
- **"FERAL" title** — large, letter-spaced, white
- **"FOR FERALISTS" subtitle** — smaller, faded white
- **Frosted glass buttons** — semi-transparent white with thin border

### 2. Login Screen
- **Members-only notice** — "Access is reserved for members of the Feralism community."

### 3. App Identity
- App name: "Feral"
- Bundle ID: Feral-specific
- Default homeserver: `feralisme.fr`
- External signup: `https://feralisme.fr/inscription/`

### 4. Localization
- 38 languages updated with Feral branding
- Welcome title/subtitle in all languages

## Best Practices

1. **Keep customizations isolated** — use clear commit messages prefixed with `feral:`
2. **Regular syncing** — sync with upstream at least monthly
3. **Document conflict resolutions** — note what was kept/changed in merge commit messages
4. **Test after every merge**:
   - [ ] Onboarding screen shows dark gradient + white logo
   - [ ] "FERAL" title and "FOR FERALISTS" subtitle visible
   - [ ] Frosted glass buttons render correctly
   - [ ] Login shows members-only notice
   - [ ] App name shows "Feral" throughout
   - [ ] No Element branding visible
   - [ ] Sign-in flow completes successfully

## Emergency Rollback

If an upstream merge breaks Feral:
```bash
git checkout feral-develop
git reset --hard HEAD~1  # Undo the merge
git push origin feral-develop --force-with-lease
```

## Notes

- iOS and Android should always match visually — check `feral-android` repo for reference
- All customizations are direct commits (no patch system)
- The comprehensive rebranding was done in the `claude/determined-banzai` branch, merged into `feral-develop`
- Codemagic CI/CD may be set up for automated builds
