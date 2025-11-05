#!/usr/bin/env zsh
# ============================================
# Git Worktree Management Functions
# ============================================
# This file contains all git worktree related functions and aliases
# Source this file in your .zshrc: source ~/.zsh/git-worktree/functions.zsh

# ============================================
# Help Function
# ============================================
gwc-help() {
    cat << 'EOF'
╔══════════════════════════════════════════════════════════════════════════════╗
║                     Git Worktree Manager (GWC) - Help                        ║
╚══════════════════════════════════════════════════════════════════════════════╝

DESCRIPTION:
    A comprehensive set of tools for managing Git worktrees efficiently.
    Git worktrees allow you to work on multiple branches simultaneously without
    switching branches in your main repository.

INSTALLATION:
    Add this line to your ~/.zshrc:
        source ~/.zsh/git-worktree/functions.zsh

    Then reload your shell:
        source ~/.zshrc

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

COMMANDS:

  📁 CREATE & OPEN
  ─────────────────────────────────────────────────────────────────────────────
  gwc <branch> [path]
      Create a new worktree from an existing branch.
      
      Options:
        --cursor, -c    Open the worktree in Cursor editor after creation
        --open, -o      Open the worktree in default editor after creation
      
      Examples:
        gwc feature/login                    # Create in ../feature-login
        gwc hotfix/bug /tmp/fix              # Create at custom path
        gwc feature/api --cursor             # Create and open in Cursor

  gwcc <branch> [path]
      Shortcut for: gwc <branch> [path] --cursor
      Creates worktree and automatically opens in Cursor.
      
      Example:
        gwcc hotfix/critical-bug

  gwc-open <branch> [editor]
      Open an existing worktree in your preferred editor.
      
      Arguments:
        branch    Branch name of the worktree to open
        editor    Editor to use (default: cursor)
                  Options: cursor, code, vscode, code-insiders
      
      Examples:
        gwc-open feature/login               # Open in Cursor
        gwc-open feature/api code            # Open in VS Code
        gwc-open hotfix/bug vscode           # Open in VS Code

  ─────────────────────────────────────────────────────────────────────────────

  📋 LIST & INFO
  ─────────────────────────────────────────────────────────────────────────────
  gwc-list  (alias: gwc-ls)
      List all worktrees with their paths and branches.
      
      Example output:
        /Users/user/project            abc123d [main]
        /Users/user/project-feature    xyz789e [feature/login]

  gwc-info
      Show detailed information about all worktrees including:
        • Path and branch name
        • Git status (modified, added, untracked files)
        • Sync status with remote (ahead/behind commits)
      
      Example output:
        📁 /path/to/worktree-main
           🌿 main
           📊 Clean
           ⬆️  Up to date with origin

  gwc-branches
      List only the branch names that have associated worktrees.
      Useful for quick reference or scripting.
      
      Example output:
        main
        feature/login
        hotfix/bug-fix

  ─────────────────────────────────────────────────────────────────────────────

  🗑️  REMOVE & CLEANUP
  ─────────────────────────────────────────────────────────────────────────────
  gwc-remove <path>  (alias: gwc-rm)
      Remove a worktree by its path.
      Tab completion available for existing worktree paths.
      
      Example:
        gwc-remove /path/to/worktree

  gwc-rm-branch <branch>
      Remove a worktree by its branch name (more convenient than path).
      Tab completion available for branch names.
      
      Example:
        gwc-rm-branch feature/old-feature

  gwc-cleanup
      Prune stale or invalid worktree references.
      Useful when worktree directories have been deleted manually.
      
      Example:
        gwc-cleanup

  ─────────────────────────────────────────────────────────────────────────────

  🧭 NAVIGATION
  ─────────────────────────────────────────────────────────────────────────────
  gwc-cd <branch>
      Navigate to a worktree directory by its branch name.
      Tab completion available for branch names.
      
      Examples:
        gwc-cd feature/login        # cd to the worktree for feature/login
        gwc-cd main                 # cd to the main worktree

  ─────────────────────────────────────────────────────────────────────────────

  🏥 MAINTENANCE
  ─────────────────────────────────────────────────────────────────────────────
  gwc-health
      Perform a comprehensive health check on all worktrees:
        ✓ Verify directory existence
        ✓ Check git repository validity
        ✓ Detect uncommitted changes
        ✓ Report any issues found
      
      Example output:
        Checking worktree health...
        ✓ /path/to/main - OK
        ⚠ /path/to/feature - Uncommitted changes
        ✗ /path/to/old - Directory does not exist
  
  ─────────────────────────────────────────────────────────────────────────────
  
  🔧 FIX CURSOR AUTO-CREATED WORKTREES
  ─────────────────────────────────────────────────────────────────────────────
  gwc-detect-unlinked
      Scan for directories in ~/.cursor/worktrees/ that aren't proper git worktrees.
      This happens when Cursor creates a worktree directory automatically but
      doesn't link it to a git branch.
      
      Example output:
        🔍 Scanning for unlinked worktree directories...
        ❌ Found unlinked directory: ~/.cursor/worktrees/my-repo/feature/api
        ⚠️  Found 1 unlinked director(ies)
        To fix these, run: gwc-link
  
  gwc-link  (alias: gwc-link-interactive)
      ✨ INTERACTIVE: Select unlinked directory, then select branch to link.
      Two-step process with visual menus:
        1. Shows list of unlinked directories - select by number
        2. Shows available branches - enter branch name (with suggestions)
        3. If branch doesn't exist, option to create it (like gwcc)
      
      This is the main way to fix Cursor-created worktree directories!
      
      Example:
        cd /path/to/main/repo
        gwc-link            # Start interactive process
        # Can link to existing branch OR create new one!

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

TYPICAL WORKFLOWS:

  1. Start working on a new feature:
     $ gwcc feature/new-ui           # Create worktree and open in Cursor
     $ gwc-cd feature/new-ui         # Navigate to worktree
     # ... do your work ...
     $ gwc-rm-branch feature/new-ui  # Remove when done

  2. Quick bug fix on another branch:
     $ gwc hotfix/critical --cursor  # Create and open
     # ... fix bug ...
     $ gwc-cd main                   # Return to main worktree
     $ gwc-rm-branch hotfix/critical # Clean up

  3. Review multiple worktrees:
     $ gwc-info                      # See status of all worktrees
     $ gwc-health                    # Check for any issues
     $ gwc-cleanup                   # Remove stale references

  4. Open existing worktree in different editor:
     $ gwc-open feature/api code     # Open in VS Code
     $ gwc-open feature/api cursor   # Open in Cursor
  
  5. Fix Cursor auto-created worktrees:
     $ gwc-detect-unlinked           # Find unlinked directories
     $ gwc-link                      # Interactive: select directory & branch

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

TAB COMPLETION:
    All commands support intelligent tab completion:
    • Branch names are suggested from your local git branches
    • Worktree paths are suggested from existing worktrees
    • Editor names are suggested for the gwc-open command

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

TIPS:
    • Use gwc-info regularly to monitor worktree status
    • Run gwc-health before cleaning up to avoid data loss
    • Use gwc-cd to quickly switch between worktrees
    • Combine gwcc with your workflow for quick context switching
    • Use gwc-cleanup after manually deleting worktree directories

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

MORE INFO:
    • Official Git Worktree Docs: https://git-scm.com/docs/git-worktree
    • Source Code: ~/.zsh/git-worktree/functions.zsh
    • Documentation: ~/.zsh/git-worktree/README.md

╔══════════════════════════════════════════════════════════════════════════════╗
║  For quick reference, run: gwc-help | less                                   ║
╚══════════════════════════════════════════════════════════════════════════════╝
EOF
}

