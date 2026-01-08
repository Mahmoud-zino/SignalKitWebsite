# One-Shot Listeners

One-shot listeners automatically unsubscribe after the first time they're invoked. Perfect for events that should only happen once, like tutorial triggers, achievements, or level unlocks.

## When to Use One-Shot Listeners

Use one-shot listeners for events that should only execute once:

- **Tutorial Triggers** - Show help text only on first interaction
- **Achievement Unlocks** - Award achievement only once
- **First-Time Events** - Welcome messages, initial setup, onboarding
- **Level Unlocks** - Unlock content on first completion
- **One-Time Rewards** - Grant bonus items only once

## How It Works

- **Automatic unsubscribe** - Listener removes itself after first invocation
- **No manual cleanup needed** - No need to call Dispose() manually
- **Combines with filters** - Filter must pass for one-shot to trigger
- **Combines with priorities** - One-shot respects priority order

## Code Example

**Basic one-shot listener:**

```csharp
using SignalKit.Runtime.Core.Channels;
using SignalKit.Runtime.Core.Subscribers;

[SerializeField] private VoidSignalChannel onPlayerDied;

private Subscription<Void> _firstDeathSub;

private void OnEnable()
{
    // Show tutorial only on first death
    _firstDeathSub = onPlayerDied.Subscribe(ShowDeathTutorial)
                                  .OneShot();
}

private void ShowDeathTutorial(Void _)
{
    // This will only execute ONCE
    Debug.Log("You died! Press R to respawn.");
}
```

**One-shot with data:**

```csharp
[SerializeField] private IntSignalChannel onScoreChanged;

private Subscription<int> _scoreReachedSub;

private void OnEnable()
{
    // Unlock achievement when score reaches 1000 (only once)
    _scoreReachedSub = onScoreChanged.Subscribe(UnlockHighScoreAchievement)
                                     .WithFilter(score => score >= 1000)
                                     .OneShot();
}

private void UnlockHighScoreAchievement(int score)
{
    // Only executes the FIRST time score >= 1000
    Debug.Log("Achievement unlocked: High Scorer!");
}
```

## Best Practices

### Do:
- **Use for first-time events** - Tutorial triggers, welcome messages, achievements
- **Document why it's one-shot** - Add comments explaining the one-time behavior
- **Combine with filters** - Use filters to control when the one-shot triggers
- **Store subscription if needed** - Keep reference if you need to manually dispose before trigger

### Don't:
- **Don't use for repeating events** - One-shot is for single execution only
- **Don't call Dispose() after trigger** - Listener auto-unsubscribes, no manual cleanup needed
- **Don't rely on timing** - One-shot triggers on first matching event, not first in time
- **Don't use with Update()** - One-shot is for signals, not frame-by-frame updates

## Common Patterns

**Pattern 1: Tutorial Trigger**

```csharp
[SerializeField] private VoidSignalChannel onPlayerJumped;

private Subscription<Void> _firstJumpSub;

private void OnEnable()
{
    // Show jump tutorial only once
    _firstJumpSub = onPlayerJumped.Subscribe(ShowJumpTutorial)
                                   .OneShot();
}

private void ShowJumpTutorial(Void _)
{
    tutorialUI.Show("Press SPACE to jump!");
}
```

**Pattern 2: Achievement System**

```csharp
[SerializeField] private IntSignalChannel onEnemiesKilled;

private Subscription<int> _achievement10Sub;
private Subscription<int> _achievement50Sub;
private Subscription<int> _achievement100Sub;

private void OnEnable()
{
    // Multiple one-shot achievements at different thresholds
    _achievement10Sub = onEnemiesKilled.Subscribe(Unlock10KillsAchievement)
                                       .WithFilter(count => count >= 10)
                                       .OneShot();

    _achievement50Sub = onEnemiesKilled.Subscribe(Unlock50KillsAchievement)
                                       .WithFilter(count => count >= 50)
                                       .OneShot();

    _achievement100Sub = onEnemiesKilled.Subscribe(Unlock100KillsAchievement)
                                        .WithFilter(count => count >= 100)
                                        .OneShot();
}

private void Unlock10KillsAchievement(int count)
{
    Debug.Log("Achievement: Novice Hunter");
}

private void Unlock50KillsAchievement(int count)
{
    Debug.Log("Achievement: Expert Hunter");
}

private void Unlock100KillsAchievement(int count)
{
    Debug.Log("Achievement: Master Hunter");
}
```

