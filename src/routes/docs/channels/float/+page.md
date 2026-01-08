# Float Signal Channel

**FloatSignalChannel** broadcasts floating-point values - perfect for progress bars, timers, percentages, and any numeric data that needs decimal precision.

## When to Use Float Signals

Use FloatSignalChannel when you need to broadcast decimal values to multiple systems:

- **Progress Bars** - Loading progress, health bars, experience bars
- **Timers** - Countdown timers, cooldowns, elapsed time
- **Percentages** - Accuracy, completion percentage, battery level
- **Physics Values** - Speed, velocity magnitude, distance
- **Volume & Audio** - Volume levels, fade amounts, pitch values

## Code Example

**Raising a float signal:**

```csharp
using SignalKit.Runtime.Core.Channels;

[SerializeField] private FloatSignalChannel onHealthChanged;

// Raise the signal with a float value
onHealthChanged.Raise(0.75f);  // 75% health
onHealthChanged.Raise(0.0f);   // Empty
onHealthChanged.Raise(1.0f);   // Full
```

**Listening to a float signal:**

```csharp
using SignalKit.Runtime.Core.Channels;

[SerializeField] private FloatSignalChannel onHealthChanged;

private void OnEnable()
{
    onHealthChanged.OnRaised += UpdateHealthBar;
}

private void OnDisable()
{
    onHealthChanged.OnRaised -= UpdateHealthBar;
}

private void UpdateHealthBar(float healthPercent)
{
    healthBar.fillAmount = healthPercent;
}
```

## Best Practices

### Do:
- **Use normalized values (0-1)** - Easier to work with for UI and interpolation
- **Clamp values** - Use `Mathf.Clamp01()` for percentages to avoid invalid ranges
- **Use descriptive names** - `OnHealthPercentChanged` vs `OnHealthChanged`
- **Consider precision** - Float gives ~7 decimal digits; usually enough for games

### Don't:
- **Don't use for every frame** - Float signals have overhead; avoid `Update()` raises
- **Don't compare floats with ==** - Use `Mathf.Approximately()` for float comparisons
- **Don't use for high-precision calculations** - Use `DoubleSignalChannel` if you need more than 7 digits
- **Don't forget to normalize** - Keep values in consistent ranges (0-1 or 0-100)

## When NOT to Use Float Signals

Float signals aren't appropriate when:

- **You need whole numbers** - Use `IntSignalChannel` instead (more efficient)
- **You need high precision** - Use `DoubleSignalChannel` for scientific calculations
- **Updates every frame** - Use direct property access or `Update()` instead
- **No data is needed** - Use `VoidSignalChannel` for simple events

## Common Patterns

**Pattern 1: Progress Bar**

```csharp
[SerializeField] private FloatSignalChannel onLoadingProgress;

// Publisher
private void UpdateProgress(float progress)
{
    onLoadingProgress.Raise(Mathf.Clamp01(progress));
}

// Listener
private void UpdateProgressBar(float progress)
{
    progressBar.fillAmount = progress;
    progressText.text = $"{progress * 100:F0}%";
}
```

**Pattern 2: Timer System**

```csharp
[SerializeField] private FloatSignalChannel onTimeRemaining;

// Countdown timer
private void Update()
{
    timeRemaining -= Time.deltaTime;
    if (timeRemaining <= 0)
    {
        onTimeRemaining.Raise(0f);
        // Stop timer
    }
}
```

**Pattern 3: Audio Volume**

```csharp
[SerializeField] private FloatSignalChannel onMasterVolumeChanged;

// Publisher
public void SetVolume(float volume)
{
    onMasterVolumeChanged.Raise(Mathf.Clamp01(volume));
}

// Listener
private void UpdateVolume(float volume)
{
    audioMixer.SetFloat("MasterVolume", Mathf.Log10(volume) * 20);
}
```

**Pattern 4: Health Percentage**

```csharp
[SerializeField] private FloatSignalChannel onHealthPercentChanged;

private void TakeDamage(int damage)
{
    currentHealth -= damage;
    float healthPercent = (float)currentHealth / maxHealth;
    onHealthPercentChanged.Raise(healthPercent);
}
```

## Related Channels

When float isn't quite right:

- [**Int Signal**](/docs/channels/int) - For whole numbers (more efficient)
- [**Double Signal**](/docs/channels/double) - For high-precision calculations
- [**Void Signal**](/docs/channels/void) - For events without data

## Next Steps

- [**Double Signals**](/docs/channels/double) - Learn about high-precision floating-point values
- [**All Channel Types**](/docs/channels) - Explore all 15 signal channels
