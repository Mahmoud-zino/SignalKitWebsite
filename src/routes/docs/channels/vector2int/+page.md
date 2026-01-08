# Vector2Int Signal Channel

**Vector2IntSignalChannel** broadcasts 2D integer position data - perfect for grid-based games, tile coordinates, inventory slots, and any 2D data requiring whole number coordinates.

## When to Use Vector2Int Signals

Use Vector2IntSignalChannel when you need to broadcast 2D integer coordinates:

- **Grid Positions** - Tile coordinates, grid-based movement
- **Inventory Slots** - Item positions in inventory grids
- **Board Games** - Chess positions, card positions, board coordinates
- **Tilemap Coordinates** - Selected tiles, hover positions
- **Pixel-Perfect Positioning** - UI elements on pixel grids

## Code Example

**Raising a Vector2Int signal:**

```csharp
using UnityEngine;
using SignalKit.Runtime.Core.Channels;

[SerializeField] private Vector2IntSignalChannel onTileSelected;

// Raise the signal with a Vector2Int value
onTileSelected.Raise(new Vector2Int(5, 3));
```

**Listening to a Vector2Int signal:**

```csharp
using UnityEngine;
using SignalKit.Runtime.Core.Channels;

[SerializeField] private Vector2IntSignalChannel onTileSelected;

private void OnEnable()
{
    onTileSelected.OnRaised += HighlightTile;
}

private void OnDisable()
{
    onTileSelected.OnRaised -= HighlightTile;
}

private void HighlightTile(Vector2Int tilePos)
{
    Debug.Log($"Tile selected at: ({tilePos.x}, {tilePos.y})");
}
```

## Best Practices

### Do:
- **Use descriptive names** - `OnTileSelected` is clearer than `Vector2IntSignal`
- **Document coordinate system** - Origin position, axis directions (e.g., (0,0) = bottom-left)
- **Validate bounds** - Check if coordinates are within valid grid range
- **Use for grid-based systems** - Perfect for tilemaps, board games, inventory

### Don't:
- **Don't use for every frame** - Vector2Int signals have overhead; avoid `Update()` raises
- **Don't use for smooth positions** - Use `Vector2SignalChannel` for float coordinates
- **Don't forget bounds checking** - Validate coordinates are within grid limits
- **Don't use for 3D grids** - Use `Vector3IntSignalChannel` for voxel/3D grids

## When NOT to Use Vector2Int Signals

Vector2Int signals aren't appropriate when:

- **You need smooth/decimal positions** - Use `Vector2SignalChannel` for floats
- **You need 3D grid coordinates** - Use `Vector3IntSignalChannel` instead
- **Updates every frame** - Use direct property access or `Update()` instead
- **No data is needed** - Use `VoidSignalChannel` for simple events

## Common Patterns

**Pattern 1: Grid Selection**

```csharp
[SerializeField] private Vector2IntSignalChannel onGridCellSelected;

private void Update()
{
    if (Input.GetMouseButtonDown(0))
    {
        Vector2Int gridPos = ScreenToGridPosition(Input.mousePosition);
        onGridCellSelected.Raise(gridPos);
    }
}
```

**Pattern 2: Tile Hover System**

```csharp
[SerializeField] private Vector2IntSignalChannel onTileHovered;

// Publisher
private void Update()
{
    Vector2Int tilePos = GetTileUnderMouse();
    if (tilePos != lastHoveredTile)
    {
        lastHoveredTile = tilePos;
        onTileHovered.Raise(tilePos);
    }
}

// Listener
private void ShowTileInfo(Vector2Int tilePos)
{
    infoPanel.SetText($"Tile: ({tilePos.x}, {tilePos.y})");
}
```

**Pattern 3: Inventory System**

```csharp
[SerializeField] private Vector2IntSignalChannel onInventorySlotClicked;

// Publisher
public void OnSlotClicked(int x, int y)
{
    onInventorySlotClicked.Raise(new Vector2Int(x, y));
}

// Listener
private void HandleSlotClick(Vector2Int slotPos)
{
    Item item = inventory.GetItemAt(slotPos.x, slotPos.y);
    if (item != null)
        ShowItemTooltip(item);
}
```

**Pattern 4: Pathfinding Waypoints**

```csharp
[SerializeField] private Vector2IntSignalChannel onWaypointReached;

// Broadcast each grid cell reached during pathfinding
private void MoveToNextWaypoint()
{
    Vector2Int currentCell = GetCurrentGridCell();
    onWaypointReached.Raise(currentCell);
}
```

## Related Channels

When Vector2Int isn't quite right:

- [**Vector2 Signal**](/docs/channels/vector2) - For smooth/float positions
- [**Vector3Int Signal**](/docs/channels/vector3int) - For 3D grid coordinates
- [**Int Signal**](/docs/channels/int) - For single-axis integer values

## Next Steps

- [**Vector3 Signals**](/docs/channels/vector3) - Learn about 3D position signals
- [**All Channel Types**](/docs/channels) - Explore all 15 signal channels
