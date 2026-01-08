# Priority System

Control the execution order of your signal listeners with priorities. Lower priority values execute first, giving you precise control over when each system responds to events.

## When to Use Priorities

Use the priority system when execution order matters:

- **Validation First** - Validate data before processing
- **State Updates Before UI** - Update game state before refreshing UI
- **Logging Last** - Log events after all systems have processed them
- **Critical Systems First** - Health/death checks before animation/sound
- **Cleanup Last** - Destroy objects after all systems finish

## How It Works

- **Default priority is 100** - Listeners without explicit priority use 100
- **Lower numbers execute first** - Priority 0 executes before priority 100
- **Higher numbers execute later** - Priority 200 executes after priority 100
- **Same priority = insertion order** - Listeners with same priority execute in order they were added

## Code Example

**Setting listener priority:**

```csharp
using SignalKit.Runtime.Core.Channels;
using SignalKit.Runtime.Core.Subscribers;

[SerializeField] private IntSignalChannel onDamageDealt;

private Subscription<int> _validationSub;
private Subscription<int> _applySub;
private Subscription<int> _logSub;

private void OnEnable()
{
    // Low priority value - executes first
    _validationSub = onDamageDealt.Subscribe(HandleDamageValidation)
                                   .WithPriority(0);

    // Default priority (100) - executes in the middle
    _applySub = onDamageDealt.Subscribe(ApplyDamage);

    // High priority value - executes last
    _logSub = onDamageDealt.Subscribe(LogDamage)
                           .WithPriority(200);
}

private void OnDisable()
{
    _validationSub?.Dispose();
    _applySub?.Dispose();
    _logSub?.Dispose();
}

private void HandleDamageValidation(int damage)
{
    // Priority: 0 - Executes FIRST
    Debug.Log("1. Validating damage...");
}

private void ApplyDamage(int damage)
{
    // Priority: 100 (default) - Executes SECOND
    Debug.Log("2. Applying damage...");
}

private void LogDamage(int damage)
{
    // Priority: 200 - Executes LAST
    Debug.Log("3. Logging damage...");
}
```

## Best Practices

### Do:
- **Use meaningful ranges** - Use 0, 100, 200 for clear separation (not 98, 99, 100)
- **Document priorities** - Add comments explaining why a specific priority is used
- **Store subscription references** - Keep `Subscription<T>` fields to properly dispose later
- **Use constants** - Define priority values as constants for clarity

### Don't:
- **Don't rely on default order** - If order matters, use priorities explicitly
- **Don't use tiny increments** - Use 0, 100, 200, not 98, 99, 100
- **Don't overuse priorities** - Only use when execution order truly matters
- **Don't forget to dispose** - Always call Dispose() in OnDisable to prevent memory leaks

## Common Patterns

**Pattern 1: Validation → Processing → Logging**

```csharp
private Subscription<int> _validateSub;
private Subscription<int> _processSub;
private Subscription<int> _logSub;

private void OnEnable()
{
    // Validation first (priority: 0)
    _validateSub = onTransactionRequested.Subscribe(ValidateTransaction)
                                         .WithPriority(0);

    // Processing (priority: 100 - default)
    _processSub = onTransactionRequested.Subscribe(ProcessTransaction);

    // Logging last (priority: 200)
    _logSub = onTransactionRequested.Subscribe(LogTransaction)
                                     .WithPriority(200);
}

private void OnDisable()
{
    _validateSub?.Dispose();
    _processSub?.Dispose();
    _logSub?.Dispose();
}
```

**Pattern 2: State → UI → Effects**

```csharp
private Subscription<int> _stateSub;
private Subscription<int> _uiSub;
private Subscription<int> _effectsSub;

private void OnEnable()
{
    // Update game state first (priority: 0)
    _stateSub = onHealthChanged.Subscribe(UpdateHealthState)
                               .WithPriority(0);

    // Update UI (priority: 100 - default)
    _uiSub = onHealthChanged.Subscribe(UpdateHealthBar);

    // Play effects last (priority: 200)
    _effectsSub = onHealthChanged.Subscribe(PlayHealthChangedVFX)
                                 .WithPriority(200);
}

private void OnDisable()
{
    _stateSub?.Dispose();
    _uiSub?.Dispose();
    _effectsSub?.Dispose();
}
```

**Pattern 3: Critical Checks First**

```csharp
private Subscription<int> _deathCheckSub;
private Subscription<int> _animationSub;
private Subscription<int> _effectSub;

private void OnEnable()
{
    // Death check MUST happen before animations (priority: 0)
    _deathCheckSub = onDamageTaken.Subscribe(CheckForDeath)
                                   .WithPriority(0);

    // Other systems can run normally (priority: 100 - default)
    _animationSub = onDamageTaken.Subscribe(PlayDamageAnimation);
    _effectSub = onDamageTaken.Subscribe(SpawnBloodEffect);
}

private void OnDisable()
{
    _deathCheckSub?.Dispose();
    _animationSub?.Dispose();
    _effectSub?.Dispose();
}
```

**Pattern 4: Using Constants**

```csharp
public static class ListenerPriority
{
    public const int Validation = 0;
    public const int Processing = 100;
    public const int Logging = 200;
    public const int Cleanup = 300;
}

private Subscription<int> _validateSub;
private Subscription<int> _processSub;
private Subscription<int> _logSub;

private void OnEnable()
{
    _validateSub = onEventRaised.Subscribe(ValidateEvent)
                                .WithPriority(ListenerPriority.Validation);

    _processSub = onEventRaised.Subscribe(ProcessEvent)
                               .WithPriority(ListenerPriority.Processing);

    _logSub = onEventRaised.Subscribe(LogEvent)
                           .WithPriority(ListenerPriority.Logging);
}

private void OnDisable()
{
    _validateSub?.Dispose();
    _processSub?.Dispose();
    _logSub?.Dispose();
}
```

## Priority Ranges Guide

Use these ranges as a starting point:

- **0** - Critical systems (death checks, save systems)
- **50** - Validation and state updates
- **100** (default) - Normal processing
- **150** - UI updates and visual feedback
- **200** - Logging and analytics
- **250** - Cleanup and disposal

## Performance Notes

- Priorities have minimal overhead
- Listeners are sorted once when priority is set
- No performance impact during signal raise

## Related Features

- [**Filters**](/docs/features/filters) - Conditional listening
- [**One-Shot Listeners**](/docs/features/one-shot) - Auto-unsubscribe after first raise
- [**Buffered Subscriptions**](/docs/features/buffered-subscriptions) - Late joiners get last value

## Next Steps

- [**Filters**](/docs/features/filters) - Learn about conditional signal listening
- [**All Channel Types**](/docs/channels) - Explore all signal channels
