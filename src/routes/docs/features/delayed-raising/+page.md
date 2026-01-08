# Delayed Raising

Raise signals after a time delay without using coroutines. Perfect for timed events, cooldowns, delayed effects, and scheduled notifications.

## When to Use Delayed Raising

Use delayed raising when you need timed signal events:

- **Timed Effects** - Delayed explosions, poison damage ticks, delayed healing
- **Cooldowns** - Ability cooldowns, spawn delays, respawn timers
- **Scheduled Notifications** - Timed warnings, countdown events, delayed messages
- **Animation Delays** - Wait for animation to complete before signaling
- **Tutorial Timing** - Show hints after a delay

## How It Works

- **No coroutines needed** - Built-in delay system handles timing
- **Cancelable** - Returns handle to cancel delayed raise if needed
- **Accurate timing** - Uses Unity's coroutine system internally
- **Works with all channels** - Available on all SignalChannel types

## Code Example

**Basic delayed raise:**

```csharp
using SignalKit.Runtime.Core.Channels;

[SerializeField] private VoidSignalChannel onBombExploded;

public void PlantBomb()
{
    Debug.Log("Bomb planted! Explodes in 3 seconds...");

    // Raise signal after 3 seconds
    onBombExploded.RaiseDelayed(default, 3f);
}
```

**Delayed raise with data:**

```csharp
[SerializeField] private IntSignalChannel onDamageTaken;

public void ApplyPoisonDamage(int damagePerTick, int ticks)
{
    for (int i = 0; i < ticks; i++)
    {
        // Deal damage every second
        float delay = (i + 1) * 1f;
        onDamageTaken.RaiseDelayed(damagePerTick, delay);
    }
}
```

**Canceling delayed raise:**

```csharp
[SerializeField] private VoidSignalChannel onTimerExpired;

private DelayedRaiseHandle _timerHandle;

public void StartTimer(float duration)
{
    _timerHandle = onTimerExpired.RaiseDelayed(default, duration);
}

public void CancelTimer()
{
    _timerHandle?.Cancel();
    Debug.Log("Timer cancelled!");
}
```

## Best Practices

### Do:
- **Store handle to cancel** - Keep DelayedRaiseHandle if you need to cancel
- **Use for single delays** - Perfect for one-off delayed events
- **Document delay duration** - Add comments explaining why delay is used
- **Cancel on cleanup** - Cancel delayed raises in OnDisable if needed

### Don't:
- **Don't use for frame-by-frame** - Use Update() for continuous logic
- **Don't spam delays** - Creating many delays has overhead
- **Don't rely on exact timing** - Frame-dependent, not millisecond-precise
- **Don't forget to cancel** - Cancel delayed raises when object is destroyed

## Common Patterns

**Pattern 1: Delayed Explosion**

```csharp
[SerializeField] private Vector3SignalChannel onExplosion;

public void ThrowGrenade(Vector3 targetPosition)
{
    Debug.Log("Grenade thrown!");

    // Explode after 2 seconds
    onExplosion.RaiseDelayed(targetPosition, 2f);
}
```

**Pattern 2: Ability Cooldown**

```csharp
[SerializeField] private VoidSignalChannel onAbilityReady;

private bool _isOnCooldown = false;

public void UseAbility()
{
    if (_isOnCooldown) return;

    // Use ability
    Debug.Log("Ability used!");
    _isOnCooldown = true;

    // Signal ready after cooldown
    onAbilityReady.RaiseDelayed(default, 5f);
}

private void OnEnable()
{
    onAbilityReady.Subscribe(OnAbilityReady);
}

private void OnDisable()
{
    // Listeners will be disposed automatically
}

private void OnAbilityReady(Void _)
{
    _isOnCooldown = false;
    Debug.Log("Ability ready!");
}
```

**Pattern 3: Respawn Timer**

```csharp
[SerializeField] private VoidSignalChannel onPlayerRespawned;

public void OnPlayerDied()
{
    Debug.Log("Player died! Respawning in 3 seconds...");

    // Respawn after delay
    onPlayerRespawned.RaiseDelayed(default, 3f);
}
```

**Pattern 4: Tutorial Hints**

