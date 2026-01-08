# Void Signal Channel

**VoidSignalChannel** is the simplest signal type - it broadcasts events without any data. Perfect for simple notifications where the event itself is all the information you need.

## When to Use Void Signals

Use VoidSignalChannel when you need to notify multiple systems that something happened, without passing any data:

- **Button Clicks** - UI button pressed, no data needed
- **Game Events** - Level complete, game over, pause triggered
- **Simple Triggers** - Door opened, checkpoint reached, item collected
- **Notifications** - Any event where you only care that it happened

## Code Example

**Raising a void signal:**

```csharp
using SignalKit.Runtime.Core.Channels;

[SerializeField] private VoidSignalChannel onCheckpointReached;

// Just raise the signal - no data needed
onCheckpointReached.Raise();
```

**Listening to a void signal:**

```csharp
using SignalKit.Runtime.Core;
using SignalKit.Runtime.Core.Channels;

[SerializeField] private VoidSignalChannel onCheckpointReached;

private void OnEnable()
{
    onCheckpointReached.OnRaised += HandleCheckpoint;
}

private void OnDisable()
{
    onCheckpointReached.OnRaised -= HandleCheckpoint;
}

private void HandleCheckpoint(Unit unit)
{
    // Unit parameter required but not used
    Debug.Log("Checkpoint reached!");
}
```

> [!NOTE]
> VoidSignalChannel uses a `Unit` parameter in listener methods. `Unit` is a functional programming concept representing "no value" - you must include it in your method signature, but you won't use it.

## Best Practices

### Do:
- **Use descriptive names** - `OnCheckpointReached` clearly describes what happened
- **Subscribe in OnEnable** - Prevents memory leaks with automatic cleanup
- **Unsubscribe in OnDisable** - Always clean up event subscriptions
- **Use for discrete events** - One-time or occasional events, not continuous updates

### Don't:
- **Don't raise every frame** - Void signals have overhead; use for discrete events only
- **Don't use when you need data** - If you need to pass values, use a typed signal instead
- **Don't forget to unsubscribe** - Memory leaks will occur if you don't clean up
- **Don't create signals at runtime** - Use ScriptableObject assets created in the editor

## When NOT to Use Void Signals

Void signals aren't appropriate when:

- **You need to pass data** - Use `IntSignalChannel`, `FloatSignalChannel`, `StringSignalChannel`, etc.
- **You need return values** - Signals are fire-and-forget; use direct method calls instead
- **Events fire every frame** - Use `Update()` or Unity's built-in events for high-frequency updates

## Common Patterns

**Pattern 1: One Event, Many Listeners**

```csharp
// One button raises the signal
onGamePaused.Raise();

// Multiple systems respond:
// - GameManager pauses gameplay
// - UIManager shows pause menu
// - AudioManager pauses music
```

**Pattern 2: Multiple Publishers**

```csharp
// Different sources can raise the same signal
onGameOver.Raise(); // From player death
onGameOver.Raise(); // From time expired

// All listeners respond the same way
```

## Related Channels

When you need to pass data with your events:

- [**Bool Signal**](/docs/channels/bool) - For on/off states and toggles
- [**Int Signal**](/docs/channels/int) - For counts, scores, and IDs
- [**String Signal**](/docs/channels/string) - For messages and identifiers

## Next Steps

- [**Bool Signals**](/docs/channels/bool) - Learn about boolean signals
- [**All Channel Types**](/docs/channels) - Explore all 15 signal channels
