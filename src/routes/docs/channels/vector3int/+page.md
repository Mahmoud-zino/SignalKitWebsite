# Vector3Int Signal Channel

**Vector3IntSignalChannel** broadcasts 3D integer position data - perfect for voxel games, 3D grids, chunk coordinates, and any 3D data requiring whole number coordinates.

## When to Use Vector3Int Signals

Use Vector3IntSignalChannel when you need to broadcast 3D integer coordinates:

- **Voxel Coordinates** - Block positions in voxel games (Minecraft-style)
- **3D Grid Positions** - Grid-based 3D movement, tactical games
- **Chunk Coordinates** - World chunk positions, terrain sections
- **Building Systems** - Snap-to-grid building, construction placement
- **Inventory Volumes** - 3D inventory systems, cargo holds

## Code Example

**Raising a Vector3Int signal:**

```csharp
using UnityEngine;
using SignalKit.Runtime.Core.Channels;

[SerializeField] private Vector3IntSignalChannel onBlockPlaced;

// Raise the signal with a Vector3Int value
onBlockPlaced.Raise(new Vector3Int(5, 10, 3));
```

**Listening to a Vector3Int signal:**

```csharp
using UnityEngine;
using SignalKit.Runtime.Core.Channels;

[SerializeField] private Vector3IntSignalChannel onBlockPlaced;

private void OnEnable()
{
    onBlockPlaced.OnRaised += UpdateBlock;
}

private void OnDisable()
{
    onBlockPlaced.OnRaised -= UpdateBlock;
}

private void UpdateBlock(Vector3Int blockPos)
{
    Debug.Log($"Block placed at: ({blockPos.x}, {blockPos.y}, {blockPos.z})");
}
```

## Best Practices

### Do:
- **Use descriptive names** - `OnBlockPlaced` is clearer than `Vector3IntSignal`
- **Document coordinate system** - Origin position, axis orientation, grid size
- **Validate bounds** - Check if coordinates are within valid world/chunk range
- **Use for grid-based 3D** - Perfect for voxels, chunks, grid navigation

### Don't:
- **Don't use for every frame** - Vector3Int signals have overhead; avoid `Update()` raises
- **Don't use for smooth positions** - Use `Vector3SignalChannel` for float coordinates
- **Don't forget bounds checking** - Validate coordinates are within world limits
- **Don't use for 2D grids** - Use `Vector2IntSignalChannel` for 2D tile coordinates

## When NOT to Use Vector3Int Signals

Vector3Int signals aren't appropriate when:

- **You need smooth/decimal positions** - Use `Vector3SignalChannel` for floats
- **You need 2D grid coordinates** - Use `Vector2IntSignalChannel` instead
- **Updates every frame** - Use direct property access or `Update()` instead
- **No data is needed** - Use `VoidSignalChannel` for simple events

## Common Patterns

**Pattern 1: Voxel Block Placement**

```csharp
[SerializeField] private Vector3IntSignalChannel onBlockPlaced;
[SerializeField] private Vector3IntSignalChannel onBlockDestroyed;

// Publisher
public void PlaceBlock(Vector3 worldPos)
{
    Vector3Int gridPos = WorldToGridPosition(worldPos);
    onBlockPlaced.Raise(gridPos);
}

// Listener
private void HandleBlockPlaced(Vector3Int gridPos)
{
    voxelWorld.SetBlock(gridPos, blockType);
}
```

**Pattern 2: Chunk Loading**

```csharp
[SerializeField] private Vector3IntSignalChannel onChunkRequested;

// Publisher
private void RequestChunk(Vector3Int chunkPos)
{
    onChunkRequested.Raise(chunkPos);
}

// Listener
private void LoadChunk(Vector3Int chunkPos)
{
    if (!loadedChunks.ContainsKey(chunkPos))
    {
        StartCoroutine(GenerateChunk(chunkPos));
    }
}
```

**Pattern 3: 3D Grid Navigation**

```csharp
[SerializeField] private Vector3IntSignalChannel onGridCellEntered;

// Publisher
private void Update()
{
    Vector3Int currentCell = GetCurrentGridCell();
    if (currentCell != lastCell)
    {
        lastCell = currentCell;
        onGridCellEntered.Raise(currentCell);
    }
}

// Listener
private void UpdateNavigationUI(Vector3Int gridPos)
{
    coordinateDisplay.text = $"Grid: {gridPos}";
}
```

**Pattern 4: Building System**

```csharp
[SerializeField] private Vector3IntSignalChannel onBuildingPlaced;

// Publisher
public void PlaceBuilding(Vector3 position)
{
    Vector3Int gridPos = SnapToGrid(position);
    if (IsValidPlacement(gridPos))
    {
        onBuildingPlaced.Raise(gridPos);
    }
}

// Listener
private void CreateBuilding(Vector3Int gridPos)
{
    Vector3 worldPos = GridToWorldPosition(gridPos);
    Instantiate(buildingPrefab, worldPos, Quaternion.identity);
}
```

## Related Channels

When Vector3Int isn't quite right:

- [**Vector3 Signal**](/docs/channels/vector3) - For smooth/float 3D positions
- [**Vector2Int Signal**](/docs/channels/vector2int) - For 2D grid coordinates
- [**Int Signal**](/docs/channels/int) - For single-axis integer values

## Next Steps

- [**Quaternion Signals**](/docs/channels/quaternion) - Learn about rotation signals
- [**All Channel Types**](/docs/channels) - Explore all 15 signal channels
