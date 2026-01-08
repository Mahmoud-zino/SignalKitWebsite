# Bool Signal Channel

**BoolSignalChannel** broadcasts boolean values (`true`/`false`) - perfect for toggles, switches, and any state that can be on or off.

## When to Use Bool Signals

Use BoolSignalChannel when you need to broadcast on/off state changes to multiple systems:

- **Toggle States** - Sound on/off, invincibility mode, god mode, debug mode
- **UI Switches** - Settings panels, checkboxes, toggle buttons
- **Conditional States** - Is grounded, is alive, is visible, is paused
- **Feature Flags** - Tutorial enabled, multiplayer active, analytics on

## Code Example

**Raising a bool signal:**

```csharp
using SignalKit.Runtime.Core.Channels;

[SerializeField] private BoolSignalChannel godModeSignal;

// Broadcast the state (true or false)
godModeSignal.Raise(true);  // Enable
godModeSignal.Raise(false); // Disable
```

**Listening to a bool signal:**

```csharp
using SignalKit.Runtime.Core.Channels;

[SerializeField] private BoolSignalChannel godModeSignal;

private void OnEnable()
{
    godModeSignal.OnRaised += HandleGodMode;
}

private void OnDisable()
{
    godModeSignal.OnRaised -= HandleGodMode;
}

private void HandleGodMode(bool enabled)
{
    if (enabled)
        Debug.Log("God mode ON!");
    else
        Debug.Log("God mode OFF!");
}
```

## Best Practices

### Do:
- **Use clear naming** - `OnSoundEnabled` is clearer than `OnSoundChanged`
- **Broadcast state, not deltas** - Send the actual state (`true`/`false`), not the change
- **Handle both states** - Always consider what happens when the signal is true AND false
- **Initialize state** - Raise the signal on `Start()` to sync all listeners with initial state

### Don't:
- **Don't assume initial state** - Always listen for the first raise or query the source
- **Don't use for frequent updates** - Bool signals have overhead; avoid frame-by-frame raises
- **Don't forget edge cases** - What happens if the signal is raised with the same value twice?
- **Don't use for multi-state** - If you need more than two states, use `IntSignalChannel` or `StringSignalChannel`

## When NOT to Use Bool Signals

Bool signals aren't appropriate when:

- **You need more than two states** - Use `IntSignalChannel` or `StringSignalChannel` for enums
- **State changes every frame** - Use direct property access or `Update()` instead
- **You need complex data** - Use custom signal channels for structs/classes
- **You need no data at all** - Use `VoidSignalChannel` for simple events

## Common Patterns

**Pattern 1: Toggle Button**

```csharp
using UnityEngine.UI;

[SerializeField] private BoolSignalChannel toggleSignal;
[SerializeField] private Toggle toggle;

private void OnEnable()
{
    toggle.onValueChanged.AddListener(value => toggleSignal.Raise(value));
}
```

**Pattern 2: State Broadcasting**

```csharp
[SerializeField] private BoolSignalChannel visibilitySignal;

private void OnBecameVisible()
{
    visibilitySignal.Raise(true);
}

private void OnBecameInvisible()
{
    visibilitySignal.Raise(false);
}
```

**Pattern 3: State Synchronization**

```csharp
// One toggle affects multiple systems simultaneously:
// - UI indicator shows/hides
// - Audio plays/stops
// - Gameplay mechanics enable/disable
pauseSignal.Raise(true);
```

## Related Channels

When bool isn't quite right:

- [**Void Signal**](/docs/channels/void) - For events without data
- [**Int Signal**](/docs/channels/int) - For multi-state enums or counts
- [**String Signal**](/docs/channels/string) - For state names or identifiers

## Next Steps

- [**Int Signals**](/docs/channels/int) - Learn about integer signals for counts and IDs
- [**All Channel Types**](/docs/channels) - Explore all 15 signal channels
