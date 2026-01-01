#!/bin/bash

# SignalKit Documentation Website - GitHub Structure Creation Script
# This script creates all milestones and issues for the V2 documentation structure

set -e

# Configuration
REPO="Mahmoud-zino/SignalKitWebsite"

echo "================================================"
echo "GitHub Structure Creation Script"
echo "================================================"
echo ""
echo "This will create milestones and issues for:"
echo "  Repository: $REPO"
echo ""
read -p "Continue? (yes/no): " CONFIRM

if [ "$CONFIRM" != "yes" ]; then
    echo "Aborted."
    exit 1
fi

echo ""
echo "Step 1: Creating milestones..."
echo "--------------------------------------------"

# Create milestones (returns milestone number for later use)
echo "Creating: Phase 0: Cleanup & Preparation..."
M0=$(gh api repos/$REPO/milestones -f title="Phase 0: Cleanup & Preparation" -f description="Remove old pages and prepare structure for V2" -f due_on="2026-01-03T00:00:00Z" --jq '.number')

echo "Creating: Phase 1-2: Landing & Core..."
M1=$(gh api repos/$REPO/milestones -f title="Phase 1-2: Landing & Core" -f description="Fix landing page and create Why SignalKit page" -f due_on="2026-01-08T00:00:00Z" --jq '.number')

echo "Creating: Phase 3: Channel Pages..."
M3=$(gh api repos/$REPO/milestones -f title="Phase 3: Channel Pages" -f description="Create all 15 channel type pages with examples" -f due_on="2026-01-24T00:00:00Z" --jq '.number')

echo "Creating: Phase 4: Advanced Features..."
M4=$(gh api repos/$REPO/milestones -f title="Phase 4: Advanced Features" -f description="Create all 13 advanced feature pages" -f due_on="2026-02-07T00:00:00Z" --jq '.number')

echo "Creating: Phase 5: Editor Tools..."
M5=$(gh api repos/$REPO/milestones -f title="Phase 5: Editor Tools" -f description="Create editor tools documentation pages" -f due_on="2026-02-14T00:00:00Z" --jq '.number')

echo "Creating: Phase 6: Integrations..."
M6=$(gh api repos/$REPO/milestones -f title="Phase 6: Integrations" -f description="Create integration documentation pages" -f due_on="2026-02-21T00:00:00Z" --jq '.number')

echo "Creating: Phase 7-8: Navigation & Search..."
M7=$(gh api repos/$REPO/milestones -f title="Phase 7-8: Navigation & Search" -f description="Implement collapsible navigation and search" -f due_on="2026-02-28T00:00:00Z" --jq '.number')

echo "✅ All milestones created."

echo ""
echo "Step 2: Creating labels..."
echo "--------------------------------------------"

# Create labels (ignore errors if they already exist)
gh label create "phase-0-cleanup" --repo "$REPO" --color "d73a4a" --description "Phase 0: Cleanup tasks" || true
gh label create "phase-1-landing" --repo "$REPO" --color "0075ca" --description "Phase 1-2: Landing & Core" || true
gh label create "phase-3-channels" --repo "$REPO" --color "cfd3d7" --description "Phase 3: Channel pages" || true
gh label create "phase-4-features" --repo "$REPO" --color "a2eeef" --description "Phase 4: Advanced features" || true
gh label create "phase-5-editor" --repo "$REPO" --color "7057ff" --description "Phase 5: Editor tools" || true
gh label create "phase-6-integrations" --repo "$REPO" --color "008672" --description "Phase 6: Integrations" || true
gh label create "phase-7-nav" --repo "$REPO" --color "d876e3" --description "Phase 7-8: Navigation & Search" || true
gh label create "documentation" --repo "$REPO" --color "0075ca" --description "Documentation" || true
gh label create "enhancement" --repo "$REPO" --color "a2eeef" --description "Enhancement" || true

echo "✅ All labels created."

echo ""
echo "Step 3: Creating issues..."
echo "--------------------------------------------"

# Phase 0: Cleanup (4 issues)
echo "Creating Phase 0 issues..."
gh issue create --repo "$REPO" --title "Delete obsolete documentation pages" \
  --body "Remove the following pages:
- /src/routes/docs/core-concepts/+page.md
- /src/routes/docs/channels/+page.md
- /src/routes/docs/listeners/+page.md
- /src/routes/docs/events/+page.md

These are being replaced with feature-focused pages in the new structure." \
  --milestone "$M0" --label "phase-0-cleanup,documentation"

gh issue create --repo "$REPO" --title "Update navigation structure" \
  --body "Update /src/routes/+layout.svelte to:
- Remove references to deleted pages
- Prepare for new collapsible navigation structure" \
  --milestone "$M0" --label "phase-0-cleanup,documentation"

gh issue create --repo "$REPO" --title "Create directory structure for new pages" \
  --body "Create the following directory structure:
- /src/routes/docs/channels/
- /src/routes/docs/features/
- /src/routes/docs/editor-tools/
- /src/routes/docs/integrations/" \
  --milestone "$M0" --label "phase-0-cleanup,documentation"

gh issue create --repo "$REPO" --title "Update Planning repository with new structure" \
  --body "Update planning files to reflect the new feature-driven approach." \
  --milestone "$M0" --label "phase-0-cleanup,documentation"

# Phase 1-2: Landing & Core (2 issues)
echo "Creating Phase 1-2 issues..."
gh issue create --repo "$REPO" --title "Fix landing page hero diagram" \
  --body "The current Mermaid diagram is too small and hard to read. Replace with a better visual solution." \
  --milestone "$M1" --label "phase-1-landing,enhancement"

