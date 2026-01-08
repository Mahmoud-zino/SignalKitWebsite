# Event Throttling

Throttling prevents signals from being raised or handled too frequently by enforcing a cooldown period. Perfect for rate-limiting user input, preventing ability spam, and reducing excessive signal raises.

## When to Use Throttling

Use throttling when you need to rate-limit events:

- **Ability Cooldowns** - Prevent spamming abilities or attacks
- **Input Rate-Limiting** - Limit how often button presses are processed
- **Save Throttling** - Prevent excessive auto-save calls
- **Network Requests** - Rate-limit API calls or multiplayer updates
- **UI Updates** - Prevent excessive UI refreshes

## How It Works

- **Cooldown period** - Minimum time between raises/invocations
- **Two modes** - Drop (ignore) or QueueLast (queue most recent)
- **Throttled raising** - Limit how often channel raises signals
- **Throttled listening** - Limit how often handler is invoked

## Throttle Modes

**Drop Mode** (default):
- Signals during cooldown are silently ignored
- Good for input spam prevention
- No queuing overhead

**QueueLast Mode**:
- Last signal during cooldown is queued
- Automatically raised when cooldown ends
- Ensures final value isn't lost

## Code Example

**Throttled listener (Drop mode):**

```csharp
using SignalKit.Runtime.Core.Channels;
using SignalKit.Runtime.Core.Modifiers;

[SerializeField] private VoidSignalChannel onJumpPressed;

private ThrottledListener<Void> _jumpListener;

private void OnEnable()
{
    // Only allow jump every 0.5 seconds (drop extra inputs)
    _jumpListener = onJumpPressed.SubscribeThrottled(
        HandleJump,
        cooldown: 0.5f,
        mode: ThrottleMode.Drop
    );
}

private void OnDisable()
{
    _jumpListener?.Dispose();
}

private void HandleJump(Void _)
{
    // Only executes if cooldown has passed
    playerController.Jump();
}
```

**Throttled listener (QueueLast mode):**

```csharp
[SerializeField] private IntSignalChannel onDamageDealt;

private ThrottledListener<int> _damageListener;

private void OnEnable()
{
    // Process damage with cooldown, queue last value
    _damageListener = onDamageDealt.SubscribeThrottled(
        ApplyDamage,
        cooldown: 0.1f,
        mode: ThrottleMode.QueueLast
    );
}

private void OnDisable()
{
    _damageListener?.Dispose();
}

private void ApplyDamage(int damage)
{
    health -= damage;
    UpdateHealthUI();
}
```

**Throttled raiser:**

```csharp
[SerializeField] private VoidSignalChannel onSaveRequested;

private ThrottledRaiser<Void> _throttledSave;

private void Start()
{
    // Throttle save requests to once per 5 seconds
    _throttledSave = onSaveRequested.Throttled(
        cooldown: 5f,
        mode: ThrottleMode.Drop
    );
}

public void RequestSave()
{
    // Will only actually raise if cooldown has passed
    _throttledSave.Raise(default);
}
```

## Best Practices

### Do:
- **Use Drop for spam prevention** - Input spam, button mashing
- **Use QueueLast for state updates** - Ensures final value is processed
- **Document cooldown duration** - Explain why specific cooldown is used
- **Dispose throttled listeners** - Clean up in OnDisable

### Don't:
- **Don't use for precise timing** - Use Delayed Raising for scheduled events
- **Don't set cooldown too high** - Makes controls feel unresponsive
- **Don't forget to dispose** - Throttled listeners must be disposed
- **Don't throttle critical events** - Death, damage, game-ending events

## Common Patterns

**Pattern 1: Ability Cooldown (Drop)**

```csharp
[SerializeField] private VoidSignalChannel onAbilityUsed;

private ThrottledListener<Void> _abilityListener;

private void OnEnable()
{
    // Ability has 2 second cooldown
    _abilityListener = onAbilityUsed.SubscribeThrottled(
        UseAbility,
        cooldown: 2f,
        mode: ThrottleMode.Drop
    );
}

private void OnDisable()
{
    _abilityListener?.Dispose();
}

private void UseAbility(Void _)
{
    PlayAbilityAnimation();
    DealDamage();
}
```

**Pattern 2: Auto-Save Throttling (Drop)**

```csharp
[SerializeField] private VoidSignalChannel onGameStateChanged;

private ThrottledListener<Void> _saveListener;

private void OnEnable()
{
    // Auto-save at most once per 10 seconds
    _saveListener = onGameStateChanged.SubscribeThrottled(
        TriggerAutoSave,
        cooldown: 10f,
        mode: ThrottleMode.Drop
    );
}

private void OnDisable()
{
    _saveListener?.Dispose();
}

private void TriggerAutoSave(Void _)
{
    SaveSystem.Save();
    Debug.Log("Auto-saved game");
}
```

**Pattern 3: UI Update Throttling (QueueLast)**

