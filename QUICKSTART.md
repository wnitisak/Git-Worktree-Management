# Git Worktree Manager (GWC) - Quick Start Guide

## 🚀 Installation

Add this to your `~/.zshrc`:
```bash
source ~/.zsh/git-worktree/functions.zsh
```

Then reload:
```bash
source ~/.zshrc
```

## 📖 Getting Help

View the full help anytime:
```bash
gwc-help
```

For paginated help:
```bash
gwc-help | less
```

## 🎯 Most Common Commands

### Create a new worktree
```bash
gwc feature/new-feature
```

### Create and open in Cursor
```bash
gwcc feature/new-feature
```

### List all worktrees
```bash
gwc-list
# or
gwc-ls
```

### Show detailed info about all worktrees
```bash
gwc-info
```

### Navigate to a worktree
```bash
gwc-cd feature/new-feature
```

### Remove a worktree by branch name
```bash
gwc-rm-branch feature/old-feature
```

### Open existing worktree in editor
```bash
gwc-open feature/api cursor    # Open in Cursor
gwc-open feature/api code      # Open in VS Code
```

### Check worktree health
```bash
gwc-health
```

## 💡 Quick Examples

### Start working on a new feature:
```bash
# Create worktree and open in Cursor
gwcc feature/user-profile

# Navigate to it
gwc-cd feature/user-profile

# When done, remove it
gwc-rm-branch feature/user-profile
```

### Quick bug fix:
```bash
# Create worktree with custom path
gwc hotfix/critical-bug /tmp/bugfix --cursor

# Work on it...

# Return to main worktree
gwc-cd main

# Clean up
gwc-rm-branch hotfix/critical-bug
```

### Review all worktrees:
```bash
# See status of all
gwc-info

# Check for issues
gwc-health

# Clean up stale references
gwc-cleanup
```

## 📋 All Available Commands

| Command | Description |
|---------|-------------|
| `gwc <branch> [path]` | Create worktree from branch |
| `gwcc <branch> [path]` | Create worktree and open in Cursor |
| `gwc-list` / `gwc-ls` | List all worktrees |
| `gwc-info` | Show detailed worktree information |
| `gwc-branches` | List branches with worktrees |
| `gwc-cd <branch>` | Navigate to worktree |
| `gwc-open <branch> [editor]` | Open worktree in editor |
| `gwc-remove <path>` / `gwc-rm` | Remove worktree by path |
| `gwc-rm-branch <branch>` | Remove worktree by branch |
| `gwc-cleanup` | Prune stale worktree references |
| `gwc-health` | Check worktree health |
| `gwc-detect-unlinked` | Find Cursor auto-created directories |
| `gwc-link` | Interactive: select directory & branch |
| `gwc-help` | Show full help documentation |

## ⌨️ Tab Completion

All commands support tab completion:
- Branch names autocomplete from your git branches
- Worktree paths autocomplete from existing worktrees
- Editor names autocomplete for the `gwc-open` command

Try it:
```bash
gwc <TAB>              # Shows available branches
gwc-cd <TAB>           # Shows worktree branches
gwc-rm-branch <TAB>    # Shows worktree branches
gwc-open feature/api <TAB>  # Shows available editors
```

## 🎓 Pro Tips

1. **Use `gwcc` for quick context switching** - It creates and opens in one command
2. **Use `gwc-cd` instead of manual navigation** - Let it find the path for you
3. **Run `gwc-info` regularly** - Stay aware of your worktree status
4. **Use `gwc-health` before cleanup** - Avoid losing uncommitted work
5. **Use `gwc-cleanup` after manual deletions** - Keep git references clean
6. **Fix Cursor auto-created directories** - Run `gwc-detect-unlinked` to find and fix issues

## 🔧 Fixing Cursor Auto-Created Worktrees

If you selected "Run with worktree" in Cursor before creating it:

```bash
# Interactive fix - select directory and branch
cd /path/to/main/repo
gwc-link               # Shows list of dirs, then available branches

# Check what needs fixing
gwc-detect-unlinked    # Scan for unlinked directories
```

**Prevention:** Always use `gwcc branch-name` first!

## 📚 More Information

- Full help: `gwc-help`
- Source code: `~/.zsh/git-worktree/functions.zsh`
- Git worktree docs: https://git-scm.com/docs/git-worktree

---

**Need more details?** Run `gwc-help` for comprehensive documentation!