# ============================================
# Main Function: Create worktree from branch
# ============================================
git-worktree-create() {
    if [ -z "$1" ]; then
        echo "Usage: git-worktree-create <branch-name> [options]"
        echo "Options:"
        echo "  -p, --path <path>    Custom worktree path"
        echo "  -c, --cursor         Open in Cursor after creation"
        echo "  -o, --open <editor>   Open in specified editor (cursor, code, etc.)"
        return 1
    fi
    
    local branch_name=""
    local worktree_path=""
    local open_editor=""
    
    # Parse arguments - handle branch name that might start with - or contain /
    while [[ $# -gt 0 ]]; do
        case $1 in
            -p|--path)
                worktree_path="$2"
                shift 2
                ;;
            -c|--cursor)
                open_editor="cursor"
                shift
                ;;
            -o|--open)
                open_editor="$2"
                shift 2
                ;;
            -*)
                echo "Unknown option: $1"
                return 1
                ;;
            *)
                # First non-option argument is the branch name
                if [ -z "$branch_name" ]; then
                    branch_name="$1"
                else
                    echo "Error: Multiple branch names provided: $branch_name and $1"
                    return 1
                fi
                shift
                ;;
        esac
    done
    
    if [ -z "$branch_name" ]; then
        echo "Error: Branch name is required"
        return 1
    fi
    
    # Default worktree path
    if [ -z "$worktree_path" ]; then
        local repo_name=$(basename $(git rev-parse --show-toplevel 2>/dev/null || pwd))
        worktree_path="$HOME/.cursor/worktrees/$repo_name/$branch_name"
    fi
    
    # Check if we're in a git repo
    local main_repo=$(git rev-parse --show-toplevel 2>/dev/null)
    if [ -z "$main_repo" ]; then
        echo "Error: Not in a git repository"
        return 1
    fi
    
    # Check if branch exists (local or remote)
    local branch_exists=false
    if git show-ref --verify --quiet refs/heads/$branch_name; then
        branch_exists=true
    elif git show-ref --verify --quiet refs/remotes/origin/$branch_name; then
        branch_exists=true
        echo "Branch found in remote, will checkout from origin..."
    fi
    
    if [ "$branch_exists" = false ]; then
        echo "Error: Branch '$branch_name' does not exist locally or remotely"
        echo "Available branches:"
        git branch -a | grep -E "^\*|remotes/origin/$branch_name" | head -10
        return 1
    fi
    
    # Check if worktree path already exists
    if [ -d "$worktree_path" ]; then
        echo "Warning: Directory already exists: $worktree_path"
        read "response?Remove and recreate? (y/N): "
        if [[ "$response" =~ ^[Yy]$ ]]; then
            cd "$main_repo"
            git worktree remove "$worktree_path" --force 2>/dev/null
            rm -rf "$worktree_path"
        else
            echo "Aborted"
            return 1
        fi
    fi
    
    # Create parent directory
    mkdir -p "$(dirname "$worktree_path")"
    
    # Create worktree
    echo "Creating worktree from branch: $branch_name"
    echo "Path: $worktree_path"
    
    if git worktree add "$worktree_path" "$branch_name"; then
        echo "✓ Worktree created successfully!"
        echo "  Location: $worktree_path"
        echo "  Branch: $branch_name"
        
        # Open in editor if specified
        if [ -n "$open_editor" ]; then
            echo "Opening in $open_editor..."
            case $open_editor in
                cursor)
                    cursor "$worktree_path" &
                    ;;
                code)
                    code "$worktree_path" &
                    ;;
                *)
                    $open_editor "$worktree_path" &
                    ;;
            esac
        fi
        
        # Change to worktree directory
        cd "$worktree_path"
        return 0
    else
        echo "Error: Failed to create worktree"
        return 1
    fi
}

