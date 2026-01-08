# Double Signal Channel

**DoubleSignalChannel** broadcasts high-precision floating-point values - perfect for scientific calculations, precise timers, and any data requiring more than 7 decimal digits of accuracy.

## When to Use Double Signals

Use DoubleSignalChannel when you need high-precision decimal values:

- **Scientific Calculations** - Physics simulations requiring precision beyond float
- **Financial Systems** - Currency calculations requiring exact precision
- **High-Precision Timers** - Timestamps, precise elapsed time measurements
- **Astronomical Values** - Large distances or values requiring high accuracy
- **GPS Coordinates** - Latitude/longitude requiring precise positioning

## Code Example

**Raising a double signal:**

```csharp
using SignalKit.Runtime.Core.Channels;

[SerializeField] private DoubleSignalChannel onPreciseTimeChanged;

// Raise the signal with a double value
onPreciseTimeChanged.Raise(123.456789012345);
```

**Listening to a double signal:**

```csharp
using SignalKit.Runtime.Core.Channels;

[SerializeField] private DoubleSignalChannel onPreciseTimeChanged;

private void OnEnable()
{
    onPreciseTimeChanged.OnRaised += HandleTimeChange;
}

private void OnDisable()
{
    onPreciseTimeChanged.OnRaised -= HandleTimeChange;
}

private void HandleTimeChange(double time)
{
    Debug.Log($"Precise time: {time:F10}");
}
```

## Best Practices

### Do:
- **Use for high-precision needs** - When float's ~7 digits aren't enough
- **Document precision requirements** - Explain why double is needed over float
- **Use for scientific accuracy** - Physics, astronomy, financial calculations
- **Consider memory cost** - Double uses 8 bytes vs float's 4 bytes

### Don't:
- **Don't use by default** - Float is sufficient for most game dev needs
- **Don't use for every frame** - Double signals have overhead; avoid `Update()` raises
- **Don't compare doubles with ==** - Use epsilon comparisons for equality checks
- **Don't use when float suffices** - Extra precision comes with memory/performance cost

## When NOT to Use Double Signals

Double signals aren't appropriate when:

- **Float precision is enough** - Use `FloatSignalChannel` for most game values (saves memory)
- **You need whole numbers** - Use `IntSignalChannel` instead
- **Updates every frame** - Use direct property access or `Update()` instead
- **No data is needed** - Use `VoidSignalChannel` for simple events

## Common Patterns

**Pattern 1: High-Precision Timer**

```csharp
[SerializeField] private DoubleSignalChannel onElapsedTime;

private double startTime;

private void Start()
{
    startTime = Time.realtimeSinceStartupAsDouble;
}

private void Update()
{
    double elapsed = Time.realtimeSinceStartupAsDouble - startTime;
    onElapsedTime.Raise(elapsed);
}
```

**Pattern 2: GPS Coordinates**

```csharp
[SerializeField] private DoubleSignalChannel onLatitudeChanged;
[SerializeField] private DoubleSignalChannel onLongitudeChanged;

public void UpdateLocation(double lat, double lon)
{
    onLatitudeChanged.Raise(lat);   // e.g., 37.7749295
    onLongitudeChanged.Raise(lon);  // e.g., -122.4194155
}
```

**Pattern 3: Scientific Calculation**

```csharp
[SerializeField] private DoubleSignalChannel onDistanceCalculated;

private void CalculateAstronomicalDistance()
{
    double distanceInMeters = 149597870700.0; // Earth to Sun
    onDistanceCalculated.Raise(distanceInMeters);
}
```

**Pattern 4: Financial Precision**

```csharp
[SerializeField] private DoubleSignalChannel onCurrencyChanged;

private void ProcessTransaction(double amount)
{
    // Precise financial calculations
    double taxedAmount = amount * 1.0825; // 8.25% tax
    onCurrencyChanged.Raise(taxedAmount);
}
```

## Related Channels

When double isn't quite right:

- [**Float Signal**](/docs/channels/float) - For standard game values (saves memory)
- [**Int Signal**](/docs/channels/int) - For whole numbers
- [**Void Signal**](/docs/channels/void) - For events without data

## Next Steps

- [**String Signals**](/docs/channels/string) - Learn about text-based signals
- [**All Channel Types**](/docs/channels) - Explore all 15 signal channels