gh issue create --repo "$REPO" --title "Create Why SignalKit comparison page" \
  --body "Create /src/routes/docs/why-signalkit/+page.md with:
- Problem/solution format
- Comparison: SignalKit vs C# Events
- Comparison: SignalKit vs UnityEvents
- Comparison: vs other event systems
- Decision guide: When to use SignalKit" \
  --milestone "$M1" --label "phase-1-landing,documentation"

# Phase 3: Channel Pages (15 issues)
echo "Creating Phase 3 issues..."
CHANNELS=("void" "bool" "int" "float" "double" "string" "vector2" "vector2int" "vector3" "vector3int" "quaternion" "color" "gameobject" "transform" "custom")
CHANNEL_NAMES=("Void" "Bool" "Int" "Float" "Double" "String" "Vector2" "Vector2Int" "Vector3" "Vector3Int" "Quaternion" "Color" "GameObject" "Transform" "Custom")

for i in "${!CHANNELS[@]}"; do
  SLUG="${CHANNELS[$i]}"
  NAME="${CHANNEL_NAMES[$i]}"

  if [ "$SLUG" == "custom" ]; then
    TITLE="Create Custom Channels guide"
    BODY="Create /src/routes/docs/channels/custom/+page.md explaining how to create custom signal channels."
  else
    TITLE="Create ${NAME} Signal Channel page"
    BODY="Create /src/routes/docs/channels/${SLUG}/+page.md with:
- Description and use cases for ${NAME}SignalChannel
- Complete Unity code example
- Interactive browser example
- Common patterns
- Best practices"
  fi

  gh issue create --repo "$REPO" --title "$TITLE" --body "$BODY" \
    --milestone "$M3" --label "phase-3-channels,documentation"
done

# Phase 4: Advanced Features (13 issues)
echo "Creating Phase 4 issues..."
FEATURES=("priority" "filters" "one-shot" "delayed" "buffered" "throttling" "batching" "async" "pooling" "thread-safety" "weak-refs" "groups" "lifecycle")
FEATURE_NAMES=("Priority System" "Filters" "One-Shot Listeners" "Delayed Raising" "Buffered Subscriptions" "Event Throttling" "Event Batching" "Async/Await Support" "Object Pooling" "Thread Safety" "Weak References" "Signal Groups" "Listener Lifecycle")

for i in "${!FEATURES[@]}"; do
  SLUG="${FEATURES[$i]}"
  NAME="${FEATURE_NAMES[$i]}"

  gh issue create --repo "$REPO" --title "Create ${NAME} page" \
    --body "Create /src/routes/docs/features/${SLUG}/+page.md with:
- What it does
- When to use it
- Unity example
- Interactive example (if applicable)
- Performance considerations" \
    --milestone "$M4" --label "phase-4-features,documentation"
done

# Phase 5: Editor Tools (4 issues)
echo "Creating Phase 5 issues..."
TOOLS=("inspector" "debugger" "codegen" "recording")
TOOL_NAMES=("Inspector Features" "Debugger Window" "Code Generation" "Recording & Playback")

for i in "${!TOOLS[@]}"; do
  SLUG="${TOOLS[$i]}"
  NAME="${TOOL_NAMES[$i]}"

  gh issue create --repo "$REPO" --title "Create ${NAME} page" \
    --body "Create /src/routes/docs/editor-tools/${SLUG}/+page.md with:
- Feature overview
- Screenshots/GIFs from Unity
- Usage examples
- Tips and tricks" \
    --milestone "$M5" --label "phase-5-editor,documentation"
done

# Phase 6: Integrations (6 issues)
echo "Creating Phase 6 issues..."
INTEGRATIONS=("unityevent" "input-system" "timeline" "animator" "addressables" "analytics")
INTEGRATION_NAMES=("UnityEvent Integration" "Input System" "Timeline" "Animator" "Addressables" "Analytics Hooks")

for i in "${!INTEGRATIONS[@]}"; do
  SLUG="${INTEGRATIONS[$i]}"
  NAME="${INTEGRATION_NAMES[$i]}"

  gh issue create --repo "$REPO" --title "Create ${NAME} page" \
    --body "Create /src/routes/docs/integrations/${SLUG}/+page.md with:
- Integration setup
- Unity example
- Common patterns" \
    --milestone "$M6" --label "phase-6-integrations,documentation"
done

# Phase 7-8: Navigation & Search (2 issues)
echo "Creating Phase 7-8 issues..."
gh issue create --repo "$REPO" --title "Implement collapsible navigation groups" \
  --body "Update sidebar navigation to support collapsible groups:
- Create NavGroup component
- Add expand/collapse functionality
- Persist state in localStorage
- Add icons for each section" \
  --milestone "$M7" --label "phase-7-nav,enhancement"

gh issue create --repo "$REPO" --title "Implement search functionality" \
  --body "Add search functionality with keyword matching:
- Create Search component
- Create search index JSON
- Implement fuzzy matching
- Add Ctrl+K / Cmd+K keyboard shortcut
- Show dropdown with results
- Highlight matched keywords" \
  --milestone "$M7" --label "phase-7-nav,enhancement"

echo "✅ All issues created."

echo ""
echo "================================================"
echo "✅ GitHub Structure Creation Complete!"
echo "================================================"
echo ""
echo "Summary:"
echo "  - 7 milestones created"
echo "  - 9 labels created"
echo "  - 46 issues created"
echo ""
echo "View your GitHub project:"
echo "  https://github.com/$REPO/issues"
echo "  https://github.com/$REPO/milestones"
echo ""