# ============================================
# Helper Functions
# ============================================
# Function for gwcc (allows branch names with slashes)
function gwcc() {
    if [ -z "$1" ]; then
        echo "Usage: gwcc <branch-name>"
        echo "Example: gwcc hotfix/Rasmee"
        return 1
    fi
    git-worktree-create "$1" --cursor
}

# ============================================
# Enhanced Worktree Management Features
# ============================================

# Navigate to worktree by branch name
gwc-cd() {
    if [ -z "$1" ]; then
        echo "Usage: gwc-cd <branch-name>"
        echo "Example: gwc-cd hotfix/Rasmee"
        return 1
    fi
    
    local branch_name=$1
    local repo_name=$(basename $(git rev-parse --show-toplevel 2>/dev/null || pwd))
    local worktree_path="$HOME/.cursor/worktrees/$repo_name/$branch_name"
    
    if [ -d "$worktree_path" ]; then
        cd "$worktree_path"
        echo "✓ Switched to worktree: $worktree_path"
    else
        echo "Error: Worktree not found at $worktree_path"
        echo "Available worktrees:"
        git worktree list 2>/dev/null || echo "  Not in a git repository"
        return 1
    fi
}

# List worktrees with detailed information
gwc-info() {
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        echo "Error: Not in a git repository"
        return 1
    fi
    
    local main_repo=$(git rev-parse --show-toplevel 2>/dev/null)
    echo "📁 Git Worktrees for $(basename $main_repo):"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    
    while IFS= read -r line; do
        local path=${line%% *}  # Get first field using ZSH parameter expansion
        # Extract branch name using Zsh parameter expansion
        local branch="${${line##*\[}%%\]*}"
        
        if [ -z "$branch" ]; then
            branch="(main repository)"
        fi
        
        echo ""
        echo "📍 Path: $path"
        echo "🌿 Branch: $branch"
        
        if [ "$path" != "$main_repo" ] && [ -d "$path" ]; then
            # Show git status
            (cd "$path" 2>/dev/null && {
                local status=$(git status --porcelain 2>/dev/null)
                if [ -n "$status" ]; then
                    local modified=$(echo "$status" | grep -c '^ M' || echo 0)
                    local added=$(echo "$status" | grep -c '^A' || echo 0)
                    local untracked=$(echo "$status" | grep -c '^??' || echo 0)
                    echo "📝 Status: ${modified} modified, ${added} added, ${untracked} untracked"
                else
                    echo "✓ Status: Clean"
                fi
                
                # Show commits ahead/behind
                local upstream=$(git rev-parse --abbrev-ref @{upstream} 2>/dev/null)
                if [ -n "$upstream" ]; then
                    local ahead=$(git rev-list --count @{upstream}..HEAD 2>/dev/null || echo 0)
                    local behind=$(git rev-list --count HEAD..@{upstream} 2>/dev/null || echo 0)
                    if [ "$ahead" -gt 0 ] || [ "$behind" -gt 0 ]; then
                        echo "🔄 Sync: ↑${ahead} ahead, ↓${behind} behind"
                    else
                        echo "✓ Sync: Up to date"
                    fi
                fi
            })
        fi
    done < <(git worktree list 2>/dev/null)
    
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
}

