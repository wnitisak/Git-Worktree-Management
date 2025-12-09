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
        gwc feature/login                    # Create in .worktrees/feature/login
        gwc hotfix/bug --path /tmp/fix       # Create at custom path
        gwc feature/api --cursor             # Create and open in Cursor

  gwcc <branch>
      Shortcut for: gwc <branch> --cursor
      Creates worktree in <main-repo>/.worktrees/<branch> and opens in Cursor.
      
      Example:
        gwcc hotfix/critical-bug

  gwcw <branch>
      Shortcut for: gwc <branch> --open warp
      Creates worktree in <main-repo>/.worktrees/<branch> and opens in Warp.
      
      Example:
        gwcw hotfix/critical-bug

  gwc-open <branch> [editor]
      Open an existing worktree in your preferred editor or terminal.
      
      Arguments:
        branch    Branch name of the worktree to open
        editor    Editor/Terminal to use (default: cursor)
                  Options: cursor, code, vscode, code-insiders, warp
      
      Examples:
        gwc-open feature/login               # Open in Cursor
        gwc-open feature/api code            # Open in VS Code
        gwc-open hotfix/bug warp             # Open in Warp terminal

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

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

IMPORTANT SETUP:

  📝 Add .worktrees/ to .gitignore
  ─────────────────────────────────────────────────────────────────────────────
  Worktrees are created in <main-repo>/.worktrees/ directory.
  Make sure to add this to your .gitignore file:
  
      echo ".worktrees/" >> .gitignore
  
  This prevents worktree directories from being tracked in your repository.

  🔗 Shared Files are Symlinked
  ─────────────────────────────────────────────────────────────────────────────
  The following files are automatically symlinked from the main repo:
    • node_modules/  (if exists)
    • .env           (if exists)
    • .env.local     (if exists)
  
  Benefits:
    ✅ Instant worktree creation (no copying needed)
    ✅ Saves disk space (shared node_modules across all worktrees)
    ✅ Always in sync (npm install in ANY worktree updates ALL worktrees)
  
  Important Notes:
    ⚠️  Installing packages in one worktree affects ALL worktrees
    ⚠️  Changing .env in one worktree affects ALL worktrees
    ℹ️  This ensures consistency across worktrees (usually desired)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

TYPICAL WORKFLOWS:

  1. Start working on a new feature:
     $ gwcc feature/new-ui           # Create worktree and open in Cursor
     $ gwcw feature/new-ui           # Or open in Warp terminal
     $ gwc-cd feature/new-ui         # Navigate to worktree
     # ... do your work ...
     $ gwc-rm-branch feature/new-ui  # Remove when done

  2. Quick bug fix on another branch:
     $ gwc hotfix/critical --cursor  # Create and open in Cursor
     $ gwc hotfix/critical --open warp  # Or open in Warp
     # ... fix bug ...
     $ gwc-cd main                   # Return to main worktree
     $ gwc-rm-branch hotfix/critical # Clean up

  3. Review multiple worktrees:
     $ gwc-info                      # See status of all worktrees
     $ gwc-health                    # Check for any issues
     $ gwc-cleanup                   # Remove stale references

  4. Open existing worktree in different editor/terminal:
     $ gwc-open feature/api code     # Open in VS Code
     $ gwc-open feature/api cursor   # Open in Cursor
     $ gwc-open feature/api warp     # Open in Warp terminal

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

TAB COMPLETION:
    All commands support intelligent tab completion:
    • Branch names are suggested from your local git branches
    • Worktree paths are suggested from existing worktrees
    • Editor names are suggested for the gwc-open command

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

TIPS:
    • Add .worktrees/ to your .gitignore file (important!)
    • Shared files (node_modules, .env) are symlinked for speed and consistency
    • Use gwc-info regularly to monitor worktree status
    • Run gwc-health before cleaning up to avoid data loss
    • Use gwc-cd to quickly switch between worktrees
    • Combine gwcc with your workflow for quick context switching
    • Use gwc-cleanup after manually deleting worktree directories
    • Worktrees are created locally in <repo>/.worktrees/ for better IDE integration
    • Installing packages in one worktree updates all worktrees (shared node_modules)

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
    
    # Check if we're in a git repo
    local main_repo=$(git rev-parse --show-toplevel 2>/dev/null)
    if [ -z "$main_repo" ]; then
        echo "Error: Not in a git repository"
        return 1
    fi
    
    # Default worktree path
    if [ -z "$worktree_path" ]; then
        worktree_path="$main_repo/.worktrees/$branch_name"
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
        
        # Link shared files from main repository
        _gwc_link_shared_files "$main_repo" "$worktree_path"
        
        # Open in editor if specified
        if [ -n "$open_editor" ]; then
            echo ""
            echo "Opening in $open_editor..."
            case $open_editor in
                cursor)
                    cursor "$worktree_path" &
                    ;;
                code|vscode)
                    code "$worktree_path" &
                    ;;
                warp)
                    open -a Warp "$worktree_path" &
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

