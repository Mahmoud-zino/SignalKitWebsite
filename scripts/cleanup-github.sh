#!/bin/bash

# SignalKit Documentation Website - GitHub Cleanup Script
# This script deletes all existing issues and milestones
# WARNING: This action cannot be undone!

set -e

# Configuration
REPO="Mahmoud-zino/SignalKitWebsite"

echo "================================================"
echo "GitHub Cleanup Script for SignalKit Docs"
echo "================================================"
echo ""
echo "This will DELETE ALL issues and milestones from:"
echo "  Repository: $REPO"
echo ""
read -p "Are you sure you want to continue? (type 'yes' to confirm): " CONFIRM

if [ "$CONFIRM" != "yes" ]; then
    echo "Aborted."
    exit 1
fi

echo ""
echo "Step 1: Closing and deleting all issues..."
echo "--------------------------------------------"

# Get all open issue numbers
ISSUE_NUMBERS=$(gh issue list --repo "$REPO" --limit 1000 --state open --json number --jq '.[].number')

if [ -z "$ISSUE_NUMBERS" ]; then
    echo "No open issues found."
else
    echo "Found open issues. Closing and deleting..."
    for ISSUE in $ISSUE_NUMBERS; do
        echo "  Deleting issue #$ISSUE..."
        gh issue delete "$ISSUE" --repo "$REPO" --yes
    done
    echo "✅ All open issues deleted."
fi

# Check for closed issues
CLOSED_COUNT=$(gh issue list --repo "$REPO" --limit 1 --state closed --json number --jq 'length')
if [ "$CLOSED_COUNT" -gt 0 ]; then
    echo ""
    echo "⚠️  Note: There are closed issues in the repository."
    echo "   GitHub doesn't allow deleting closed issues via CLI."
    echo "   You can manually delete them from the web UI if needed."
fi

echo ""
echo "Step 2: Deleting all milestones..."
echo "--------------------------------------------"

# Get all milestone numbers
MILESTONES=$(gh api "repos/$REPO/milestones" --jq '.[].number')

if [ -z "$MILESTONES" ]; then
    echo "No milestones found."
else
    echo "Found milestones. Deleting..."
    for MILESTONE in $MILESTONES; do
        MILESTONE_TITLE=$(gh api "repos/$REPO/milestones/$MILESTONE" --jq '.title')
        echo "  Deleting milestone #$MILESTONE: $MILESTONE_TITLE..."
        gh api -X DELETE "repos/$REPO/milestones/$MILESTONE"
    done
    echo "✅ All milestones deleted."
fi

echo ""
echo "================================================"
echo "✅ Cleanup Complete!"
echo "================================================"
echo ""
echo "Next steps:"
echo "  1. Run ./create-github-structure.sh to create new milestones and issues"
echo ""