# Remove worktree by branch name
gwc-rm-branch() {
    if [ -z "$1" ]; then
        echo "Usage: gwc-rm-branch <branch-name>"
        echo "Example: gwc-rm-branch hotfix/Rasmee"
        return 1
    fi
    
    local branch_name=$1
    local repo_name=$(basename $(git rev-parse --show-toplevel 2>/dev/null || pwd))
    local worktree_path="$HOME/.cursor/worktrees/$repo_name/$branch_name"
    
    if [ -d "$worktree_path" ]; then
        local main_repo=$(git rev-parse --show-toplevel 2>/dev/null)
        cd "$main_repo"
        git worktree remove "$worktree_path" --force
        echo "✓ Removed worktree: $worktree_path"
    else
        echo "Error: Worktree not found at $worktree_path"
        echo "Available worktrees:"
        git worktree list 2>/dev/null
        return 1
    fi
}

# Open existing worktree in editor
gwc-open() {
    if [ -z "$1" ]; then
        echo "Usage: gwc-open <branch-name> [editor]"
        echo "Example: gwc-open hotfix/Rasmee"
        echo "         gwc-open hotfix/Rasmee cursor"
        return 1
    fi
    
    local branch_name=$1
    local editor=${2:-cursor}
    local repo_name=$(basename $(git rev-parse --show-toplevel 2>/dev/null || pwd))
    local worktree_path="$HOME/.cursor/worktrees/$repo_name/$branch_name"
    
    if [ -d "$worktree_path" ]; then
        case $editor in
            cursor)
                cursor "$worktree_path" &
                ;;
            code)
                code "$worktree_path" &
                ;;
            *)
                $editor "$worktree_path" &
                ;;
        esac
        echo "✓ Opening worktree in $editor: $worktree_path"
    else
        echo "Error: Worktree not found at $worktree_path"
        return 1
    fi
}

# List all branches that have worktrees
gwc-branches() {
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        echo "Error: Not in a git repository"
        return 1
    fi
    
    echo "🌿 Branches with worktrees:"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    
    local main_repo=$(git rev-parse --show-toplevel 2>/dev/null)
    local count=0
    
    while IFS= read -r line; do
        local path=${line%% *}  # Get first field using ZSH parameter expansion
        # Extract branch name using Zsh parameter expansion
        local branch="${${line##*\[}%%\]*}"
        
        if [ "$path" != "$main_repo" ] && [ -n "$branch" ]; then
            echo "  • $branch → $path"
            ((count++))
        fi
    done < <(git worktree list 2>/dev/null)
    
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "Total: $count worktree(s)"
}

