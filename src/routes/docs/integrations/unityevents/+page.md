# UnityEvent Integration

SignalListeners are MonoBehaviour components that bridge SignalChannels to Unity's visual scripting system. Connect signals to any method without writing code.

## When to Use SignalListeners

Use SignalListeners when you need:

- **Designer-Friendly Workflow** - Let designers connect signals without coding
- **Quick Prototyping** - Hook up events visually in Inspector
- **Visual Scripting** - Connect signals to existing UnityEvent workflows
- **No-Code Solutions** - Build gameplay without writing scripts
- **Inspector Testing** - Quickly test signals during development

## How It Works

- **MonoBehaviour component** - Add to any GameObject
- **UnityEvent field** - Connect to methods in Inspector
- **All channel types** - 14 built-in listeners for each channel type
- **Priority support** - Set execution priority in Inspector
- **One-shot support** - Auto-unsubscribe after first raise

## Available SignalListeners

All 14 built-in channel types have corresponding listeners:

- VoidSignalListener
- BoolSignalListener
- IntSignalListener
- FloatSignalListener
- DoubleSignalListener
- StringSignalListener
- Vector2SignalListener
- Vector2IntSignalListener
- Vector3SignalListener
- Vector3IntSignalListener
- QuaternionSignalListener
- ColorSignalListener
- GameObjectSignalListener
- TransformSignalListener

## Code Example

**Basic setup (no code required):**

1. Add `IntSignalListener` component to GameObject
2. Assign `onHealthChanged` channel in Inspector
3. Add callback to `On Signal Raised` UnityEvent
4. Connect to `UpdateHealthUI(int)` method

**With code (for method reference):**

```csharp
using UnityEngine;

public class HealthUI : MonoBehaviour
{
    [SerializeField] private TMPro.TextMeshProUGUI healthText;

    // Called by IntSignalListener's UnityEvent
    public void UpdateHealth(int health)
    {
        healthText.text = $"HP: {health}";
    }
}
```

## Inspector Configuration

**IntSignalListener Inspector:**

```
┌─ Int Signal Listener ─────────────┐
│                                    │
│ Channel:   [onHealthChanged]       │
│ Priority:  [100]                   │
│ One Shot:  [ ]                     │
│                                    │
│ On Signal Raised (int)             │
│   ├─ HealthUI.UpdateHealth         │
│   ├─ HealthBar.SetValue            │
│   └─ AudioManager.PlayDamageSound  │
│                                    │
└────────────────────────────────────┘
```

## Common Patterns

**Pattern 1: UI Updates**

```
Setup:
1. Add IntSignalListener to UI GameObject
2. Assign onScoreChanged channel
3. Connect to TextMeshPro.SetText(string)

Result: Score text updates automatically when signal raises
```

**Pattern 2: Audio Triggers**

```
Setup:
1. Add VoidSignalListener to AudioManager GameObject
2. Assign onPlayerDied channel
3. Connect to AudioSource.Play()

Result: Death sound plays when player dies
```

**Pattern 3: Animation Triggers**

```
Setup:
1. Add BoolSignalListener to Player GameObject
2. Assign onGamePaused channel
3. Connect to Animator.SetBool("Paused")

Result: Pause animation plays when game pauses
```

**Pattern 4: Multiple Callbacks**

```
Setup:
1. Add VoidSignalListener to GameManager
2. Assign onLevelCompleted channel
3. Add multiple callbacks:
   - SaveManager.SaveProgress()
   - UIManager.ShowVictoryScreen()
   - AudioManager.PlayVictoryMusic()
   - AnalyticsManager.LogLevelComplete()

Result: All systems respond to level completion
```

**Pattern 5: GameObject Spawning**

```
Setup:
1. Add Vector3SignalListener to SpawnManager
2. Assign onEnemySpawnRequested channel
3. Connect to SpawnManager.SpawnEnemyAtPosition(Vector3)

Result: Enemy spawns at signal position
```

**Pattern 6: Color Changes**

```
Setup:
1. Add ColorSignalListener to Light GameObject
2. Assign onAmbientColorChanged channel
3. Connect to Light.set_color(Color)

Result: Light color changes with signal
```

