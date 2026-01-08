# Quaternion Signal Channel

**QuaternionSignalChannel** broadcasts rotation data - perfect for object orientation, camera rotation, look direction, and any 3D rotation data.

## When to Use Quaternion Signals

Use QuaternionSignalChannel when you need to broadcast rotation data:

- **Object Rotation** - Character orientation, turret rotation, door swing
- **Camera Rotation** - Camera orientation, look-at rotation, orbit rotation
- **Look Direction** - Character facing, AI gaze direction, targeting
- **Animation** - Procedural rotation, IK targets, bone rotation
- **Physics** - Angular velocity, torque direction, gyroscope data

## Code Example

**Raising a quaternion signal:**

```csharp
using UnityEngine;
using SignalKit.Runtime.Core.Channels;

[SerializeField] private QuaternionSignalChannel onPlayerRotated;

// Raise the signal with a Quaternion value
onPlayerRotated.Raise(transform.rotation);
onPlayerRotated.Raise(Quaternion.Euler(0, 90, 0));
```

**Listening to a quaternion signal:**

```csharp
using UnityEngine;
using SignalKit.Runtime.Core.Channels;

[SerializeField] private QuaternionSignalChannel onPlayerRotated;

private void OnEnable()
{
    onPlayerRotated.OnRaised += UpdateCameraRotation;
}

private void OnDisable()
{
    onPlayerRotated.OnRaised -= UpdateCameraRotation;
}

private void UpdateCameraRotation(Quaternion rotation)
{
    cameraTransform.rotation = rotation;
}
```

## Best Practices

### Do:
- **Use descriptive names** - `OnPlayerRotationChanged` is clearer than `QuaternionSignal`
- **Document rotation space** - World space, local space, or relative?
- **Use for 3D rotations** - Quaternions prevent gimbal lock in 3D
- **Consider interpolation** - Use `Quaternion.Slerp()` for smooth rotation

### Don't:
- **Don't use for every frame** - Quaternion signals have overhead; avoid `Update()` raises
- **Don't use for 2D rotation** - Use `FloatSignalChannel` for single-axis Z rotation
- **Don't manually create quaternions** - Use `Quaternion.Euler()` or `Quaternion.LookRotation()`
- **Don't compare quaternions with ==** - Use `Quaternion.Angle()` for comparisons

## When NOT to Use Quaternion Signals

Quaternion signals aren't appropriate when:

- **You need 2D rotation** - Use `FloatSignalChannel` for Z-axis rotation (more efficient)
- **You need Euler angles** - Use `Vector3SignalChannel` if you prefer Euler angles
- **Updates every frame** - Use direct property access or `Update()` instead
- **No data is needed** - Use `VoidSignalChannel` for simple events

## Common Patterns

**Pattern 1: Camera Look Direction**

```csharp
[SerializeField] private QuaternionSignalChannel onCameraRotated;

// Publisher
private void Update()
{
    float mouseX = Input.GetAxis("Mouse X");
    float mouseY = Input.GetAxis("Mouse Y");

    rotation *= Quaternion.Euler(-mouseY, mouseX, 0);
    onCameraRotated.Raise(rotation);
}

// Listener
private void UpdateCameraRotation(Quaternion rotation)
{
    cameraTransform.rotation = rotation;
}
```

**Pattern 2: Turret Aiming**

```csharp
[SerializeField] private QuaternionSignalChannel onTurretRotated;

// Publisher
public void AimAt(Vector3 target)
{
    Vector3 direction = (target - transform.position).normalized;
    Quaternion targetRotation = Quaternion.LookRotation(direction);
    onTurretRotated.Raise(targetRotation);
}

// Listener
private void RotateTurret(Quaternion targetRotation)
{
    transform.rotation = Quaternion.Slerp(
        transform.rotation,
        targetRotation,
        Time.deltaTime * rotationSpeed
    );
}
```

**Pattern 3: Character Facing**

```csharp
[SerializeField] private QuaternionSignalChannel onPlayerFacingChanged;

// Publisher
private void UpdateFacing(Vector3 movementDirection)
{
    if (movementDirection != Vector3.zero)
    {
        Quaternion targetRotation = Quaternion.LookRotation(movementDirection);
        onPlayerFacingChanged.Raise(targetRotation);
    }
}

// Listener
private void UpdateIndicator(Quaternion facing)
{
    directionIndicator.rotation = facing;
}
```

**Pattern 4: Animation IK Target**

```csharp
[SerializeField] private QuaternionSignalChannel onHandRotationChanged;

// Publisher
public void SetHandRotation(Quaternion rotation)
{
    onHandRotationChanged.Raise(rotation);
}

// Listener
private void UpdateIKTarget(Quaternion rotation)
{
    ikTarget.rotation = rotation;
}
```

## Related Channels

When Quaternion isn't quite right:

- [**Vector3 Signal**](/docs/channels/vector3) - For Euler angles (if you prefer them)
- [**Float Signal**](/docs/channels/float) - For 2D rotation (Z-axis only)
- [**Transform Signal**](/docs/channels/transform) - For complete transform references

## Next Steps

- [**Color Signals**](/docs/channels/color) - Learn about color data signals
- [**All Channel Types**](/docs/channels) - Explore all 15 signal channels