```csharp
[SerializeField] private IntSignalChannel onScoreChanged;

private ThrottledListener<int> _scoreListener;

private void OnEnable()
{
    // Update score UI at most 10 times per second, queue last value
    _scoreListener = onScoreChanged.SubscribeThrottled(
        UpdateScoreUI,
        cooldown: 0.1f,
        mode: ThrottleMode.QueueLast
    );
}

private void OnDisable()
{
    _scoreListener?.Dispose();
}

private void UpdateScoreUI(int score)
{
    scoreText.text = $"Score: {score}";
}
```

**Pattern 4: Network Sync Throttling (QueueLast)**

```csharp
[SerializeField] private Vector3SignalChannel onPlayerMoved;

private ThrottledListener<Vector3> _moveListener;

private void OnEnable()
{
    // Send position updates at most 10 times per second, queue last
    _moveListener = onPlayerMoved.SubscribeThrottled(
        SyncPositionToServer,
        cooldown: 0.1f,
        mode: ThrottleMode.QueueLast
    );
}

private void OnDisable()
{
    _moveListener?.Dispose();
}

private void SyncPositionToServer(Vector3 position)
{
    NetworkManager.SendPositionUpdate(position);
}
```

**Pattern 5: Search Input Throttling (Drop)**

```csharp
[SerializeField] private StringSignalChannel onSearchTextChanged;

private ThrottledListener<string> _searchListener;

private void OnEnable()
{
    // Search at most once per 0.5 seconds
    _searchListener = onSearchTextChanged.SubscribeThrottled(
        PerformSearch,
        cooldown: 0.5f,
        mode: ThrottleMode.Drop
    );
}

private void OnDisable()
{
    _searchListener?.Dispose();
}

private void PerformSearch(string query)
{
    searchResults = SearchDatabase(query);
    UpdateSearchResultsUI();
}
```

**Pattern 6: Throttled Raiser for Save System**

```csharp
[SerializeField] private VoidSignalChannel onSaveRequested;

private ThrottledRaiser<Void> _throttledSave;

private void Start()
{
    // Create throttled raiser (5 second cooldown)
    _throttledSave = onSaveRequested.Throttled(
        cooldown: 5f,
        mode: ThrottleMode.Drop
    );
}

public void OnPlayerDataChanged()
{
    // Request save (will only actually raise if cooldown passed)
    _throttledSave.Raise(default);
}
```

**Pattern 7: Analytics Event Throttling (Drop)**

```csharp
[SerializeField] private StringSignalChannel onAnalyticsEvent;

private ThrottledListener<string> _analyticsListener;

private void OnEnable()
{
    // Send analytics at most once per second
    _analyticsListener = onAnalyticsEvent.SubscribeThrottled(
        SendAnalytics,
        cooldown: 1f,
        mode: ThrottleMode.Drop
    );
}

private void OnDisable()
{
    _analyticsListener?.Dispose();
}

private void SendAnalytics(string eventName)
{
    AnalyticsService.SendEvent(eventName);
}
```

**Pattern 8: Damage Number Throttling (QueueLast)**

```csharp
[SerializeField] private IntSignalChannel onDamageNumberRequested;

private ThrottledListener<int> _damageListener;

private void OnEnable()
{
    // Show damage numbers at most 5 times per second, queue last
    _damageListener = onDamageNumberRequested.SubscribeThrottled(
        ShowDamageNumber,
        cooldown: 0.2f,
        mode: ThrottleMode.QueueLast
    );
}

private void OnDisable()
{
    _damageListener?.Dispose();
}

private void ShowDamageNumber(int damage)
{
    damageNumberUI.Show(damage);
}
```

## Drop vs QueueLast

**Use Drop when:**
- Input spam prevention (jump, attack, interact)
- Events where missing some is acceptable
- Performance is critical (no queuing overhead)
- Example: Button mashing, rapid fire

**Use QueueLast when:**
- Final value matters (position, health, score)
- State synchronization
- Ensuring important updates aren't lost
- Example: Network sync, UI updates, save states

## Combining with Other Features

```csharp
[SerializeField] private IntSignalChannel onAbilityUsed;

private ThrottledListener<int> _abilityListener;

private void OnEnable()
{
    // Throttled + filtered + priority
    _abilityListener = onAbilityUsed.SubscribeThrottled(
        UseAbility,
        cooldown: 2f,
        mode: ThrottleMode.Drop
    );

    // Note: Throttled listeners don't support fluent chaining with WithPriority/WithFilter
    // Use regular Subscribe() if you need to combine features
}
```

## When NOT to Use Throttling

Throttling isn't appropriate when:

- **Every event matters** - Death, game-ending events, critical actions
- **Precise timing needed** - Use Delayed Raising for scheduled events
- **Low-frequency events** - Already infrequent events don't need throttling
- **Complex cooldown logic** - Use custom cooldown system for complex rules

## Performance Notes

- Throttling adds minimal overhead
- Drop mode has no memory allocation
- QueueLast mode stores one value during cooldown
- More efficient than manual cooldown tracking

## Related Features

- [**Priority System**](/docs/features/priority) - Control listener execution order
- [**Filters**](/docs/features/filters) - Conditional listening

## Next Steps

- [**One-Shot Listeners**](/docs/features/one-shot) - Learn about auto-unsubscribe listeners
- [**All Channel Types**](/docs/channels) - Explore all signal channels