**Pattern 3: Level Unlock**

```csharp
[SerializeField] private IntSignalChannel onLevelCompleted;

private Subscription<int> _unlockLevel2Sub;
private Subscription<int> _unlockLevel3Sub;

private void OnEnable()
{
    // Unlock next level on first completion
    _unlockLevel2Sub = onLevelCompleted.Subscribe(UnlockLevel2)
                                       .WithFilter(level => level == 1)
                                       .OneShot();

    _unlockLevel3Sub = onLevelCompleted.Subscribe(UnlockLevel3)
                                       .WithFilter(level => level == 2)
                                       .OneShot();
}

private void UnlockLevel2(int completedLevel)
{
    levelManager.UnlockLevel(2);
    Debug.Log("Level 2 unlocked!");
}

private void UnlockLevel3(int completedLevel)
{
    levelManager.UnlockLevel(3);
    Debug.Log("Level 3 unlocked!");
}
```

**Pattern 4: First-Time Reward**

```csharp
[SerializeField] private VoidSignalChannel onGameCompleted;

private Subscription<Void> _firstCompletionSub;

private void OnEnable()
{
    // Grant bonus reward only on first completion
    _firstCompletionSub = onGameCompleted.Subscribe(GrantFirstCompletionBonus)
                                         .OneShot();
}

private void GrantFirstCompletionBonus(Void _)
{
    inventory.AddItem("Legendary Sword", 1);
    Debug.Log("First completion bonus: Legendary Sword!");
}
```

**Pattern 5: Welcome Message**

```csharp
[SerializeField] private VoidSignalChannel onPlayerSpawned;

private Subscription<Void> _welcomeSub;

private void OnEnable()
{
    // Show welcome message only on first spawn
    _welcomeSub = onPlayerSpawned.Subscribe(ShowWelcomeMessage)
                                  .OneShot();
}

private void ShowWelcomeMessage(Void _)
{
    uiManager.ShowNotification("Welcome to the game!");
}
```

**Pattern 6: Combining with Priority**

```csharp
[SerializeField] private VoidSignalChannel onBossFightStarted;

private Subscription<Void> _musicSub;
private Subscription<Void> _tutorialSub;

private void OnEnable()
{
    // Play boss music immediately (priority 0)
    _musicSub = onBossFightStarted.Subscribe(PlayBossMusic)
                                   .WithPriority(0);

    // Show tutorial on first boss fight (priority 100, one-shot)
    _tutorialSub = onBossFightStarted.Subscribe(ShowBossTutorial)
                                     .WithPriority(100)
                                     .OneShot();
}

private void PlayBossMusic(Void _)
{
    audioManager.PlayMusic("BossTheme");
}

private void ShowBossTutorial(Void _)
{
    tutorialUI.Show("Watch for the boss attack pattern!");
}
```

## When NOT to Use One-Shot Listeners

One-shot listeners aren't appropriate when:

- **Events repeat** - Use regular listeners for repeating events
- **You need control over unsubscribe** - Use regular listeners with manual Dispose()
- **State tracking is needed** - Use a counter or flag instead of one-shot
- **Multiple triggers needed** - One-shot only triggers once ever

## Manual Disposal

You can still manually dispose a one-shot listener before it triggers:

```csharp
private Subscription<int> _oneShotSub;

private void OnEnable()
{
    _oneShotSub = onScoreChanged.Subscribe(HandleScore)
                                .OneShot();
}

private void OnDisable()
{
    // Dispose if it hasn't triggered yet
    _oneShotSub?.Dispose();
}
```

## Performance Notes

- One-shot listeners have minimal overhead
- Automatic cleanup prevents memory leaks
- More efficient than manual flag checking
- Combines seamlessly with filters and priorities

## Related Features

- [**Priority System**](/docs/features/priority) - Control listener execution order
- [**Filters**](/docs/features/filters) - Conditional listening

## Next Steps

- [**Delayed Raising**](/docs/features/delayed-raising) - Learn about delayed signal raising
- [**All Channel Types**](/docs/channels) - Explore all signal channels
