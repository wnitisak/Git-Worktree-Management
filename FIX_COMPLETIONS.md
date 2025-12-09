# Fix Tab Completion - Step by Step

## Problem
Tab completion not working for `gwcc` and `gwc-remove` in Warp terminal.

## Solution: Run These Commands

**Copy and paste these commands into your Warp terminal:**

```bash
# Step 1: Clear old completion cache
rm -f ~/.zcompdump*

# Step 2: Reload the functions
source ~/.zsh/git-worktree/functions.zsh

# Step 3: Restart shell to activate
exec zsh
```

After the shell restarts, test it:

```bash
# Go to a git repo
cd /path/to/your/repo

# Test completion (press TAB TWICE, not once)
gwcc <TAB><TAB>
```

## If Still Not Working

### Check 1: Verify Functions Are Loaded

```bash
# Should show function definition
type gwcc

# Should show completion function
type _git-worktree-create
```

### Check 2: Verify Completions Are Registered

```bash
# Check if gwcc has completion
compdef -p | grep gwcc

# Should output something like:
# compdef _git-worktree-create gwcc
```

### Check 3: Test Completion Manually

```bash
# Go to a git repository first
cd /path/to/your/git/repo

# Try this:
gwcc <TAB><TAB>
# Press TAB key TWICE (important in Warp!)
```

## Important for Warp Users

**Warp terminal requires pressing TAB TWICE** because:
1. First TAB = Warp's AI suggestions
2. Second TAB = Shell's native completions

### Make It Work with Single TAB

Configure Warp to prioritize shell completions:

1. **Open Warp Settings**: Press `Cmd + ,`
2. Click **Features** in the left sidebar
3. Click **Completions**
4. Find **"Completion Menu Source Ordering"** or similar
5. Move **"Shell Completions"** to the top

Now single TAB should work!

## Alternative: Use Different Terminal Temporarily

If Warp is still giving issues, test in regular terminal:

```bash
# Open regular Terminal.app or iTerm2
source ~/.zsh/git-worktree/functions.zsh
cd /path/to/git/repo
gwcc <TAB>
```

If it works there, it confirms the issue is Warp-specific.

## What Should Happen

When you type `gwcc <TAB><TAB>` in a git repository:

```
$ gwcc <TAB><TAB>
main
develop  
feature/api
feature/auth
hotfix/bug-123
origin/staging
...
```

You should see ALL your local and remote branches!

## Still Having Issues?

Try this diagnostic:

```bash
# Check if you're in a git repo
git rev-parse --git-dir

# List branches manually
git branch -a

# Try the completion function directly
_git-worktree-create
```

If you see branches from `git branch -a` but not from tab completion, the issue is definitely Warp's completion system interfering.

