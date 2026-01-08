# Vector2 Signal Channel

**Vector2SignalChannel** broadcasts 2D position and direction data - perfect for 2D movement, joystick input, screen coordinates, and UI positioning.

## When to Use Vector2 Signals

Use Vector2SignalChannel when you need to broadcast 2D position or direction data:

- **2D Positions** - Character positions, spawn points, waypoints
- **Joystick Input** - Controller stick values, virtual joystick input
- **Screen Coordinates** - Mouse position, touch input, UI anchors
- **2D Movement** - Velocity, acceleration, wind direction
- **UI Positioning** - Panel positions, icon locations, cursor tracking

## Code Example

**Raising a Vector2 signal:**

```csharp
using UnityEngine;
using SignalKit.Runtime.Core.Channels;

[SerializeField] private Vector2SignalChannel onPlayerMoved;

// Raise the signal with a Vector2 value
onPlayerMoved.Raise(new Vector2(10.5f, 5.2f));
onPlayerMoved.Raise(transform.position); // Works with Vector3, uses x and y
```

**Listening to a Vector2 signal:**

```csharp
using UnityEngine;
using SignalKit.Runtime.Core.Channels;

[SerializeField] private Vector2SignalChannel onPlayerMoved;

private void OnEnable()
{
    onPlayerMoved.OnRaised += UpdateMinimap;
}

private void OnDisable()
{
    onPlayerMoved.OnRaised -= UpdateMinimap;
}

private void UpdateMinimap(Vector2 position)
{
    minimapIcon.anchoredPosition = position;
}
```

## Best Practices

### Do:
- **Use descriptive names** - `OnPlayerPositionChanged` is clearer than `Vector2Signal`
- **Normalize for input** - Joystick/movement input should be normalized (-1 to 1)
- **Document coordinate space** - World space, screen space, or local space?
- **Consider magnitude** - Check `vector.magnitude` for distance calculations

### Don't:
- **Don't use for every frame** - Vector2 signals have overhead; avoid `Update()` raises
- **Don't use for 3D data** - Use `Vector3SignalChannel` for 3D positions
- **Don't forget to normalize input** - Diagonal joystick input can exceed magnitude 1
- **Don't use for grid positions** - Use `Vector2IntSignalChannel` for tile/grid coordinates

## When NOT to Use Vector2 Signals

Vector2 signals aren't appropriate when:

- **You need grid/tile coordinates** - Use `Vector2IntSignalChannel` for integer positions
- **You need 3D positions** - Use `Vector3SignalChannel` instead
- **Updates every frame** - Use direct property access or `Update()` instead
- **No data is needed** - Use `VoidSignalChannel` for simple events

## Common Patterns

**Pattern 1: Joystick Input**

```csharp
[SerializeField] private Vector2SignalChannel onJoystickMoved;

private void Update()
{
    Vector2 input = new Vector2(
        Input.GetAxis("Horizontal"),
        Input.GetAxis("Vertical")
    );

    if (input.magnitude > 0.1f)
    {
        onJoystickMoved.Raise(input.normalized);
    }
}
```

**Pattern 2: Mouse/Touch Position**

```csharp
[SerializeField] private Vector2SignalChannel onPointerMoved;

private void Update()
{
    Vector2 screenPos = Input.mousePosition;
    onPointerMoved.Raise(screenPos);
}
```

**Pattern 3: Minimap Icon Tracking**

```csharp
[SerializeField] private Vector2SignalChannel onPlayerPositionChanged;

// Publisher
private void Update()
{
    onPlayerPositionChanged.Raise(transform.position);
}

// Listener
private void UpdateMinimapIcon(Vector2 worldPos)
{
    Vector2 minimapPos = WorldToMinimapPosition(worldPos);
    playerIcon.anchoredPosition = minimapPos;
}
```

**Pattern 4: Wind System**

```csharp
[SerializeField] private Vector2SignalChannel onWindChanged;

// Broadcast wind direction and strength
public void SetWind(Vector2 windVector)
{
    onWindChanged.Raise(windVector);
}

// Listener applies wind force
private void ApplyWind(Vector2 wind)
{
    rb.AddForce(wind);
}
```

## Related Channels

When Vector2 isn't quite right:

- [**Vector2Int Signal**](/docs/channels/vector2int) - For grid/tile coordinates (integers)
- [**Vector3 Signal**](/docs/channels/vector3) - For 3D positions and directions
- [**Float Signal**](/docs/channels/float) - For single-axis values

## Next Steps

- [**Vector2Int Signals**](/docs/channels/vector2int) - Learn about integer 2D coordinates
- [**All Channel Types**](/docs/channels) - Explore all 15 signal channels
