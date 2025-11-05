# Git Worktree Management - Quick Reference

## 🚀 Basic Commands

### Create Worktree
```bash
gwc <branch-name>                    # Create worktree
gwcc <branch-name>                   # Create and open in Cursor
gwc <branch> --path /custom/path     # Create at custom location
gwc <branch> --open code             # Create and open in VS Code
```

### Examples
```bash
gwc feature/new-api                  # Create worktree for feature branch
gwcc hotfix/Rasmee                   # Create and open in Cursor
```

## 📋 List & Info Commands

### List Worktrees
```bash
gwc-list                            # Simple list (alias: gwc-ls)
gwc-info                            # Detailed info with status
gwc-branches                        # Show only branches with worktrees
```

### Example Output
```bash
gwc-info
# Shows: path, branch, git status, commits ahead/behind
```

## 🔄 Navigation Commands

### Change Directory
```bash
gwc-cd <branch-name>                # Navigate to worktree
```

### Example
```bash
gwc-cd hotfix/Rasmee                # Go to hotfix/Rasmee worktree
```

## 📂 Open Commands

### Open in Editor
```bash
gwc-open <branch-name>              # Open in Cursor (default)
gwc-open <branch-name> code         # Open in VS Code
gwc-open <branch-name> vim          # Open in Vim
```

## 🗑️ Remove Commands

### Remove Worktree
```bash
gwc-rm <path>                       # Remove by path (git native)
gwc-remove <path>                   # Same as above
gwc-rm-branch <branch-name>         # Remove by branch name
```

### Examples
```bash
gwc-rm-branch hotfix/Rasmee         # Remove worktree by branch name
```

## 🧹 Maintenance Commands

### Cleanup & Health
```bash
gwc-cleanup                         # Clean up broken worktrees
gwc-health                          # Check health of all worktrees
```

### Example Output
```bash
gwc-health
# Checks: directory exists, valid git repo, uncommitted changes
```

## 📝 Tab Completion

All commands support tab completion:

```bash
gwc <TAB>                           # Shows all available branches
gwcc hot<TAB>                       # Filters to hotfix branches
gwc-cd <TAB>                        # Shows only existing worktree branches
gwc-open <TAB>                      # Shows only existing worktree branches
gwc-rm-branch <TAB>                 # Shows only existing worktree branches
gwc-rm <TAB>                        # Shows worktree paths
```

## 🎯 Complete Command Reference

| Command | Description | Tab Completion |
|---------|-------------|----------------|
| `gwc` | Create worktree | All branches |
| `gwcc` | Create + open in Cursor | All branches |
| `gwc-list` / `gwc-ls` | List all worktrees | N/A |
| `gwc-info` | Detailed worktree info | N/A |
| `gwc-branches` | List branches with worktrees | N/A |
| `gwc-cd` | Navigate to worktree | Existing worktrees |
| `gwc-open` | Open worktree in editor | Existing worktrees |
| `gwc-rm` | Remove by path | Worktree paths |
| `gwc-rm-branch` | Remove by branch name | Existing worktrees |
| `gwc-cleanup` | Clean broken worktrees | N/A |
| `gwc-health` | Health check | N/A |
| `gwc-detect-unlinked` | Find unlinked directories | N/A |
| `gwc-link` / `gwc-link-interactive` | Interactive: select dir + branch | N/A |

## 💡 Common Workflows

### 1. Start work on a feature
```bash
gwcc feature/new-api
# Creates worktree and opens in Cursor
```

### 2. Switch between features
```bash
gwc-cd feature/new-api
# Navigate to the worktree
```

### 3. Check all worktrees status
```bash
gwc-info
# See status, uncommitted changes, sync status
```

### 4. Cleanup after done
```bash
gwc-rm-branch feature/new-api
# Remove worktree by branch name
```

### 5. Maintenance
```bash
gwc-health                          # Check for issues
gwc-cleanup                         # Clean up broken worktrees
```

## 🔧 Advanced Features

### Custom Paths
```bash
gwc my-branch --path ~/projects/custom-location
```

### Multiple Editors
```bash
gwc-open my-branch cursor           # Cursor
gwc-open my-branch code             # VS Code
gwc-open my-branch vim              # Vim
```

### Health Monitoring
```bash
gwc-health
# Shows:
# - Missing directories
# - Invalid git repos
# - Uncommitted changes
# - Sync status with remote
```

## 📍 Default Worktree Location

Worktrees are created at:
```
~/.cursor/worktrees/<repo-name>/<branch-name>
```

Example:
```
~/.cursor/worktrees/WFM-Modules/hotfix/Rasmee
```

## 🔧 Fixing Cursor Auto-Created Worktrees

**Problem:** When you select "Run with worktree" in Cursor without creating the worktree first, Cursor creates a directory that isn't linked to a git branch.

**Solution:** Use these new commands:

### Quick Fix Method

**Interactive Selection (Recommended)**
```bash
cd /path/to/main/repo
gwc-link                   # Select directory from list, then pick branch
```

### Check What Needs Fixing
```bash
cd /path/to/main/repo
gwc-detect-unlinked        # Scan for unlinked directories
```

### Prevention (Always Do This First!)
```bash
gwcc feature/new-branch    # Creates proper worktree AND opens in Cursor
```

## 🆘 Troubleshooting

### Worktree not found
```bash
gwc-list                            # Check existing worktrees
gwc-branches                        # See which branches have worktrees
```

### Broken worktrees
```bash
gwc-health                          # Identify issues
gwc-cleanup                         # Fix broken worktrees
```

### Tab completion not working
```bash
source ~/.zshrc                     # Reload configuration
```

## 📚 Examples

### Full Workflow Example
```bash
# 1. Create worktree for hotfix
gwcc hotfix/Rasmee

# 2. Work on it... (in Cursor)

# 3. Switch to another branch
gwc-cd feature/new-api

# 4. Come back later
gwc-open hotfix/Rasmee

# 5. Check status of all work
gwc-info

# 6. Done with hotfix, remove it
gwc-rm-branch hotfix/Rasmee

# 7. Cleanup
gwc-cleanup
```

### Multiple Worktrees
```bash
# Create multiple worktrees for different tasks
gwcc feature/api
gwcc feature/ui
gwcc hotfix/bug-123

# See all at once
gwc-info

# Jump between them
gwc-cd feature/api
gwc-cd feature/ui
gwc-cd hotfix/bug-123
```

## 🎨 Output Features

All commands include:
- ✓ Success indicators
- ❌ Error messages
- 📍 Path information
- 🌿 Branch information
- 📝 Status details
- 🔄 Sync information
- ⚠️ Warnings
- 🧹 Cleanup actions

---

## 📦 Installation

Add to your `~/.zshrc`:
```bash
source ~/.zsh/git-worktree/functions.zsh
```

Then reload:
```bash
source ~/.zshrc
```

For built-in help, run: `gwc-help`

