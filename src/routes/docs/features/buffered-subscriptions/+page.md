# Buffered Subscriptions

Buffered subscriptions remember the last raised value and immediately invoke new subscribers with that value. Perfect for late-joining listeners that need the current state.

## When to Use Buffered Subscriptions

Use buffered subscriptions when late joiners need the current value:

- **State Synchronization** - New UI elements get current health/score immediately
- **Late Initialization** - Objects spawned mid-game receive current game state
- **Configuration Values** - Settings that need to persist and sync to new listeners
- **Player Stats** - New UI panels get current stat values immediately
- **Game State** - Late joiners get current level, difficulty, or mode

## How It Works

- **Immediate invocation** - Handler called immediately with current/default value
- **Stores last value** - Remembers last raised value in `CurrentValue` property
- **Normal updates** - Receives all subsequent raises like regular subscription
- **Track if received** - `HasValue` property indicates if any signal was raised

## Code Example

**Basic buffered subscription:**

```csharp
using SignalKit.Runtime.Core.Channels;
using SignalKit.Runtime.Core.Modifiers;

[SerializeField] private IntSignalChannel onHealthChanged;

private BufferedSubscription<int> _healthSub;

private void OnEnable()
{
    // Subscribe and immediately receive current value (default: 100)
    _healthSub = onHealthChanged.SubscribeBuffered(UpdateHealthUI, defaultValue: 100);
}

private void OnDisable()
{
    _healthSub?.Dispose();
}

private void UpdateHealthUI(int health)
{
    // Called immediately with 100, then on every health change
    healthText.text = $"HP: {health}";
}
```

**Accessing buffered value:**

```csharp
[SerializeField] private FloatSignalChannel onVolumeChanged;

private BufferedSubscription<float> _volumeSub;

private void OnEnable()
{
    _volumeSub = onVolumeChanged.SubscribeBuffered(UpdateVolume, defaultValue: 0.8f);

    // Access current value anytime
    Debug.Log($"Current volume: {_volumeSub.CurrentValue}");

    // Check if any signal was raised
    if (_volumeSub.HasValue)
    {
        Debug.Log("Volume was set by a signal");
    }
}

private void UpdateVolume(float volume)
{
    audioMixer.SetFloat("MasterVolume", volume);
}
```

## Best Practices

### Do:
- **Use for state values** - Health, score, settings that persist
- **Set sensible defaults** - Provide default value when subscribing
- **Access CurrentValue** - Use CurrentValue property to query state anytime
- **Check HasValue** - Use HasValue to distinguish default from raised values

### Don't:
- **Don't use for events** - Buffering isn't useful for one-time events
- **Don't use for high-frequency** - Overhead for rapidly changing values
- **Don't forget to dispose** - Always call Dispose() in OnDisable
- **Don't mutate CurrentValue** - Read-only property, raises update via signal

## Common Patterns

**Pattern 1: UI Synchronization**

```csharp
[SerializeField] private IntSignalChannel onScoreChanged;

private BufferedSubscription<int> _scoreSub;

private void OnEnable()
{
    // UI element created late, needs current score
    _scoreSub = onScoreChanged.SubscribeBuffered(UpdateScoreUI, defaultValue: 0);
}

private void OnDisable()
{
    _scoreSub?.Dispose();
}

private void UpdateScoreUI(int score)
{
    scoreText.text = $"Score: {score}";
}
```

**Pattern 2: Settings Panel**

```csharp
[SerializeField] private FloatSignalChannel onBrightnessChanged;
[SerializeField] private FloatSignalChannel onVolumeChanged;

private BufferedSubscription<float> _brightnessSub;
private BufferedSubscription<float> _volumeSub;

private void OnEnable()
{
    // Settings panel opens, needs current values
    _brightnessSub = onBrightnessChanged.SubscribeBuffered(UpdateBrightnessSlider, 0.8f);
    _volumeSub = onVolumeChanged.SubscribeBuffered(UpdateVolumeSlider, 0.7f);
}

private void OnDisable()
{
    _brightnessSub?.Dispose();
    _volumeSub?.Dispose();
}

private void UpdateBrightnessSlider(float brightness)
{
    brightnessSlider.value = brightness;
}

private void UpdateVolumeSlider(float volume)
{
    volumeSlider.value = volume;
}
```

**Pattern 3: Player Stats UI**

```csharp
[SerializeField] private IntSignalChannel onHealthChanged;
[SerializeField] private IntSignalChannel onManaChanged;
[SerializeField] private IntSignalChannel onStaminaChanged;

private BufferedSubscription<int> _healthSub;
private BufferedSubscription<int> _manaSub;
private BufferedSubscription<int> _staminaSub;

private void OnEnable()
{
    // Stats UI panel created, needs current values
    _healthSub = onHealthChanged.SubscribeBuffered(UpdateHealthBar, 100);
    _manaSub = onManaChanged.SubscribeBuffered(UpdateManaBar, 100);
    _staminaSub = onStaminaChanged.SubscribeBuffered(UpdateStaminaBar, 100);
}

private void OnDisable()
{
    _healthSub?.Dispose();
    _manaSub?.Dispose();
    _staminaSub?.Dispose();
}

private void UpdateHealthBar(int health)
{
    healthBar.fillAmount = health / 100f;
}

private void UpdateManaBar(int mana)
{
    manaBar.fillAmount = mana / 100f;
}

private void UpdateStaminaBar(int stamina)
{
    staminaBar.fillAmount = stamina / 100f;
}
```

