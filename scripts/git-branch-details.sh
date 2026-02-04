#!/bin/bash

# scripts/git-branch-details.sh (optimized version)

# Usage:
#   git-branch-details.sh           # Show local branches (default)
#   git-branch-details.sh -a        # Show all branches (local and remote)
#   git-branch-details.sh -r        # Show remote branches only
#   git-branch-details.sh -c        # Include creation date (slower)
#   git-branch-details.sh -a -c     # Flags can be combined

# Gruvbox color definitions
DARK_RED='\033[38;5;124m'
DARK_GREEN='\033[38;5;106m'
DARK_YELLOW='\033[38;5;172m'
DARK_BLUE='\033[38;5;66m'
DARK_PURPLE='\033[38;5;132m'
DARK_AQUA='\033[38;5;72m'
LIGHT_ORANGE='\033[38;5;208m'
LIGHT_GREEN='\033[38;5;142m'
LIGHT_GRAY='\033[38;5;245m'
CREAM='\033[38;5;223m'
BG_GRAY='\033[38;5;237m'
BOLD='\033[1m'
RESET='\033[0m'

# Start timing
start_time=$(date +%s)

# Parse command line arguments
mode="Local"
ref_patterns="refs/heads/"
show_created=false

while [[ $# -gt 0 ]]; do
    case "$1" in
        -a|--all)
            ref_patterns="refs/heads/ refs/remotes/"
            mode="All"
            shift
            ;;
        -r|--remote)
            ref_patterns="refs/remotes/"
            mode="Remote"
            shift
            ;;
        -c|--created)
            show_created=true
            shift
            ;;
        -h|--help)
            echo "Usage: $0 [OPTIONS]"
            echo "Options:"
            echo "  -a, --all      Show all branches (local and remote)"
            echo "  -r, --remote   Show remote branches only"
            echo "  -c, --created  Show branch creation date (slower)"
            echo "  -h, --help     Show this help message"
            echo "  (no option)    Show local branches only (default)"
            exit 0
            ;;
        *)
            shift
            ;;
    esac
done

# Header
echo -e "${DARK_AQUA}╔═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╗${RESET}"
echo -e "${BOLD}${LIGHT_ORANGE}Git Branch Details ${LIGHT_GRAY}(${mode} Branches - Sorted by Last Update)${RESET}"
echo -e "${DARK_AQUA}╚═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝${RESET}"
echo

# Get current branch
current_branch=$(git branch --show-current 2>/dev/null)

# Single git command to get all branch info, sorted by committer date (most recent first)
# Format: refname|date|relative|author
branch_count=0

while IFS='|' read -r branch updated relative author; do
    # Skip HEAD references
    [[ "$branch" == */HEAD ]] && continue

    branch_count=$((branch_count + 1))

    # Strip remote prefix for display comparison
    branch_display="$branch"
    branch_name_only="${branch#origin/}"

    # Determine if this is the current branch
    marker_display="  "
    branch_color="${CREAM}"

    if [ "$mode" != "Remote" ] && [ "$branch_name_only" = "$current_branch" ]; then
        marker_display="${BOLD}${LIGHT_ORANGE}* "
        branch_color="${BOLD}${LIGHT_GREEN}"
    fi

    # Color remote branches differently
    if [[ "$branch" == origin/* ]] || [[ "$branch" == upstream/* ]]; then
        if [ "$branch_name_only" != "$current_branch" ]; then
            branch_color="${DARK_BLUE}"
        fi
    fi

    # Color code based on relative time
    if [[ "$relative" == *"minute"* ]] || [[ "$relative" == *"hour"* ]]; then
        date_color="${LIGHT_GREEN}"
    elif [[ "$relative" == *"day"* ]] && [[ "$relative" =~ ^1\ day ]]; then
        date_color="${DARK_GREEN}"
    elif [[ "$relative" == *"days"* ]] || [[ "$relative" == *"week"* ]]; then
        date_color="${DARK_YELLOW}"
    elif [[ "$relative" == *"month"* ]]; then
        date_color="${LIGHT_ORANGE}"
    else
        date_color="${DARK_RED}"
    fi

    # Get commit count (this is still per-branch but much faster than git log --reverse)
    commits=$(git rev-list --count "$branch" 2>/dev/null || echo "?")

    # Get created date if requested (this is the slow operation)
    if $show_created; then
        created=$(git log --reverse --format="%cs" "$branch" 2>/dev/null | head -1)
        [ -z "$created" ] && created="?"
    fi

    # Truncate branch name if too long
    max_branch_len=70
    if [ ${#branch_display} -gt $max_branch_len ]; then
        prefix_len=50
        suffix_len=17
        truncated_branch="${branch_display:0:$prefix_len}...${branch_display: -$suffix_len}"
    else
        truncated_branch="$branch_display"
    fi

    # Format and display
    printf "${marker_display}"
    printf "${branch_color}%-${max_branch_len}s${RESET}  " "$truncated_branch"
    printf "${LIGHT_GRAY}│${RESET} "
    if $show_created; then
        printf "${LIGHT_GRAY}%10s ${DARK_AQUA}→${RESET} " "$created"
    fi
    printf "${date_color}%-10s %-18s${RESET} " "$updated" "($relative)"
    printf "${LIGHT_GRAY}│${RESET} "
    printf "${DARK_PURPLE}%-20.20s${RESET} " "$author"
    printf "${LIGHT_GRAY}│${RESET} "
    printf "${DARK_AQUA}%4s commits${RESET}\n" "$commits"

done < <(git for-each-ref \
    --sort=-committerdate \
    --format='%(refname:short)|%(committerdate:short)|%(committerdate:relative)|%(authorname)' \
    $ref_patterns 2>/dev/null)

# Check if any branches were found
if [ $branch_count -eq 0 ]; then
    echo -e "${LIGHT_GRAY}No ${mode,,} branches found.${RESET}"
fi

# Legend
echo
echo -e "${DARK_AQUA}╔═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╗${RESET}"
echo -e "${DARK_AQUA}║${RESET} ${LIGHT_GRAY}Legend:${RESET} ${LIGHT_GREEN}● Recent (hours)${RESET}  ${DARK_GREEN}● 1 day${RESET}  ${DARK_YELLOW}● Days/weeks${RESET}  ${LIGHT_ORANGE}● Months${RESET}  ${DARK_RED}● Older${RESET}"
if [ "$mode" != "Remote" ]; then
    echo -e "${DARK_AQUA}║${RESET}         ${BOLD}${LIGHT_ORANGE}*${RESET} ${LIGHT_GRAY}= Current branch${RESET}"
fi
if [ "$mode" = "All" ]; then
    echo -e "${DARK_AQUA}║${RESET}         ${DARK_BLUE}●${RESET} ${LIGHT_GRAY}= Remote branch${RESET}"
fi
echo -e "${DARK_AQUA}╚═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝${RESET}"

# Print elapsed time
end_time=$(date +%s)
printf "${LIGHT_GRAY}Completed in %ds${RESET}\n" $((end_time - start_time))
