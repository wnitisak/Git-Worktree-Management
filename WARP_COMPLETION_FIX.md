# Fixing Tab Completion in Warp Terminal

## Problem

Warp terminal's AI-powered autocomplete system may interfere with or override Zsh's native tab completion for custom functions like `gwcc` and `gwc-remove`.

**Symptoms:**
- Branch suggestions don't appear when typing `gwcc <TAB>`
- Worktree path suggestions don't appear when typing `gwc-remove <TAB>`
- Warp shows its own suggestions instead of your custom completions

## Solutions

### Solution 1: Ensure Completions Are Loaded (Recommended)

Add this to your `~/.zshrc` **after** sourcing the git-worktree functions:

```bash
# Source git worktree functions
source ~/.zsh/git-worktree/functions.zsh

# Force reload completions (important for Warp)
autoload -Uz compinit && compinit

# Alternative: rebuild completion cache
# rm -f ~/.zcompdump; compinit
```

### Solution 2: Use Zsh's Native Tab Completion in Warp

In Warp terminal, you need to press **TAB twice** or configure Warp to prioritize Zsh completions:

1. **Warp Settings** → **Features** → **Completions**
2. Set completion priority to prefer **shell completions** over Warp's AI suggestions

### Solution 3: Verify Completion Functions Are Working

Test if completions are properly registered:

```bash
# Check if completion function exists
which _git-worktree-create
# Should output: _git-worktree-create () { ... }

# Check if gwcc has completion assigned
whence -w gwcc
# Should output: gwcc: function

# List all completions for gwcc
compdef -p | grep gwcc
# Should show: compdef _git-worktree-create gwcc
```

### Solution 4: Manual Completion Trigger

If Warp's suggestions are in the way, you can:

1. **Press TAB twice** - Forces Zsh completion
2. **Press Ctrl+Space** - May trigger native completions in some terminals
3. **Type partial match** - Type first few letters, then TAB

### Solution 5: Force Completion Rebuild

If completions aren't working at all:

```bash
# Remove completion cache
rm -f ~/.zcompdump*

# Reload shell
exec zsh

# Re-source functions
source ~/.zsh/git-worktree/functions.zsh

# Test
gwcc <TAB><TAB>
```

## Testing Your Completions

### Test Branch Completion for gwcc

```bash
# Go to a git repo
cd /path/to/your/repo

# Try completion (press TAB twice)
gwcc <TAB>

# Should show:
# - All local branches
# - All remote branches (without origin/ prefix)
```

### Test Worktree Path Completion for gwc-remove

```bash
# First create some worktrees
gwcc test/branch1
gwcc test/branch2

# Try completion
gwc-remove <TAB>

# Should show:
# - /path/to/repo/.worktrees/test/branch1
# - /path/to/repo/.worktrees/test/branch2
```

### Test Branch Completion for Navigation

```bash
gwc-cd <TAB>

# Should show only branches that have worktrees
```

## Warp-Specific Configuration

### Option A: Disable Warp AI Completions for Specific Commands

Create or edit `~/.warp/completions.yaml`:

```yaml
# Disable Warp completions for git worktree commands
disabledCommands:
  - gwc
  - gwcc
  - gwcw
  - gwc-remove
  - gwc-cd
  - gwc-open
  - gwc-rm-branch
```

### Option B: Prefer Shell Completions Globally

In Warp:
1. Press `Cmd + ,` (Settings)
2. Go to **Features** → **Completions**
3. Set **Completion Source Priority**: **Shell First**

## Common Issues and Fixes

### Issue 1: "No matches found"

**Cause:** Not in a git repository or no branches exist

**Fix:**
```bash
cd /path/to/git/repo
git branch -a  # Verify branches exist
gwcc <TAB>
```

### Issue 2: Completions show wrong items

**Cause:** Completion cache is stale

**Fix:**
```bash
rm -f ~/.zcompdump*
exec zsh
source ~/.zsh/git-worktree/functions.zsh
```

### Issue 3: TAB shows Warp suggestions, not Zsh completions

**Cause:** Warp AI is overriding shell completions

**Fix:**
- Press **TAB twice rapidly**
- Or configure Warp to prefer shell completions (see Option B above)

### Issue 4: Completions work in regular terminal but not Warp

**Cause:** Warp may not load `.zshrc` the same way

**Fix:**
Add to top of `~/.zshrc`:
```bash
# Ensure Warp uses proper Zsh initialization
if [[ "$TERM_PROGRAM" == "WarpTerminal" ]]; then
    source ~/.zsh/git-worktree/functions.zsh
    autoload -Uz compinit && compinit
fi
```

## Debugging Steps

### Step 1: Verify Functions Are Loaded

```bash
type gwcc
# Should show function definition

type _git-worktree-create
# Should show completion function definition
```

### Step 2: Check Completion Registration

```bash
# See what completion is assigned to gwcc
complete -p gwcc 2>/dev/null || compdef -p | grep gwcc
```

### Step 3: Test Completion Manually

```bash
# Force completion for gwcc
_git-worktree-create

# This should trigger the completion function directly
```

### Step 4: Enable Zsh Debug Mode

```bash
# See what's happening during completion
zstyle ':completion:*' verbose yes
zstyle ':completion:*' format 'Completing %d'

gwcc <TAB>
```

## Recommended ~/.zshrc Setup for Warp

```bash
# ============================================
# Git Worktree Functions
# ============================================

# Source the functions
source ~/.zsh/git-worktree/functions.zsh

# Ensure completions work in Warp
if [[ "$TERM_PROGRAM" == "WarpTerminal" ]]; then
    # Force completion system initialization
    autoload -Uz compinit
    compinit -C  # -C skips security check for faster loading
    
    # Rebuild completion cache if needed
    # Uncomment if completions aren't working:
    # rm -f ~/.zcompdump; compinit
fi

# Optional: Better completion matching
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'  # Case insensitive
zstyle ':completion:*' menu select  # Menu selection
```

## Quick Fix Summary

**If completions aren't working in Warp:**

1. **Reload shell:** `exec zsh`
2. **Re-source functions:** `source ~/.zsh/git-worktree/functions.zsh`
3. **Press TAB twice** instead of once
4. **Check Warp settings:** Prefer shell completions over AI
5. **Rebuild cache:** `rm -f ~/.zcompdump; exec zsh`

## Verification

After applying fixes, test:

```bash
# Test 1: Branch completion
cd /path/to/repo
gwcc <TAB><TAB>
# Expected: List of all local and remote branches

# Test 2: Worktree removal completion  
gwc-remove <TAB><TAB>
# Expected: List of existing worktree paths

# Test 3: Navigation completion
gwc-cd <TAB><TAB>
# Expected: List of branches with worktrees
```

If these work, your completions are properly configured! 🎉

