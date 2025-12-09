# Warp Terminal Support Added

## Summary

Added support for **Warp terminal** alongside Cursor and VS Code integration in the git worktree manager.

## New Features

### 1. New Shortcut Command: `gwcw`

Create a worktree and automatically open it in **Warp terminal**:

```bash
gwcw feature/new-api
```

This is equivalent to:
```bash
gwc feature/new-api --open warp
```

### 2. Warp Support in `gwc-open`

Open existing worktrees in Warp:

```bash
gwc-open feature/login warp
```

### 3. Warp Option in Main Command

Use the `--open` flag with warp:

```bash
gwc feature/auth --open warp
```

## Usage Examples

### Create and open in Warp
```bash
# Using shortcut (recommended)
gwcw hotfix/bug-123

# Using full command
gwc hotfix/bug-123 --open warp
```

### Open existing worktree in Warp
```bash
gwc-open feature/api warp
```

### Tab Completion
Tab completion now includes `warp`:
```bash
gwc feature/test --open <TAB>
# Shows: cursor code warp vim nano
```

## Available Editor/Terminal Options

| Command | Shortcut | Description |
|---------|----------|-------------|
| `--cursor` / `-c` | `gwcc` | Open in Cursor editor |
| `--open warp` | `gwcw` | Open in Warp terminal |
| `--open code` | - | Open in VS Code |
| `--open vscode` | - | Open in VS Code |
| `--open <editor>` | - | Open in any editor/app |

## How It Works

When you use `gwcw` or `--open warp`, the script uses macOS's `open` command:

```bash
open -a Warp /path/to/worktree
```

This opens a new Warp window at the worktree directory.

## Quick Reference

### Creating Worktrees

```bash
# Cursor
gwcc feature/new         # Opens in Cursor
gwc feature/new -c       # Same as above

# Warp
gwcw feature/new         # Opens in Warp
gwc feature/new --open warp  # Same as above

# VS Code
gwc feature/new --open code

# Just create (no auto-open)
gwc feature/new
```

### Opening Existing Worktrees

```bash
# Default (Cursor)
gwc-open feature/api

# Specific editor/terminal
gwc-open feature/api warp
gwc-open feature/api code
gwc-open feature/api cursor
```

## Complete Workflow Example

```bash
# 1. Create worktree and open in Warp
gwcw feature/payment-integration

# 2. Warp opens automatically at the worktree location
# You're now in: <repo>/.worktrees/feature/payment-integration

# 3. Do your work...
git status
npm install axios
# etc.

# 4. When done, remove the worktree
gwc-rm-branch feature/payment-integration
```

## Benefits of Warp Integration

- ✅ **Fast terminal access** - Instantly open worktree in Warp
- ✅ **Modern terminal** - Use Warp's AI features and UI
- ✅ **Consistent workflow** - Same pattern as Cursor integration
- ✅ **Tab completion** - Warp is suggested when typing commands

## Requirements

- **Warp terminal** must be installed on your Mac
- Download from: https://www.warp.dev/

## Changes Made

1. Added `gwcw` function (line 466-474)
2. Added `warp` case in `git-worktree-create()` (line 374-375)
3. Added `warp` case in `gwc-open()` (line 623-624)
4. Updated tab completion to include `warp` (line 755)
5. Updated help text and examples
6. Registered `gwcw` for tab completion (line 850)

## Reload to Activate

After updating, reload the functions:

```bash
source ~/.zsh/git-worktree/functions.zsh
```

Or restart your terminal.

## Testing

Test the new functionality:

```bash
# Test shortcut
gwcw test/warp-demo

# Should:
# - Create worktree at .worktrees/test/warp-demo
# - Link node_modules and .env files
# - Open Warp terminal at that location

# Clean up
gwc-rm-branch test/warp-demo
```

Enjoy faster worktree workflows with Warp! 🚀

