# Transform Signal Channel

**TransformSignalChannel** broadcasts Transform component references - perfect for tracking objects, following targets, parenting changes, and any situation where you need complete transform access (position, rotation, and scale).

## When to Use Transform Signals

Use TransformSignalChannel when you need to broadcast Transform references:

- **Target Tracking** - Camera follow targets, AI tracking, turret aiming
- **Parent Changes** - Object reparented, hierarchy changed, attachment updated
- **Follow Systems** - Followers, formations, chains, orbits
- **Transform References** - Anchor points, mount points, attachment sockets
- **IK Targets** - Animation IK targets, look-at targets, aim targets

## Code Example

**Raising a Transform signal:**

```csharp
using UnityEngine;
using SignalKit.Runtime.Core.Channels;

[SerializeField] private TransformSignalChannel onTargetChanged;

// Raise the signal with a Transform reference
onTargetChanged.Raise(targetObject.transform);
```

**Listening to a Transform signal:**

```csharp
using UnityEngine;
using SignalKit.Runtime.Core.Channels;

[SerializeField] private TransformSignalChannel onTargetChanged;

private void OnEnable()
{
    onTargetChanged.OnRaised += SetFollowTarget;
}

private void OnDisable()
{
    onTargetChanged.OnRaised -= SetFollowTarget;
}

private void SetFollowTarget(Transform target)
{
    followTarget = target;
}
```

## Best Practices

### Do:
- **Use descriptive names** - `OnCameraTargetChanged` is clearer than `TransformSignal`
- **Check for null** - Always validate the Transform isn't null before using it
- **Document usage** - Clarify if you need position, rotation, or both
- **Use for complete transforms** - Perfect when you need access to all transform properties

### Don't:
- **Don't use for every frame** - Transform signals have overhead; avoid `Update()` raises
- **Don't forget null checks** - Transforms may be destroyed before listeners process them
- **Don't use for position only** - Use `Vector3SignalChannel` if you only need position
- **Don't use for rotation only** - Use `QuaternionSignalChannel` if you only need rotation

## When NOT to Use Transform Signals

Transform signals aren't appropriate when:

- **You only need position** - Use `Vector3SignalChannel` instead (more efficient)
- **You only need rotation** - Use `QuaternionSignalChannel` instead
- **You need the GameObject** - Use `GameObjectSignalChannel` if you need the whole object
- **Updates every frame** - Use direct references or `Update()` instead
- **No data is needed** - Use `VoidSignalChannel` for simple events

## Common Patterns

**Pattern 1: Camera Follow Target**

```csharp
[SerializeField] private TransformSignalChannel onPlayerSpawned;

// Publisher
public void SpawnPlayer()
{
    GameObject player = Instantiate(playerPrefab);
    onPlayerSpawned.Raise(player.transform);
}

// Listener
private void SetCameraTarget(Transform target)
{
    cameraController.SetTarget(target);
}
```

**Pattern 2: AI Target Tracking**

```csharp
[SerializeField] private TransformSignalChannel onTargetAcquired;

// Publisher
private void OnTriggerEnter(Collider other)
{
    if (other.CompareTag("Player"))
    {
        onTargetAcquired.Raise(other.transform);
    }
}

// Listener
private void ChaseTarget(Transform target)
{
    currentTarget = target;
    aiState = AIState.Chasing;
}
```

**Pattern 3: Parent Change**

```csharp
[SerializeField] private TransformSignalChannel onParentChanged;

// Publisher
public void AttachToParent(Transform newParent)
{
    transform.SetParent(newParent);
    onParentChanged.Raise(newParent);
}

// Listener
private void HandleParentChange(Transform newParent)
{
    if (newParent != null)
        Debug.Log($"Attached to: {newParent.name}");
    else
        Debug.Log("Detached from parent");
}
```

**Pattern 4: IK Target System**

```csharp
[SerializeField] private TransformSignalChannel onLookAtTargetChanged;

// Publisher
public void SetLookAtTarget(Transform target)
{
    onLookAtTargetChanged.Raise(target);
}

// Listener
private void UpdateIKTarget(Transform target)
{
    headIKTarget = target;
    animator.SetLookAtWeight(1.0f);
}
```

## Related Channels

When Transform isn't quite right:

- [**GameObject Signal**](/docs/channels/gameobject) - For GameObject references
- [**Vector3 Signal**](/docs/channels/vector3) - For positions only (more efficient)
- [**Quaternion Signal**](/docs/channels/quaternion) - For rotations only

## Next Steps

- [**Custom Channels**](/docs/channels/custom) - Learn how to create custom signal channels
- [**All Channel Types**](/docs/channels) - Explore all 15 signal channels
