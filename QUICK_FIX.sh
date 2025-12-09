#!/usr/bin/env zsh
# Quick fix script for Warp terminal completion issues

echo "🔧 Git Worktree Completion Fix for Warp Terminal"
echo "=================================================="
echo ""

# Check if we're in Warp
if [[ "$TERM_PROGRAM" == "WarpTerminal" ]]; then
    echo "✓ Running in Warp Terminal"
else
    echo "⚠️  Not running in Warp Terminal (detected: $TERM_PROGRAM)"
fi

echo ""
echo "Step 1: Clearing completion cache..."
rm -f ~/.zcompdump* 2>/dev/null
echo "✓ Cache cleared"

echo ""
echo "Step 2: Reloading completion system..."
autoload -Uz compinit
compinit

echo ""
echo "Step 3: Re-sourcing git-worktree functions..."
source ~/.zsh/git-worktree/functions.zsh

echo ""
echo "Step 4: Verifying completions are registered..."

# Check each completion
commands=(gwcc gwcw "gwc-remove" "gwc-cd" "gwc-open" "gwc-rm-branch")
for cmd in "${commands[@]}"; do
    if compdef -p | grep -q "$cmd"; then
        echo "  ✓ $cmd - completion registered"
    else
        echo "  ✗ $cmd - completion NOT registered"
    fi
done

echo ""
echo "=================================================="
echo "🎉 Fix complete!"
echo ""
echo "How to test:"
echo "  1. Go to a git repository: cd /path/to/repo"
echo "  2. Try: gwcc <TAB><TAB>"
echo "  3. You should see branch suggestions"
echo ""
echo "Tips for Warp:"
echo "  • Press TAB TWICE (not once) for completions"
echo "  • Or configure Warp: Settings → Features → Completions"
echo "  • Set priority to 'Shell First'"
echo ""

