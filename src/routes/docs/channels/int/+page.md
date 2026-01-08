# Int Signal Channel

**IntSignalChannel** broadcasts integer values - perfect for scores, health points, currency, counts, and any numeric game data that uses whole numbers.

## When to Use Int Signals

Use IntSignalChannel when you need to broadcast integer values to multiple systems:

- **Score Systems** - Points from kills, pickups, objectives
- **Health & Damage** - HP changes, damage amounts
- **Currency** - Coins collected, money spent, resources gained
- **Counters** - Enemy count, item quantities, wave numbers
- **IDs** - Player IDs, team numbers, item type IDs

## Code Example

**Raising an int signal:**

```csharp
using SignalKit.Runtime.Core.Channels;

[SerializeField] private IntSignalChannel onScoreChanged;

// Raise the signal with an integer value
onScoreChanged.Raise(10);  // +10 points
onScoreChanged.Raise(-5);  // -5 points (damage, cost, etc.)
```

**Listening to an int signal:**

```csharp
using SignalKit.Runtime.Core.Channels;

[SerializeField] private IntSignalChannel onScoreChanged;

private void OnEnable()
{
    onScoreChanged.OnRaised += HandleScoreChange;
}

private void OnDisable()
{
    onScoreChanged.OnRaised -= HandleScoreChange;
}

private void HandleScoreChange(int points)
{
    Debug.Log($"Score changed by {points} points!");
}
```

## Best Practices

### Do:
- **Use descriptive names** - `OnScoreChanged` is clearer than `ScoreSignal`
- **Document the meaning** - Is the value a delta or a total? Positive or negative?
- **Use separate signals for delta vs total** - `OnScoreChanged` (points earned) vs `OnTotalScoreUpdated` (cumulative)
- **Validate ranges** - Check for negative values if they're not allowed

### Don't:
- **Don't use for every frame** - Int signals have overhead; avoid `Update()` raises
- **Don't forget negative values** - Handle cases where the int might be negative (damage, cost)
- **Don't use for decimals** - If you need fractional values, use `FloatSignalChannel`

## When NOT to Use Int Signals

Int signals aren't appropriate when:

- **You need decimals** - Use `FloatSignalChannel` or `DoubleSignalChannel` instead
- **Updates every frame** - Use direct property access or `Update()` instead
- **You need complex data** - Use custom signal channels for structs/classes
- **No data is needed** - Use `VoidSignalChannel` for simple events

## Common Patterns

**Pattern 1: Delta vs Total**

```csharp
// Use two signals - one for changes, one for the total
[SerializeField] private IntSignalChannel onScoreChanged;     // Delta
[SerializeField] private IntSignalChannel onTotalScoreUpdated; // Total

private int totalScore = 0;

private void HandleScoreChange(int points)
{
    totalScore += points;
    onTotalScoreUpdated.Raise(totalScore);
}
```

**Pattern 2: Multiple Publishers**

```csharp
// Different sources raise the same signal with different values
onScoreChanged.Raise(10);  // Enemy killed
onScoreChanged.Raise(5);   // Coin collected
onScoreChanged.Raise(100); // Objective completed
```

**Pattern 3: Damage System**

```csharp
[SerializeField] private IntSignalChannel onDamageDealt;

// Publisher
public void Attack()
{
    onDamageDealt.Raise(25);
}

// Listener
private void TakeDamage(int damage)
{
    health -= damage;
    Debug.Log($"Took {damage} damage. Health: {health}");
}
```

**Pattern 4: Achievement Milestones**

```csharp
private void CheckAchievements(int totalScore)
{
    if (totalScore >= 100 && !achievement100Unlocked)
    {
        achievement100Unlocked = true;
        Debug.Log("🏆 Achievement Unlocked!");
    }
}
```

## Related Channels

When int isn't quite right:

- [**Float Signal**](/docs/channels/float) - For decimal values and percentages
- [**Void Signal**](/docs/channels/void) - For events without data
- [**String Signal**](/docs/channels/string) - For text messages or IDs

## Next Steps

- [**Float Signals**](/docs/channels/float) - Learn about floating-point signals for progress bars and timers
- [**All Channel Types**](/docs/channels) - Explore all 15 signal channels