# Clean up invalid/broken worktrees
gwc-cleanup() {
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        echo "Error: Not in a git repository"
        return 1
    fi
    
    echo "🧹 Cleaning up broken worktrees..."
    git worktree prune --verbose
    echo "✓ Cleanup complete"
}

# Health check for all worktrees
gwc-health() {
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        echo "Error: Not in a git repository"
        return 1
    fi
    
    echo "🏥 Health check for worktrees:"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    
    local main_repo=$(git rev-parse --show-toplevel 2>/dev/null)
    local issues=0
    
    while IFS= read -r line; do
        local path=${line%% *}  # Get first field using ZSH parameter expansion
        # Extract branch name using Zsh parameter expansion
        local branch="${${line##*\[}%%\]*}"
        
        if [ "$path" = "$main_repo" ]; then
            continue
        fi
        
        echo ""
        echo "Checking: $branch"
        
        # Check if directory exists
        if [ ! -d "$path" ]; then
            echo "  ❌ Directory not found: $path"
            ((issues++))
            continue
        fi
        
        # Check if it's a valid git directory
        if ! (cd "$path" && git rev-parse --git-dir > /dev/null 2>&1); then
            echo "  ❌ Not a valid git worktree"
            ((issues++))
            continue
        fi
        
        # Check for uncommitted changes
        if (cd "$path" && [ -n "$(git status --porcelain 2>/dev/null)" ]); then
            echo "  ⚠️  Has uncommitted changes"
        else
            echo "  ✓ Clean"
        fi
    done < <(git worktree list 2>/dev/null)
    
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    if [ $issues -eq 0 ]; then
        echo "✓ All worktrees are healthy"
    else
        echo "⚠️  Found $issues issue(s). Run 'gwc-cleanup' to fix."
    fi
}

# ============================================
# Fix Cursor-Created Worktrees
# ============================================