# Link shared files (node_modules, .env files) to worktree via symlinks
_gwc_link_shared_files() {
    local source_dir="$1"
    local target_dir="$2"
    
    if [ ! -d "$source_dir" ] || [ ! -d "$target_dir" ]; then
        return 1
    fi
    
    echo ""
    echo "🔗 Linking shared files..."
    
    # Symlink node_modules if it exists
    if [ -d "$source_dir/node_modules" ]; then
        if [ ! -e "$target_dir/node_modules" ]; then
            echo "   📚 Linking node_modules/ ..."
            ln -s "$source_dir/node_modules" "$target_dir/node_modules" 2>/dev/null
            if [ $? -eq 0 ]; then
                echo "   ✓ node_modules/ linked"
            else
                echo "   ⚠️  Failed to link node_modules/"
            fi
        else
            echo "   ⚠️  node_modules/ already exists, skipping"
        fi
    fi
    
    # Symlink .env.local if it exists
    if [ -f "$source_dir/.env.local" ]; then
        if [ ! -e "$target_dir/.env.local" ]; then
            echo "   🔐 Linking .env.local..."
            ln -s "$source_dir/.env.local" "$target_dir/.env.local" 2>/dev/null
            if [ $? -eq 0 ]; then
                echo "   ✓ .env.local linked"
            else
                echo "   ⚠️  Failed to link .env.local"
            fi
        else
            echo "   ⚠️  .env.local already exists, skipping"
        fi
    fi
    
    # Symlink .env if it exists
    if [ -f "$source_dir/.env" ]; then
        if [ ! -e "$target_dir/.env" ]; then
            echo "   🔐 Linking .env..."
            ln -s "$source_dir/.env" "$target_dir/.env" 2>/dev/null
            if [ $? -eq 0 ]; then
                echo "   ✓ .env linked"
            else
                echo "   ⚠️  Failed to link .env"
            fi
        else
            echo "   ⚠️  .env already exists, skipping"
        fi
    fi
    
    echo "   ✅ Shared files linked!"
}

# Function for gwcc (allows branch names with slashes) - opens in Cursor
function gwcc() {
    if [ -z "$1" ]; then
        echo "Usage: gwcc <branch-name>"
        echo "Example: gwcc hotfix/Rasmee"
        return 1
    fi
    git-worktree-create "$1" --cursor
}

# Function for gwcw (allows branch names with slashes) - opens in Warp
function gwcw() {
    if [ -z "$1" ]; then
        echo "Usage: gwcw <branch-name>"
        echo "Example: gwcw hotfix/Rasmee"
        return 1
    fi
    git-worktree-create "$1" --open warp
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
    local main_repo=$(git rev-parse --show-toplevel 2>/dev/null)
    
    if [ -z "$main_repo" ]; then
        echo "Error: Not in a git repository"
        return 1
    fi
    
    local worktree_path="$main_repo/.worktrees/$branch_name"
    
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
    local main_repo=$(git rev-parse --show-toplevel 2>/dev/null)
    
    if [ -z "$main_repo" ]; then
        echo "Error: Not in a git repository"
        return 1
    fi
    
    local worktree_path="$main_repo/.worktrees/$branch_name"
    
    if [ -d "$worktree_path" ]; then
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
    local main_repo=$(git rev-parse --show-toplevel 2>/dev/null)
    
    if [ -z "$main_repo" ]; then
        echo "Error: Not in a git repository"
        return 1
    fi
    
    local worktree_path="$main_repo/.worktrees/$branch_name"
    
    if [ -d "$worktree_path" ]; then
        case $editor in
            cursor)
                cursor "$worktree_path" &
                ;;
            code|vscode)
                code "$worktree_path" &
                ;;
            warp)
                open -a Warp "$worktree_path" &
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
# Aliases
# ============================================
alias gwc='git-worktree-create'
alias gwc-list='git worktree list'
alias gwc-remove='git worktree remove'
alias gwc-ls='git worktree list'
alias gwc-rm='git worktree remove'

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
        '(-o --open)'{-o,--open}'[Open in specified editor]:editor:(cursor code warp vim nano)'
    
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
# Initialize completion system if not already done
if [[ ! -v _comp_setup ]]; then
    autoload -Uz compinit
    compinit -C 2>/dev/null
fi

# Register completion functions
# Note for Warp users: Press TAB twice or configure Warp to prefer shell completions
if (( $+functions[compdef] )); then
    compdef _git-worktree-create git-worktree-create 2>/dev/null
    compdef _git-worktree-create gwc 2>/dev/null
    compdef _git-worktree-create gwcc 2>/dev/null
    compdef _git-worktree-create gwcw 2>/dev/null
    compdef _gwc-remove gwc-remove 2>/dev/null
    compdef _gwc-remove gwc-rm 2>/dev/null
    compdef _gwc-branch-complete gwc-cd 2>/dev/null
    compdef _gwc-branch-complete gwc-open 2>/dev/null
    compdef _gwc-branch-complete gwc-rm-branch 2>/dev/null
fi

# Force completion refresh for Warp terminal compatibility
if [[ "$TERM_PROGRAM" == "WarpTerminal" ]]; then
    # Ensure Warp respects custom completions
    zstyle ':completion:*' use-cache on
    zstyle ':completion:*' cache-path ~/.zsh/cache
fi