**Pattern 7: Debug Logging**

```
Setup:
1. Add StringSignalListener to DebugManager
2. Assign onDebugMessage channel
3. Connect to Debug.Log(string)

Result: All debug messages logged to console
```

**Pattern 8: One-Shot Achievement**

```
Setup:
1. Add IntSignalListener to AchievementManager
2. Assign onEnemiesKilled channel
3. Enable "One Shot" checkbox
4. Set filter or use ShouldHandle override
5. Connect to AchievementManager.UnlockAchievement()

Result: Achievement unlocks once when condition met
```

## Priority in Listeners

SignalListeners support priority via Inspector field:

```
Priority: 0   -> Executes first
Priority: 100 -> Default
Priority: 200 -> Executes last
```

Multiple listeners on same GameObject execute in priority order.

## One-Shot in Listeners

Enable "One Shot" checkbox to auto-unsubscribe after first signal:

```
☑ One Shot

Result: UnityEvent invokes once, then listener unsubscribes
```

Perfect for first-time tutorials, achievements, or unlock events.

## Creating Custom Listeners

Extend SignalListener&lt;T&gt; for custom behavior:

```csharp
using SignalKit.Runtime.Core.Listeners;
using UnityEngine;
using UnityEngine.Events;

[AddComponentMenu("My Game/Custom Int Listener")]
public class CustomIntListener : SignalListener<int>
{
    [SerializeField]
    private UnityEvent<int> onSignalRaised = new();

    protected override void InvokeResponse(int value)
    {
        // Custom filtering or processing
        if (value > 0)
        {
            onSignalRaised.Invoke(value);
        }
    }

    protected override bool ShouldHandle(int value)
    {
        // Custom filter logic
        return value >= 10;
    }
}
```

## Best Practices

### Do:
- **Use for designer workflows** - Empower non-programmers
- **Combine with code** - Use both listeners and code subscriptions
- **Set priorities** - Control execution order across listeners
- **Enable one-shot for unique events** - Achievements, unlocks, first-time events
- **Name channels clearly** - Helps designers find right channels

### Don't:
- **Don't overuse listeners** - Code subscriptions are more performant
- **Don't use for high-frequency** - Listeners have UnityEvent overhead
- **Don't forget to assign channels** - Listeners do nothing without channels
- **Don't chain too many listeners** - Prefer direct code subscriptions for complex logic

## Performance Considerations

**UnityEvent overhead:**
- UnityEvents are slower than direct method calls
- Use code subscriptions for performance-critical paths
- Listeners are fine for UI, audio, and infrequent events

**Recommendation:**
- **Gameplay logic**: Use code subscriptions
- **UI/Audio/Effects**: Use SignalListeners
- **Prototyping**: Use SignalListeners, optimize later

## When NOT to Use SignalListeners

SignalListeners aren't appropriate when:

- **Performance critical** - Use code subscriptions instead
- **Complex logic needed** - Write custom listener or use code
- **High-frequency signals** - UnityEvent overhead adds up
- **Multiple conditions** - Code subscriptions with filters are clearer

## Debugging SignalListeners

**Inspector Debugging:**
- Red X: Channel not assigned
- Yellow !: No UnityEvent callbacks assigned
- Green ✓: Configured correctly
- Last Received Value: Shows last signal value (Editor only)

**Runtime Debugging:**
- Add Debug.Log to UnityEvent for testing
- Use Signal Debugger window to see all raises
- Check "Has Received Signal" field in Inspector

## Integration with Visual Scripting

SignalListeners work with:
- **Unity Visual Scripting** - Create custom nodes
- **Bolt** - Connect to flow graphs
- **PlayMaker** - Use as FSM actions
- **Adventure Creator** - Trigger actions on signals

## Related Features

- [**All Channel Types**](/docs/channels) - Explore all signal channels
- [**Priority System**](/docs/features/priority) - Control execution order

## Next Steps

- [**Input System Integration**](/docs/integrations/input-system) - Learn about Input System integration
- [**Code Generation**](/docs/tools/code-generation) - Generate custom listeners automatically
