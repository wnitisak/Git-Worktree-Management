# Git Worktree Manager - Recent Changes

## Version 2.0 - Local Worktree Location

**Date:** December 9, 2025

### 🎯 Main Change

**Worktree location changed from `~/.cursor/worktrees/<repo>/<branch>` to `<main-repo>/.worktrees/<branch>`**

### ✅ Benefits

1. **Better IDE Integration** - IDEs can now properly track git changes because the `.git` file reference is local to the repository
2. **Simpler Structure** - Worktrees are organized within their parent repository
3. **Easier Discovery** - All worktrees are visible in the main repo directory
4. **Cleaner Codebase** - Removed 359 lines of Cursor-specific detection code

### 🔧 Changes Made

#### 1. Updated Functions
- `git-worktree-create()` - Now creates worktrees in `<main-repo>/.worktrees/<branch>`
- `gwc-cd()` - Updated path calculation for new location
- `gwc-rm-branch()` - Updated path calculation for new location
- `gwc-open()` - Updated path calculation for new location

#### 2. Removed Functions
- `gwc-detect-unlinked()` - No longer needed
- `gwc-link-interactive()` - No longer needed
- `gwc-link` alias - Removed

#### 3. Updated Documentation
- Help text updated with new location information
- Added `.gitignore` recommendation section
- Updated workflow examples
- Removed Cursor-specific feature documentation

### 📝 Important: Update Your .gitignore

**You MUST add the following to your repository's `.gitignore` file:**

```bash
echo ".worktrees/" >> .gitignore
```

This prevents worktree directories from being tracked in git.

### 🔄 Migration Guide

If you have existing worktrees in `~/.cursor/worktrees/`, you have two options:

#### Option 1: Remove old worktrees and recreate them
```bash
# List current worktrees
gwc-list

# Remove each old worktree
gwc-rm-branch <branch-name>

# Recreate in new location
gwcc <branch-name>
```

#### Option 2: Manual migration (advanced)
```bash
# In your main repo
cd /path/to/your/repo

# Create .worktrees directory
mkdir -p .worktrees

# Move each worktree
mv ~/.cursor/worktrees/<repo-name>/<branch-name> .worktrees/<branch-name>

# Update git worktree references
git worktree prune
git worktree repair .worktrees/<branch-name>
```

### 🚀 Usage After Update

```bash
# Reload the functions
source ~/.zsh/git-worktree/functions.zsh

# Or restart your shell
exec zsh

# Create a new worktree (now in .worktrees/)
gwcc feature/new-feature

# Navigate to it
gwc-cd feature/new-feature

# Your IDE will now properly track git changes!
```

### ✨ Tab Completion Still Works

- `gwcc <tab>` - Suggests all local and remote branches
- `gwc-remove <tab>` - Suggests existing worktree paths
- `gwc-cd <tab>` - Suggests branches with worktrees
- `gwc-open <tab>` - Suggests branches with worktrees

All completion functions remain unchanged and continue to work perfectly.

### 🐛 Fixed Issues

1. ✅ IDE can now track git changes in worktrees
2. ✅ Git change logs now display properly
3. ✅ Tab completion for branch suggestions works
4. ✅ Tab completion for `gwc-remove` works

### 📚 Documentation

- See `gwc-help` for complete command reference
- See `QUICKSTART.md` for getting started guide
- See `README.md` for detailed documentation

