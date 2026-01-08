# Filters

Listen to signals conditionally with filters. Only process events that match your criteria, reducing unnecessary code execution and keeping your systems focused.

## When to Use Filters

Use filters when you only want to respond to specific events:

- **Value Thresholds** - Only react when health drops below 25%
- **State Conditions** - Only respond when game is not paused
- **Type Filtering** - Only handle specific enemy types or damage types
- **Range Checks** - Only process events within a certain distance
- **Permission Checks** - Only allow events for authorized players

## How It Works

- **Filters are predicates** - Return `true` to process, `false` to ignore
- **Evaluated before listener** - Filtered events never reach your listener
- **Multiple filters** - Can combine filters (all must return true)
- **Zero overhead** - Filtered events skip listener execution entirely

## Code Example

**Basic filter:**

```csharp
using SignalKit.Runtime.Core.Channels;
using SignalKit.Runtime.Core.Subscribers;

[SerializeField] private IntSignalChannel onHealthChanged;

private Subscription<int> _healthSub;

private void OnEnable()
{
    // Only listen when health is critically low
    _healthSub = onHealthChanged.Subscribe(HandleCriticalHealth)
                                .WithFilter(health => health < 25);
}

private void OnDisable()
{
    _healthSub?.Dispose();
}

private void HandleCriticalHealth(int health)
{
    // Only executes when health < 25
    Debug.Log("Critical health! Playing warning sound...");
}
```

**Multiple filters (combined with AND logic):**

```csharp
private Subscription<int> _damageSub;

private void OnEnable()
{
    // Only process damage that is:
    // - Greater than 10 AND player is not invincible
    _damageSub = onDamageDealt.Subscribe(ProcessDamage)
                              .WithFilter(damage => damage > 10 && !isInvincible);
}

private void OnDisable()
{
    _damageSub?.Dispose();
}
```

## Best Practices

### Do:
- **Keep filters simple** - Simple conditions execute faster
- **Use for expensive operations** - Filter before heavy processing
- **Document filter logic** - Explain why the filter is needed
- **Store subscription references** - Keep `Subscription<T>` fields to properly dispose later

### Don't:
- **Don't use complex logic** - Keep filters lightweight
- **Don't modify state in filters** - Filters should be pure functions
- **Don't throw exceptions** - Return false instead of throwing
- **Don't forget to dispose** - Always call Dispose() in OnDisable to prevent memory leaks

## Common Patterns

**Pattern 1: Threshold Filtering**

```csharp
[SerializeField] private FloatSignalChannel onHealthPercent;

private Subscription<float> _lowHealthSub;
private Subscription<float> _criticalHealthSub;

private void OnEnable()
{
    // Low health warning (< 30%)
    _lowHealthSub = onHealthPercent.Subscribe(ShowLowHealthWarning)
                                   .WithFilter(percent => percent < 0.3f);

    // Critical health warning (< 10%)
    _criticalHealthSub = onHealthPercent.Subscribe(ShowCriticalHealthWarning)
                                        .WithFilter(percent => percent < 0.1f);
}

private void OnDisable()
{
    _lowHealthSub?.Dispose();
    _criticalHealthSub?.Dispose();
}
```

**Pattern 2: State-Based Filtering**

```csharp
[SerializeField] private IntSignalChannel onScoreChanged;
private bool isGameActive = true;

private Subscription<int> _scoreSub;

private void OnEnable()
{
    // Only update score when game is active
    _scoreSub = onScoreChanged.Subscribe(UpdateScore)
                              .WithFilter(score => isGameActive);
}

private void OnDisable()
{
    _scoreSub?.Dispose();
}
```

**Pattern 3: Type Filtering**

```csharp
[SerializeField] private StringSignalChannel onEnemySpawned;

private Subscription<string> _bossSub;

private void OnEnable()
{
    // Only track boss enemies
    _bossSub = onEnemySpawned.Subscribe(HandleBossSpawn)
                             .WithFilter(enemyType => enemyType.Contains("Boss"));
}

private void OnDisable()
{
    _bossSub?.Dispose();
}
```

**Pattern 4: Range Filtering**

```csharp
[SerializeField] private Vector3SignalChannel onExplosion;

private Subscription<Vector3> _explosionSub;

private void OnEnable()
{
    // Only react to nearby explosions
    _explosionSub = onExplosion.Subscribe(HandleNearbyExplosion)
                               .WithFilter(position =>
                                   Vector3.Distance(transform.position, position) < 10f
                               );
}

private void OnDisable()
{
    _explosionSub?.Dispose();
}
```

**Pattern 5: Complex Conditions**

```csharp
[SerializeField] private IntSignalChannel onDamageDealt;
private int armor = 50;
private bool isShieldActive = false;

private Subscription<int> _damageSub;

private void OnEnable()
{
    // Only apply damage if:
    // - Damage exceeds armor
    // - Shield is not active
    _damageSub = onDamageDealt.Subscribe(ApplyDamage)
                              .WithFilter(damage =>
                                  damage > armor && !isShieldActive
                              );
}

private void OnDisable()
{
    _damageSub?.Dispose();
}
```

**Pattern 6: Using Method References**

```csharp
private Subscription<int> _healthSub;

private void OnEnable()
{
    _healthSub = onHealthChanged.Subscribe(HandleHealthChange)
                                .WithFilter(IsHealthCritical);
}

private void OnDisable()
{
    _healthSub?.Dispose();
}

private bool IsHealthCritical(int health)
{
    return health < 25 && !isInvincible && isPlayerAlive;
}
```

## Combining Filters with Priorities

Filters and priorities work together:

```csharp
private Subscription<int> _highDamageSub;

private void OnEnable()
{
    // Chain priority and filter together
    _highDamageSub = onDamageDealt.Subscribe(ProcessHighDamage)
                                  .WithPriority(0)
                                  .WithFilter(damage => damage >= 50);
}

private void OnDisable()
{
    _highDamageSub?.Dispose();
}
```

**Execution order:**
1. Signal is raised with value
2. Filter is evaluated (before priority sorting)
3. If filter returns `true`, listener executes at its priority
4. If filter returns `false`, listener is skipped entirely

## Performance Notes

- Filters add minimal overhead (simple comparison)
- Filtered events avoid expensive listener execution
- Use filters to optimize frequently raised signals
- Filters are more efficient than `if` statements inside listeners

## Related Features

- [**Priority System**](/docs/features/priority) - Control listener execution order
- [**One-Shot Listeners**](/docs/features/one-shot) - Auto-unsubscribe after first raise
- [**Event Throttling**](/docs/features/throttling) - Cooldown between raises

## Next Steps

- [**One-Shot Listeners**](/docs/features/one-shot) - Learn about auto-unsubscribe listeners
- [**All Channel Types**](/docs/channels) - Explore all signal channels
