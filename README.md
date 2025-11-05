# Git Worktree Management for Cursor

A comprehensive ZSH tool for managing Git worktrees, specifically designed to work seamlessly with Cursor editor and fix common worktree issues.

## 📋 Table of Contents

- [Features](#-features)
- [Installation](#-installation)
- [Quick Start](#-quick-start)
- [Commands Reference](#-commands-reference)
- [Workflows & Examples](#-workflows--examples)
- [Flowcharts](#-flowcharts)
- [Troubleshooting](#-troubleshooting)
- [Contributing](#-contributing)

## ✨ Features

- **Create & Manage Worktrees** - Easy creation with automatic path management
- **Cursor Integration** - Open worktrees directly in Cursor editor
- **Interactive Fix Tool** - Fix Cursor auto-created directories that aren't linked to git
- **Smart Navigation** - Jump between worktrees by branch name
- **Health Monitoring** - Check status and sync of all worktrees
- **Tab Completion** - Intelligent completion for all commands
- **Automatic Backups** - Safe operations with automatic content preservation

## 🚀 Installation

### Prerequisites

- ZSH shell
- Git 2.5+ (with worktree support)
- Cursor editor (optional, for `gwcc` command)

### Install Steps

1. **Clone this repository:**

```bash
git clone https://github.com/wnitisak/Git-Worktree-Management.git ~/.zsh/git-worktree
```

2. **Add to your `~/.zshrc`:**

```bash
# Add this line to ~/.zshrc
source ~/.zsh/git-worktree/functions.zsh
```

3. **Reload your shell:**

```bash
source ~/.zshrc
```

4. **Verify installation:**

```bash
gwc-help
```

## 🎯 Quick Start

### Create Your First Worktree

```bash
# Method 1: Create only
gwc feature/my-feature

# Method 2: Create and open in Cursor (recommended!)
gwcc feature/my-feature
```

### Navigate Between Worktrees

```bash
# List all worktrees
gwc-list

# Jump to a worktree
gwc-cd feature/my-feature

# Open in editor
gwc-open feature/my-feature
```

### Remove Worktree When Done

```bash
gwc-rm-branch feature/my-feature
```

## 📚 Commands Reference

### Create & Open

| Command | Description | Example |
|---------|-------------|---------|
| `gwc <branch>` | Create worktree | `gwc feature/api` |
| `gwcc <branch>` | Create & open in Cursor | `gwcc hotfix/bug` |
| `gwc <branch> --path <path>` | Custom location | `gwc develop --path ~/projects/dev` |
| `gwc <branch> --open <editor>` | Open in specific editor | `gwc main --open code` |

### List & Info

| Command | Description |
|---------|-------------|
| `gwc-list` or `gwc-ls` | Simple list of worktrees |
| `gwc-info` | Detailed info (status, sync, changes) |
| `gwc-branches` | List only branch names |

### Navigate & Open

| Command | Description | Example |
|---------|-------------|---------|
| `gwc-cd <branch>` | Navigate to worktree | `gwc-cd feature/ui` |
| `gwc-open <branch> [editor]` | Open in editor | `gwc-open main cursor` |

### Remove

| Command | Description | Example |
|---------|-------------|---------|
| `gwc-rm-branch <branch>` | Remove by branch name | `gwc-rm-branch old-feature` |
| `gwc-rm <path>` | Remove by path | `gwc-rm /path/to/worktree` |

### Maintenance

| Command | Description |
|---------|-------------|
| `gwc-health` | Check health of all worktrees |
| `gwc-cleanup` | Prune stale references |

### Fix Cursor Issues

| Command | Description |
|---------|-------------|
| `gwc-detect-unlinked` | Scan for unlinked directories |
| `gwc-link` | Interactive fix (select dir + branch) |

### Help

| Command | Description |
|---------|-------------|
| `gwc-help` | Show built-in documentation |

## 🔄 Workflows & Examples

### Workflow 1: Feature Development

```bash
# 1. Start new feature
gwcc feature/user-authentication

# 2. Work on it... (Cursor opens automatically)

# 3. Check status anytime
gwc-info

# 4. Done? Remove it
gwc-rm-branch feature/user-authentication
```

### Workflow 2: Multiple Features

```bash
# Create multiple worktrees
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

### Workflow 3: Fix Cursor Auto-Created Directories

**Problem:** Cursor created a directory but didn't link it to git branch.

**Solution:**

```bash
# 1. Go to your main repo
cd /path/to/your/repo

# 2. Scan for issues
gwc-detect-unlinked

# 3. Fix interactively
gwc-link
# → Select directory from list
# → See all branches
# → Pick the right one
# → Done!
```

## 📊 Flowcharts

### Main Workflow

```
┌─────────────────────────────────────────────┐
│  Start: Need to work on different branch    │
└─────────────────────────────────────────────┘
                    │
                    ▼
        ┌───────────────────────┐
        │  Create Worktree      │
        │  gwcc feature/branch  │
        └───────────────────────┘
                    │
                    ▼
        ┌───────────────────────┐
        │  Cursor Opens         │
        │  Auto-navigates       │
        └───────────────────────┘
                    │
                    ▼
        ┌───────────────────────┐
        │  Work on Code         │
        │  Commit changes       │
        └───────────────────────┘
                    │
                    ▼
        ┌───────────────────────┐
        │  Feature Complete?    │
        └───────────────────────┘
                    │
            Yes ────┼──── No (continue working)
                    │
                    ▼
        ┌───────────────────────┐
        │  Remove Worktree      │
        │  gwc-rm-branch        │
        └───────────────────────┘
                    │
                    ▼
        ┌───────────────────────┐
        │  Done! ✓              │
        └───────────────────────┘
```

### Cursor Fix Workflow

```
┌─────────────────────────────────────────────┐
│  Problem: Cursor created unlinked directory │
└─────────────────────────────────────────────┘
                    │
                    ▼
        ┌───────────────────────┐
        │  cd main-repo         │
        │  gwc-detect-unlinked  │
        └───────────────────────┘
                    │
                    ▼
        ┌───────────────────────────────────┐
        │  Shows unlinked directories:      │
        │  [1] temp-work                    │
        │  [2] quick-fix                    │
        │  [3] testing                      │
        └───────────────────────────────────┘
                    │
                    ▼
        ┌───────────────────────┐
        │  Run: gwc-link        │
        └───────────────────────┘
                    │
                    ▼
        ┌───────────────────────────────────┐
        │  Select directory: 1              │
        └───────────────────────────────────┘
                    │
                    ▼
        ┌───────────────────────────────────┐
        │  Shows all branches:              │
        │  • main                           │
        │  • develop                        │
        │  • feature/api                    │
        │  • feature/ui                     │
        │  • hotfix/bug                     │
        └───────────────────────────────────┘
                    │
                    ▼
        ┌───────────────────────┐
        │  Enter: feature/api   │
        └───────────────────────┘
                    │
                    ▼
        ┌───────────────────────────────────┐
        │  ✓ Backup content                 │
        │  ✓ Create git worktree            │
        │  ✓ Link to branch                 │
        │  ✓ Restore content                │
        └───────────────────────────────────┘
                    │
                    ▼
        ┌───────────────────────┐
        │  Fixed! ✓             │
        └───────────────────────┘
```

### Navigation Flow

```
┌─────────────────────────────────────────────┐
│  Need to switch between worktrees?          │
└─────────────────────────────────────────────┘
                    │
        ┌───────────┴───────────┐
        │                       │
        ▼                       ▼
┌──────────────┐        ┌──────────────┐
│  Know the    │        │  Not sure    │
│  branch?     │        │  which one?  │
└──────────────┘        └──────────────┘
        │                       │
        ▼                       ▼
┌──────────────┐        ┌──────────────┐
│  gwc-cd      │        │  gwc-list    │
│  feature/api │        │  (see all)   │
└──────────────┘        └──────────────┘
        │                       │
        │                       ▼
        │               ┌──────────────┐
        │               │  gwc-cd      │
        │               │  <branch>    │
        │               └──────────────┘
        │                       │
        └───────────┬───────────┘
                    │
                    ▼
        ┌───────────────────────┐
        │  Now in worktree ✓    │
        └───────────────────────┘
```

### Decision Tree

```
Which command should I use?

    Want to start working on a branch?
    │
    ├─ Branch exists? ─ Yes → gwcc <branch>
    │                         (Creates + opens in Cursor)
    │
    └─ Branch not created yet → Create branch first
                                then: gwcc <branch>

    Need to switch between branches?
    │
    └─ Use: gwc-cd <branch>
            (Tab completion available!)

    Have unlinked Cursor directories?
    │
    ├─ Check first → gwc-detect-unlinked
    │
    └─ Fix them → gwc-link
                  (Interactive selection)

    Want to see all worktrees?
    │
    ├─ Simple list → gwc-list
    │
    └─ Detailed info → gwc-info
                       (shows status, changes, sync)

    Done with a worktree?
    │
    └─ Remove it → gwc-rm-branch <branch>
                   (Safe removal)

    Something broken?
    │
    ├─ Check health → gwc-health
    │
    └─ Clean up → gwc-cleanup
```

## 🔧 Advanced Configuration

### Custom Worktree Location

By default, worktrees are created at:
```
~/.cursor/worktrees/<repo-name>/<branch-name>
```

To use custom location:
```bash
gwc my-branch --path ~/my-custom-location
```

### Configure Search Paths for Main Repo

Edit `functions.zsh` to add your custom paths:

```zsh
# Around line 858-865
local -a search_paths=(
    "$HOME/projects/$repo_name"
    "$HOME/git/$repo_name"
    "$HOME/your-custom-path/$repo_name"  # Add your path here
    "$HOME/$repo_name"
    "$HOME/Documents/$repo_name"
    "$HOME/code/$repo_name"
    "$HOME/workspace/$repo_name"
)
```

## 🎨 Tab Completion

All commands support intelligent tab completion:

```bash
gwc <TAB>              # Shows all available branches
gwcc hot<TAB>          # Filters to branches starting with "hot"
gwc-cd <TAB>           # Shows only existing worktree branches
gwc-open <TAB>         # Shows existing worktree branches
gwc-rm-branch <TAB>    # Shows existing worktree branches
```

## 🆘 Troubleshooting

### Issue: "Branch doesn't exist"

**Solution:** Make sure the branch exists locally or remotely:
```bash
git branch -a  # Check all branches
```

### Issue: "Can't find main repository"

**Solution:** The tool searches common locations. Either:
1. Add your path to `search_paths` in `functions.zsh`
2. Or specify manually: `gwc <branch> --path /full/path`

### Issue: Tab completion not working

**Solution:** Reload your shell:
```bash
source ~/.zshrc
```

### Issue: Worktree directory exists but not linked

**Solution:** Use the fix tool:
```bash
cd /path/to/main/repo
gwc-link
```

### Issue: "Permission denied"

**Solution:** Check ownership of the worktrees directory:
```bash
ls -la ~/.cursor/worktrees
# If needed:
sudo chown -R $(whoami) ~/.cursor/worktrees
```

## 📖 Documentation Files

- **[functions.zsh](functions.zsh)** - Main implementation
- **[README.md](README.md)** - Complete command reference  
- **[QUICKSTART.md](QUICKSTART.md)** - Quick start guide

## 🤝 Contributing

Contributions are welcome! Please feel free to submit issues or pull requests.

### Development

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Testing

Before submitting:
```bash
# Check syntax
zsh -n functions.zsh

# Test in a new shell
zsh
source functions.zsh
gwc-help
```

## 📝 License

This project is open source and available under the MIT License.

## 👤 Author

**wnitisak**

- GitHub: [@wnitisak](https://github.com/wnitisak)
- Repository: [Git-Worktree-Management](https://github.com/wnitisak/Git-Worktree-Management.git)

## 🙏 Acknowledgments

- Git worktree feature: [Git Documentation](https://git-scm.com/docs/git-worktree)
- Cursor editor: [Cursor](https://cursor.sh)
- ZSH completion system

## 📊 Project Stats

- **Language:** Shell (ZSH)
- **Lines of Code:** ~1,000
- **Commands:** 15+ 
- **Documentation:** Complete with flowcharts
- **Status:** Production Ready ✓

---

**⭐ Star this repo if you find it useful!**

**🐛 Found a bug?** [Open an issue](https://github.com/wnitisak/Git-Worktree-Management/issues)

**💡 Have an idea?** [Start a discussion](https://github.com/wnitisak/Git-Worktree-Management/discussions)