**Pattern 4: Game State for Late Joiners**

```csharp
[SerializeField] private StringSignalChannel onGameModeChanged;

private BufferedSubscription<string> _modeSub;

private void OnEnable()
{
    // Object spawned mid-game, needs current mode
    _modeSub = onGameModeChanged.SubscribeBuffered(OnGameModeChanged, "Normal");

    // Can also query current mode directly
    string currentMode = _modeSub.CurrentValue;
    Debug.Log($"Current game mode: {currentMode}");
}

private void OnDisable()
{
    _modeSub?.Dispose();
}

private void OnGameModeChanged(string mode)
{
    Debug.Log($"Game mode: {mode}");
    ApplyGameMode(mode);
}
```

**Pattern 5: Configuration Values**

```csharp
[SerializeField] private IntSignalChannel onDifficultyChanged;

private BufferedSubscription<int> _difficultySub;

private void OnEnable()
{
    // Subscribe to difficulty changes with default of 1 (Normal)
    _difficultySub = onDifficultyChanged.SubscribeBuffered(OnDifficultyChanged, 1);
}

private void OnDisable()
{
    _difficultySub?.Dispose();
}

private void OnDifficultyChanged(int difficulty)
{
    switch (difficulty)
    {
        case 0: ApplyEasyMode(); break;
        case 1: ApplyNormalMode(); break;
        case 2: ApplyHardMode(); break;
    }
}
```

**Pattern 6: Checking if Value Was Set**

```csharp
[SerializeField] private Vector3SignalChannel onSpawnPointChanged;

private BufferedSubscription<Vector3> _spawnSub;

private void OnEnable()
{
    _spawnSub = onSpawnPointChanged.SubscribeBuffered(OnSpawnPointChanged, Vector3.zero);

    // Check if spawn point was actually set
    if (_spawnSub.HasValue)
    {
        Debug.Log("Spawn point was set via signal");
        transform.position = _spawnSub.CurrentValue;
    }
    else
    {
        Debug.Log("Using default spawn point");
    }
}

private void OnDisable()
{
    _spawnSub?.Dispose();
}

private void OnSpawnPointChanged(Vector3 position)
{
    transform.position = position;
}
```

**Pattern 7: Querying State Without Callback**

```csharp
[SerializeField] private BoolSignalChannel onGamePausedChanged;

private BufferedSubscription<bool> _pauseSub;

private void OnEnable()
{
    // Subscribe to pause state changes
    _pauseSub = onGamePausedChanged.SubscribeBuffered(OnPauseStateChanged, false);
}

private void OnDisable()
{
    _pauseSub?.Dispose();
}

private void Update()
{
    // Query current pause state anytime
    if (_pauseSub.CurrentValue)
    {
        // Game is paused
        return;
    }

    // Normal game logic
    ProcessGameplay();
}

private void OnPauseStateChanged(bool isPaused)
{
    pauseMenu.SetActive(isPaused);
}
```

## Default Values

Always provide a sensible default value when subscribing:

```csharp
// Good defaults
onHealthChanged.SubscribeBuffered(UpdateHealth, defaultValue: 100);
onVolumeChanged.SubscribeBuffered(UpdateVolume, defaultValue: 0.8f);
onGameModeChanged.SubscribeBuffered(UpdateMode, defaultValue: "Normal");

// Avoid relying on default(T)
// default(int) = 0, but is 0 health a sensible default?
onHealthChanged.SubscribeBuffered(UpdateHealth); // No default specified
```

## When NOT to Use Buffered Subscriptions

Buffered subscriptions aren't appropriate when:

- **One-time events** - Use regular subscription or one-shot for events
- **No current state** - Events without persistent state don't need buffering
- **High-frequency updates** - Buffering adds overhead for rapidly changing values
- **Memory concerns** - Each buffered subscription stores a value copy

## Performance Notes

- Buffered subscriptions have minimal overhead
- Each subscription stores a copy of the last value
- Immediate invocation on subscribe may trigger expensive operations
- More efficient than polling or manual state queries

## Related Features

- [**Priority System**](/docs/features/priority) - Control listener execution order
- [**One-Shot Listeners**](/docs/features/one-shot) - Auto-unsubscribe after first raise

## Next Steps

- [**Event Throttling**](/docs/features/throttling) - Learn about cooldowns between raises
- [**All Channel Types**](/docs/channels) - Explore all signal channels