```csharp
[SerializeField] private StringSignalChannel onTutorialHint;

public void StartLevel()
{
    // Show hints at specific times
    onTutorialHint.RaiseDelayed("Press SPACE to jump", 2f);
    onTutorialHint.RaiseDelayed("Collect coins for points", 5f);
    onTutorialHint.RaiseDelayed("Avoid enemies!", 10f);
}
```

**Pattern 5: Poison Damage Over Time**

```csharp
[SerializeField] private IntSignalChannel onPoisonDamage;

public void ApplyPoison(int damagePerTick, int tickCount, float tickInterval)
{
    for (int i = 0; i < tickCount; i++)
    {
        float delay = (i + 1) * tickInterval;
        onPoisonDamage.RaiseDelayed(damagePerTick, delay);
    }

    Debug.Log($"Poison applied: {damagePerTick} damage every {tickInterval}s for {tickCount} ticks");
}
```

**Pattern 6: Countdown System**

```csharp
[SerializeField] private IntSignalChannel onCountdownTick;
[SerializeField] private VoidSignalChannel onCountdownComplete;

public void StartCountdown(int seconds)
{
    for (int i = seconds; i > 0; i--)
    {
        float delay = seconds - i;
        onCountdownTick.RaiseDelayed(i, delay);
    }

    // Signal completion
    onCountdownComplete.RaiseDelayed(default, seconds);
}
```

**Pattern 7: Canceling Delayed Events**

```csharp
[SerializeField] private VoidSignalChannel onBossSpawned;

private DelayedRaiseHandle _spawnHandle;

public void ScheduleBossSpawn(float delay)
{
    _spawnHandle = onBossSpawned.RaiseDelayed(default, delay);
    Debug.Log($"Boss will spawn in {delay} seconds");
}

public void CancelBossSpawn()
{
    if (_spawnHandle != null)
    {
        _spawnHandle.Cancel();
        Debug.Log("Boss spawn cancelled!");
    }
}

private void OnDisable()
{
    // Cancel on cleanup
    _spawnHandle?.Cancel();
}
```

**Pattern 8: Animation Sync**

```csharp
[SerializeField] private VoidSignalChannel onAttackComplete;

public void PlayAttackAnimation()
{
    animator.SetTrigger("Attack");

    // Signal completion after animation duration
    float animationDuration = 0.8f;
    onAttackComplete.RaiseDelayed(default, animationDuration);
}
```

## Canceling Delayed Raises

All delayed raises return a `DelayedRaiseHandle` that you can use to cancel:

```csharp
[SerializeField] private VoidSignalChannel onEventRaised;

private DelayedRaiseHandle _handle;

private void Start()
{
    // Schedule delayed raise
    _handle = onEventRaised.RaiseDelayed(default, 5f);
}

private void Update()
{
    if (Input.GetKeyDown(KeyCode.Escape))
    {
        // Cancel the delayed raise
        _handle?.Cancel();
        Debug.Log("Delayed raise cancelled");
    }
}

private void OnDisable()
{
    // Always cancel on cleanup
    _handle?.Cancel();
}
```

## Multiple Delayed Raises

You can schedule multiple delayed raises on the same channel:

```csharp
[SerializeField] private StringSignalChannel onMessage;

public void ShowSequentialMessages()
{
    onMessage.RaiseDelayed("Message 1", 1f);
    onMessage.RaiseDelayed("Message 2", 2f);
    onMessage.RaiseDelayed("Message 3", 3f);
    onMessage.RaiseDelayed("Message 4", 4f);

    // All four messages will arrive at their scheduled times
}
```

## When NOT to Use Delayed Raising

Delayed raising isn't appropriate when:

- **Frame-by-frame updates** - Use Update() instead
- **Complex timing logic** - Use coroutines for complex sequences
- **Precise millisecond timing** - Unity coroutines aren't millisecond-precise
- **Very frequent delays** - Overhead for many simultaneous delays

## Performance Notes

- Each delayed raise creates a coroutine internally
- Canceling prevents the coroutine from completing
- Minimal overhead for reasonable use (&lt; 100 concurrent delays)
- More efficient than writing custom coroutine logic

## Related Features

- [**Priority System**](/docs/features/priority) - Control listener execution order
- [**One-Shot Listeners**](/docs/features/one-shot) - Auto-unsubscribe after first raise

## Next Steps

- [**Event Throttling**](/docs/features/throttling) - Learn about cooldowns between raises
- [**All Channel Types**](/docs/channels) - Explore all signal channels
