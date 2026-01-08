# Vector3 Signal Channel

**Vector3SignalChannel** broadcasts 3D position and direction data - perfect for character positions, spawn points, movement directions, and any 3D game data.

## When to Use Vector3 Signals

Use Vector3SignalChannel when you need to broadcast 3D position or direction data:

- **3D Positions** - Character positions, spawn points, waypoints, target locations
- **Movement Directions** - Look direction, velocity, force direction
- **Spawn Points** - Enemy spawn locations, item drop positions
- **Camera Tracking** - Focus points, orbit targets, look-at positions
- **Physics Forces** - Impact points, force directions, explosion origins

## Code Example

**Raising a Vector3 signal:**

```csharp
using UnityEngine;
using SignalKit.Runtime.Core.Channels;

[SerializeField] private Vector3SignalChannel onPlayerMoved;

// Raise the signal with a Vector3 value
onPlayerMoved.Raise(transform.position);
onPlayerMoved.Raise(new Vector3(10f, 5f, 20f));
```

**Listening to a Vector3 signal:**

```csharp
using UnityEngine;
using SignalKit.Runtime.Core.Channels;

[SerializeField] private Vector3SignalChannel onPlayerMoved;

private void OnEnable()
{
    onPlayerMoved.OnRaised += UpdateCameraTarget;
}

private void OnDisable()
{
    onPlayerMoved.OnRaised -= UpdateCameraTarget;
}

private void UpdateCameraTarget(Vector3 position)
{
    cameraTarget = position;
}
```

## Best Practices

### Do:
- **Use descriptive names** - `OnPlayerPositionChanged` is clearer than `Vector3Signal`
- **Document coordinate space** - World space, local space, or screen space?
- **Normalize for directions** - Use `.normalized` for direction vectors
- **Consider distance** - Use `Vector3.Distance()` for proximity checks

### Don't:
- **Don't use for every frame** - Vector3 signals have overhead; avoid `Update()` raises
- **Don't use for 2D games** - Use `Vector2SignalChannel` for 2D positions
- **Don't forget to normalize directions** - Movement/look directions should be unit vectors
- **Don't use for grid coordinates** - Use `Vector3IntSignalChannel` for voxel/grid positions

## When NOT to Use Vector3 Signals

Vector3 signals aren't appropriate when:

- **You need voxel/grid coordinates** - Use `Vector3IntSignalChannel` for integer positions
- **You need 2D positions** - Use `Vector2SignalChannel` instead
- **Updates every frame** - Use direct property access or `Update()` instead
- **No data is needed** - Use `VoidSignalChannel` for simple events

## Common Patterns

**Pattern 1: Spawn Position**

```csharp
[SerializeField] private Vector3SignalChannel onEnemySpawned;

// Publisher
public void SpawnEnemy()
{
    Vector3 spawnPos = GetRandomSpawnPoint();
    onEnemySpawned.Raise(spawnPos);
}

// Listener
private void HandleEnemySpawn(Vector3 position)
{
    Instantiate(enemyPrefab, position, Quaternion.identity);
}
```

**Pattern 2: Camera Follow**

```csharp
[SerializeField] private Vector3SignalChannel onPlayerPositionChanged;

// Publisher
private void Update()
{
    if (transform.hasChanged)
    {
        onPlayerPositionChanged.Raise(transform.position);
        transform.hasChanged = false;
    }
}

// Listener
private void FollowPlayer(Vector3 playerPos)
{
    Vector3 offset = new Vector3(0, 5, -10);
    transform.position = playerPos + offset;
}
```

**Pattern 3: Waypoint System**

```csharp
[SerializeField] private Vector3SignalChannel onWaypointReached;

// Broadcast each waypoint as AI reaches it
private void OnReachedWaypoint(Vector3 waypoint)
{
    onWaypointReached.Raise(waypoint);
}

// Listener updates minimap or UI
private void UpdateWaypointUI(Vector3 waypoint)
{
    minimapMarker.position = waypoint;
}
```

**Pattern 4: Impact Point**

```csharp
[SerializeField] private Vector3SignalChannel onProjectileHit;

// Publisher
private void OnCollisionEnter(Collision collision)
{
    Vector3 hitPoint = collision.contacts[0].point;
    onProjectileHit.Raise(hitPoint);
}

// Listener spawns VFX
private void SpawnImpactEffect(Vector3 position)
{
    Instantiate(impactEffect, position, Quaternion.identity);
}
```

## Related Channels

When Vector3 isn't quite right:

- [**Vector3Int Signal**](/docs/channels/vector3int) - For voxel/grid coordinates (integers)
- [**Vector2 Signal**](/docs/channels/vector2) - For 2D positions
- [**Transform Signal**](/docs/channels/transform) - For complete transform references

## Next Steps

- [**Vector3Int Signals**](/docs/channels/vector3int) - Learn about integer 3D coordinates
- [**All Channel Types**](/docs/channels) - Explore all 15 signal channels
