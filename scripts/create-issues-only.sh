#!/bin/bash

# Create issues only (milestones already exist)
set -e

REPO="Mahmoud-zino/SignalKitWebsite"

# Milestone titles (already created)
M0="Phase 0: Cleanup & Preparation"
M1="Phase 1-2: Landing & Core"
M3="Phase 3: Channel Pages"
M4="Phase 4: Advanced Features"
M5="Phase 5: Editor Tools"
M6="Phase 6: Integrations"
M7="Phase 7-8: Navigation & Search"

echo "Creating 46 issues across 7 milestones..."
echo ""

# Phase 0: Cleanup (4 issues)
echo "Creating Phase 0 issues (4)..."
gh issue create --repo "$REPO" --title "Delete obsolete documentation pages" \
  --body "Remove the following pages:
- /src/routes/docs/core-concepts/+page.md
- /src/routes/docs/channels/+page.md
- /src/routes/docs/listeners/+page.md
- /src/routes/docs/events/+page.md" \
  --milestone "$M0" --label "phase-0-cleanup,documentation"

gh issue create --repo "$REPO" --title "Update navigation structure" \
  --body "Update /src/routes/+layout.svelte to remove references to deleted pages" \
  --milestone "$M0" --label "phase-0-cleanup,documentation"

gh issue create --repo "$REPO" --title "Create directory structure for new pages" \
  --body "Create directories: channels/, features/, editor-tools/, integrations/" \
  --milestone "$M0" --label "phase-0-cleanup,documentation"

gh issue create --repo "$REPO" --title "Update Planning repository" \
  --body "Update planning files to reflect new structure" \
  --milestone "$M0" --label "phase-0-cleanup,documentation"

# Phase 1-2: Landing & Core (2 issues)
echo "Creating Phase 1-2 issues (2)..."
gh issue create --repo "$REPO" --title "Fix landing page hero diagram" \
  --body "Replace Mermaid diagram with better visual" \
  --milestone "$M1" --label "phase-1-landing,enhancement"

gh issue create --repo "$REPO" --title "Create Why SignalKit page" \
  --body "Create /docs/why-signalkit with comparisons and decision guide" \
  --milestone "$M1" --label "phase-1-landing,documentation"

# Phase 3: Channel Pages (15 issues)
echo "Creating Phase 3 issues (15)..."
CHANNELS=("void" "bool" "int" "float" "double" "string" "vector2" "vector2int" "vector3" "vector3int" "quaternion" "color" "gameobject" "transform" "custom")
CHANNEL_NAMES=("Void" "Bool" "Int" "Float" "Double" "String" "Vector2" "Vector2Int" "Vector3" "Vector3Int" "Quaternion" "Color" "GameObject" "Transform" "Custom")

for i in "${!CHANNELS[@]}"; do
  SLUG="${CHANNELS[$i]}"
  NAME="${CHANNEL_NAMES[$i]}"

  if [ "$SLUG" == "custom" ]; then
    TITLE="Create Custom Channels guide"
  else
    TITLE="Create ${NAME} Signal Channel page"
  fi

  gh issue create --repo "$REPO" --title "$TITLE" \
    --body "Create /docs/channels/${SLUG} with examples" \
    --milestone "$M3" --label "phase-3-channels,documentation"
done

# Phase 4: Advanced Features (13 issues)
echo "Creating Phase 4 issues (13)..."
FEATURES=("priority" "filters" "one-shot" "delayed" "buffered" "throttling" "batching" "async" "pooling" "thread-safety" "weak-refs" "groups" "lifecycle")
FEATURE_NAMES=("Priority System" "Filters" "One-Shot Listeners" "Delayed Raising" "Buffered Subscriptions" "Event Throttling" "Event Batching" "Async/Await" "Object Pooling" "Thread Safety" "Weak References" "Signal Groups" "Listener Lifecycle")

for i in "${!FEATURES[@]}"; do
  SLUG="${FEATURES[$i]}"
  NAME="${FEATURE_NAMES[$i]}"

  gh issue create --repo "$REPO" --title "Create ${NAME} page" \
    --body "Create /docs/features/${SLUG} with examples" \
    --milestone "$M4" --label "phase-4-features,documentation"
done

# Phase 5: Editor Tools (4 issues)
echo "Creating Phase 5 issues (4)..."
TOOLS=("inspector" "debugger" "codegen" "recording")
TOOL_NAMES=("Inspector Features" "Debugger Window" "Code Generation" "Recording & Playback")

for i in "${!TOOLS[@]}"; do
  SLUG="${TOOLS[$i]}"
  NAME="${TOOL_NAMES[$i]}"

  gh issue create --repo "$REPO" --title "Create ${NAME} page" \
    --body "Create /docs/editor-tools/${SLUG} with screenshots" \
    --milestone "$M5" --label "phase-5-editor,documentation"
done

# Phase 6: Integrations (6 issues)
echo "Creating Phase 6 issues (6)..."
INTEGRATIONS=("unityevent" "input-system" "timeline" "animator" "addressables" "analytics")
INTEGRATION_NAMES=("UnityEvent Integration" "Input System" "Timeline" "Animator" "Addressables" "Analytics Hooks")

for i in "${!INTEGRATIONS[@]}"; do
  SLUG="${INTEGRATIONS[$i]}"
  NAME="${INTEGRATION_NAMES[$i]}"

  gh issue create --repo "$REPO" --title "Create ${NAME} page" \
    --body "Create /docs/integrations/${SLUG} with integration guide" \
    --milestone "$M6" --label "phase-6-integrations,documentation"
done

# Phase 7-8: Navigation & Search (2 issues)
echo "Creating Phase 7-8 issues (2)..."
gh issue create --repo "$REPO" --title "Implement collapsible navigation" \
  --body "Add collapsible navigation groups to sidebar" \
  --milestone "$M7" --label "phase-7-nav,enhancement"

gh issue create --repo "$REPO" --title "Implement search functionality" \
  --body "Add search with keyword matching and Ctrl+K shortcut" \
  --milestone "$M7" --label "phase-7-nav,enhancement"

echo ""
echo "✅ All 46 issues created!"
echo "View at: https://github.com/$REPO/issues"