# Detect directories created by Cursor that aren't proper git worktrees
gwc-detect-unlinked() {
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        echo "Error: Not in a git repository"
        return 1
    fi
    
    local main_repo=$(git rev-parse --show-toplevel 2>/dev/null)
    local repo_name=$(basename "$main_repo")
    local worktrees_base="$HOME/.cursor/worktrees/$repo_name"
    
    if [ ! -d "$worktrees_base" ]; then
        echo "No worktrees directory found at: $worktrees_base"
        return 0
    fi
    
    echo "🔍 Scanning for unlinked worktree directories..."
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    
    local found_issues=0
    local -a existing_worktrees
    
    # Get list of existing git worktrees
    while IFS= read -r line; do
        local wt_path=${line%% *}  # Get first field using ZSH parameter expansion
        existing_worktrees+=("$wt_path")
    done < <(git worktree list 2>/dev/null)
    
    # Scan all directories in worktrees base
    for dir in "$worktrees_base"/*(/N); do
        local branch_name=$(basename "$dir")
        local is_linked=false
        
        # Check if this directory is a registered git worktree
        for wt in "${existing_worktrees[@]}"; do
            if [ "$wt" = "$dir" ]; then
                is_linked=true
                break
            fi
        done
        
        if [ "$is_linked" = false ]; then
            echo ""
            echo "❌ Found unlinked directory: $dir"
            echo "   Expected branch: $branch_name"
            ((found_issues++))
        fi
    done
    
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    
    if [ $found_issues -eq 0 ]; then
        echo "✓ No unlinked directories found"
    else
        echo "⚠️  Found $found_issues unlinked director(ies)"
        echo ""
        echo "To fix these, run: gwc-link"
    fi
}

# Interactive: Select unlinked directory, then select branch to link
gwc-link-interactive() {
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        echo "Error: Not in a git repository"
        return 1
    fi
    
    local main_repo=$(git rev-parse --show-toplevel 2>/dev/null)
    local repo_name=$(basename "$main_repo")
    local worktrees_base="$HOME/.cursor/worktrees/$repo_name"
    
    if [ ! -d "$worktrees_base" ]; then
        echo "No worktrees directory found at: $worktrees_base"
        return 0
    fi
    
    echo "🔍 Finding unlinked directories..."
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    
    local -a unlinked_dirs
    local -a existing_worktrees
    
    # Get list of existing git worktrees
    while IFS= read -r line; do
        local wt_path=${line%% *}  # Get first field using ZSH parameter expansion
        existing_worktrees+=("$wt_path")
    done < <(git worktree list 2>/dev/null)
    
    # Find unlinked directories (including subdirectories for branch/feature structure)
    # Scan both direct children and nested subdirectories (e.g., hotfix/Protriva, feature/Uploros)
    for dir in "$worktrees_base"/*(/N) "$worktrees_base"/*/*(/N); do
        [ -d "$dir" ] || continue
        
        local is_linked=false
        local is_inside_linked=false
        
        # Check if this directory is a linked worktree
        for wt in "${existing_worktrees[@]}"; do
            if [ "$wt" = "$dir" ]; then
                is_linked=true
                break
            fi
            
            # Check if this directory is INSIDE a linked worktree (subdirectory of it)
            # e.g., Tzmni/Layout is inside Tzmni (which is linked)
            if [[ "$dir" == "$wt"/* ]]; then
                is_inside_linked=true
                break
            fi
        done
        
        # Check if this is just an organizational folder (like hotfix/) or actual worktree
        # Skip if it has subdirectories but no files (likely just a parent folder)
        local has_subdirs=false
        local has_content=false
        
        if [ -n "$(ls -A "$dir" 2>/dev/null)" ]; then
            has_content=true
            # Check if it only contains directories (organizational folder)
            if [ -d "$dir" ] && [ -z "$(find "$dir" -maxdepth 1 -type f 2>/dev/null)" ]; then
                # Has no files at top level, might be organizational
                if [ -n "$(find "$dir" -maxdepth 1 -type d ! -name "$(basename "$dir")" 2>/dev/null)" ]; then
                    has_subdirs=true
                fi
            fi
        fi
        
        # Only add if:
        # - Not linked AND not inside a linked worktree
        # - AND (has files OR is empty OR has no subdirs - not just organizational folder)
        if [ "$is_linked" = false ] && [ "$is_inside_linked" = false ]; then
            # Skip organizational folders (only subdirectories, no files)
            if [ "$has_subdirs" = true ] && [ "$has_content" = true ]; then
                # This looks like just an organizational folder (e.g., hotfix/, feature/)
                continue
            fi
            unlinked_dirs+=("$dir")
        fi
    done
    
    if [ ${#unlinked_dirs[@]} -eq 0 ]; then
        echo "✓ No unlinked directories found"
        return 0
    fi
    
    echo ""
    echo "Found ${#unlinked_dirs[@]} unlinked director(ies):"
    echo ""
    
    # Display numbered list
    local i=1
    for dir in "${unlinked_dirs[@]}"; do
        # Show relative path from worktrees_base for better context
        local relative_path=${dir#$worktrees_base/}
        echo "  [$i] $relative_path"
        echo "      Path: $dir"
        ((i++))
    done
    
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo -n "Select directory number (1-${#unlinked_dirs[@]}), or 'q' to quit: "
    read selection
    
    if [[ "$selection" == "q" ]] || [[ "$selection" == "Q" ]]; then
        echo "Cancelled"
        return 0
    fi
    
    if ! [[ "$selection" =~ ^[0-9]+$ ]] || [ "$selection" -lt 1 ] || [ "$selection" -gt ${#unlinked_dirs[@]} ]; then
        echo "Error: Invalid selection"
        return 1
    fi
    
    local selected_dir="${unlinked_dirs[$selection]}"
    local relative_path=${selected_dir#$worktrees_base/}
    
    # Suggest branch name as the full relative path (e.g., hotfix/Protriva)
    local suggested_branch="$relative_path"
    
    echo ""
    echo "Selected: $relative_path"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo "Available branches:"
    echo ""
    
    # Get and display all branches
    local -a all_branches
    local -a local_branches
    local_branches=(${(f)"$(git branch --format='%(refname:short)' 2>/dev/null)"})
    
    local -a remote_branches
    local raw_remote_branches=(${(f)"$(git branch -r --format='%(refname:short)' 2>/dev/null | grep -v HEAD)"})
    remote_branches=("${raw_remote_branches[@]#origin/}")
    
    all_branches=($local_branches $remote_branches)
    all_branches=(${(u)all_branches})
    all_branches=(${all_branches:#})
    
    # Display branches in columns
    local col=0
    for branch in "${all_branches[@]}"; do
        printf "  %-35s" "$branch"
        ((col++))
        if [ $((col % 2)) -eq 0 ]; then
            echo ""
        fi
    done
    if [ $((col % 2)) -ne 0 ]; then
        echo ""
    fi
    
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo -n "Enter branch name to link (or suggested: $suggested_branch): "
    read branch_name
    
    # If empty, use suggested branch (full relative path)
    if [ -z "$branch_name" ]; then
        branch_name="$suggested_branch"
        echo "Using: $branch_name"
    fi
    
    # Validate branch exists
    local branch_exists=false
    if git show-ref --verify --quiet refs/heads/$branch_name; then
        branch_exists=true
    elif git show-ref --verify --quiet refs/remotes/origin/$branch_name; then
        branch_exists=true
    fi
    
    if [ "$branch_exists" = false ]; then
        echo ""
        echo "⚠️  Branch '$branch_name' does not exist yet"
        echo ""
        echo "Would you like to:"
        echo "  [1] Create new branch and worktree (like gwcc)"
        echo "  [2] Cancel and choose a different branch"
        echo ""
        echo -n "Your choice (1 or 2): "
        read create_choice
        
        if [[ "$create_choice" == "1" ]]; then
            echo ""
            echo "🌱 Creating new branch '$branch_name' and worktree..."
            
            # Backup existing content if any
            local backup_dir=""
            if [ -n "$(ls -A "$selected_dir" 2>/dev/null)" ]; then
                backup_dir="${selected_dir}.backup.$(date +%Y%m%d_%H%M%S)"
                echo "   📦 Backing up existing content to: $backup_dir"
                mv "$selected_dir" "$backup_dir"
            else
                rm -rf "$selected_dir"
            fi
            
            # Create new branch and worktree (like gwcc does)
            cd "$main_repo"
            if git worktree add -b "$branch_name" "$selected_dir"; then
                echo ""
                echo "✅ Successfully created new branch and worktree!"
                echo "   Location: $selected_dir"
                echo "   Branch: $branch_name (new branch)"
                
                # Restore backup
                if [ -n "$backup_dir" ] && [ -d "$backup_dir" ]; then
                    echo ""
                    echo "   📋 Restoring content from backup..."
                    cp -r "$backup_dir"/* "$selected_dir"/ 2>/dev/null
                    echo "   ✓ Content restored"
                    echo "   💾 Backup kept at: $backup_dir"
                fi
                
                echo ""
                echo "🎉 Done! You can now:"
                echo "   cd $selected_dir"
                echo "   cursor $selected_dir"
                
                return 0
            else
                echo ""
                echo "❌ Failed to create branch and worktree"
                
                # Restore backup
                if [ -n "$backup_dir" ] && [ -d "$backup_dir" ]; then
                    mv "$backup_dir" "$selected_dir"
                fi
                return 1
            fi
        else
            echo "Cancelled"
            return 0
        fi
    fi
    
    echo ""
    echo "🔗 Linking..."
    echo "   Directory: $selected_dir"
    echo "   Branch: $branch_name"
    echo ""
    
    # Backup and create worktree
    local backup_dir=""
    if [ -n "$(ls -A "$selected_dir" 2>/dev/null)" ]; then
        backup_dir="${selected_dir}.backup.$(date +%Y%m%d_%H%M%S)"
        echo "   📦 Backing up existing content to: $backup_dir"
        mv "$selected_dir" "$backup_dir"
    else
        rm -rf "$selected_dir"
    fi
    
    # Create proper worktree
    cd "$main_repo"
    if git worktree add "$selected_dir" "$branch_name"; then
        echo ""
        echo "✅ Successfully created proper git worktree!"
        echo "   Location: $selected_dir"
        echo "   Branch: $branch_name"
        
        # Restore backup
        if [ -n "$backup_dir" ] && [ -d "$backup_dir" ]; then
            echo ""
            echo "   📋 Restoring content from backup..."
            cp -r "$backup_dir"/* "$selected_dir"/ 2>/dev/null
            echo "   ✓ Content restored"
            echo "   💾 Backup kept at: $backup_dir"
        fi
        
        echo ""
        echo "🎉 Done! You can now:"
        echo "   cd $selected_dir"
        echo "   cursor $selected_dir"
        
        return 0
    else
        echo ""
        echo "❌ Failed to create worktree"
        
        # Restore backup
        if [ -n "$backup_dir" ] && [ -d "$backup_dir" ]; then
            mv "$backup_dir" "$selected_dir"
        fi
        return 1
    fi
}

# ============================================
# Aliases
# ============================================
alias gwc='git-worktree-create'
alias gwc-list='git worktree list'
alias gwc-remove='git worktree remove'
alias gwc-ls='git worktree list'
alias gwc-rm='git worktree remove'
alias gwc-link='gwc-link-interactive'  # Short alias for interactive linking

# ============================================
# Zsh Completion Functions
# ============================================
# Completion for branch suggestions
_git-worktree-create() {
    local curcontext="$curcontext" state line
    typeset -A opt_args
    
    _arguments \
        '1:branch:->branch' \
        '(-c --cursor)'{-c,--cursor}'[Open in Cursor after creation]' \
        '(-p --path)'{-p,--path}'[Custom worktree path]:path:_files' \
        '(-o --open)'{-o,--open}'[Open in specified editor]:editor:(cursor code vim nano)'
    
    case $state in
        branch)
            # Only suggest branches if in git repo
            if ! git rev-parse --git-dir > /dev/null 2>&1; then
                return
            fi
            
            # Get local branches
            local -a local_branches
            local_branches=(${(f)"$(git branch --format='%(refname:short)' 2>/dev/null)"})
            
            # Get remote branches (remove origin/ prefix)
            local -a remote_branches
            local raw_remote_branches=(${(f)"$(git branch -r --format='%(refname:short)' 2>/dev/null | grep -v HEAD)"})
            # Remove origin/ prefix using Zsh parameter expansion
            remote_branches=("${raw_remote_branches[@]#origin/}")
            
            # Combine and deduplicate
            local -a all_branches
            all_branches=($local_branches $remote_branches)
            all_branches=(${(u)all_branches})
            
            # Filter out empty entries
            all_branches=(${all_branches:#})
            
            if (( ${#all_branches} > 0 )); then
                _describe -t branches 'branch' all_branches
            fi
            ;;
    esac
}

# Completion for gwc-remove - show only existing worktrees
_gwc-remove() {
    local -a worktree_paths
    
    # Check if in git repository
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        return
    fi
    
    # Get worktree paths (excluding main repository)
    local main_repo=$(git rev-parse --show-toplevel 2>/dev/null)
    
    # Parse git worktree list output
    # Format: /path/to/worktree [branch-name]
    while IFS= read -r line; do
        local path=${line%% *}  # Get first field using ZSH parameter expansion
        if [ -n "$path" ] && [ "$path" != "$main_repo" ]; then
            worktree_paths+=("$path")
        fi
    done < <(git worktree list 2>/dev/null)
    
    # Remove duplicates
    worktree_paths=(${(u)worktree_paths})
    
    if (( ${#worktree_paths} > 0 )); then
        _describe 'worktree path' worktree_paths
    else
        _message 'no worktrees found'
    fi
}

# Completion for branch-based commands (cd, open, rm-branch)
_gwc-branch-complete() {
    local -a branches
    local main_repo=$(git rev-parse --show-toplevel 2>/dev/null)
    
    if [ -z "$main_repo" ]; then
        return
    fi
    
    # Get branch names from worktree list
    while IFS= read -r line; do
        local path=${line%% *}  # Get first field using ZSH parameter expansion
        # Extract branch name using Zsh parameter expansion
        local branch="${${line##*\[}%%\]*}"
        if [ "$path" != "$main_repo" ] && [ -n "$branch" ]; then
            branches+=("$branch")
        fi
    done < <(git worktree list 2>/dev/null)
    
    branches=(${(u)branches})
    if (( ${#branches} > 0 )); then
        _describe 'branch' branches
    fi
}

# ============================================
# Register Completions
# ============================================
# Only register if completion system is available
if (( $+functions[compdef] )) || { autoload -Uz compinit && compinit -C 2>/dev/null; }; then
    compdef _git-worktree-create git-worktree-create gwc gwcc 2>/dev/null
    compdef _gwc-remove gwc-remove gwc-rm 2>/dev/null
    compdef _gwc-branch-complete gwc-cd 2>/dev/null
    compdef _gwc-branch-complete gwc-open 2>/dev/null
    compdef _gwc-branch-complete gwc-rm-branch 2>/dev/null
fi
