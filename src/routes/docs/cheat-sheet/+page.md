# Quick Reference

A quick reference guide for common SignalKit patterns and syntax.

## Namespace Imports

```csharp
using UnityEngine;
using SignalKit.Runtime.Core;
using SignalKit.Runtime.Core.Channels;
using SignalKit.Runtime.Core.Listeners;
```

## Creating Signal Channels

### In Unity Editor

1. Right-click in Project window
2. `Create > SignalKit > Channels > [Type] Signal Channel`
3. Name it descriptively (e.g., "PlayerDiedSignal")

### Built-in Channel Types

| Channel Type | Use Case | Example |
|--------------|----------|---------|
| `VoidSignalChannel` | Simple events, no data | Game started, player died |
| `BoolSignalChannel` | True/false states | Door locked/unlocked |
| `IntSignalChannel` | Integer values | Score changed, ammo count |
| `FloatSignalChannel` | Decimal values | Health percentage, timer |
| `DoubleSignalChannel` | High precision decimals | Scientific calculations, large numbers |
| `StringSignalChannel` | Text data | Player name, message |
| `Vector2SignalChannel` | 2D positions | Touch position, UI anchors |
| `Vector2IntSignalChannel` | 2D integer positions | Grid coordinates, tile positions |
| `Vector3SignalChannel` | 3D positions | Spawn point, world position |
| `Vector3IntSignalChannel` | 3D integer positions | Voxel coordinates, chunk indices |
| `QuaternionSignalChannel` | Rotation data | Camera rotation, object orientation |
| `ColorSignalChannel` | Color values | UI theme color, lighting changes |
| `GameObjectSignalChannel` | GameObject references | Enemy spawned, item picked up |
| `TransformSignalChannel` | Transform references | Target position, look-at target |

## Raising Signals

### Void Signal (No Data)

```csharp
public class GameManager : MonoBehaviour
{
    [SerializeField] private VoidSignalChannel gameStartedSignal;

    private void Start()
    {
        gameStartedSignal.Raise();
    }
}
```

### Typed Signal (With Data)

```csharp
public class Player : MonoBehaviour
{
    [SerializeField] private IntSignalChannel scoreChangedSignal;
    [SerializeField] private FloatSignalChannel healthChangedSignal;

    public void AddScore(int points)
    {
        scoreChangedSignal.Raise(points);
    }

    public void TakeDamage(float damage)
    {
        healthChangedSignal.Raise(damage);
    }
}
```

## Listening to Signals

### Via Code (Recommended for Logic)

```csharp
public class ScoreDisplay : MonoBehaviour
{
    [SerializeField] private IntSignalChannel scoreChangedSignal;
    private int totalScore = 0;

    private void OnEnable()
    {
        // Subscribe when enabled
        scoreChangedSignal.OnRaised += OnScoreChanged;
    }

    private void OnDisable()
    {
        // ALWAYS unsubscribe when disabled
        scoreChangedSignal.OnRaised -= OnScoreChanged;
    }

    private void OnScoreChanged(int points)
    {
        totalScore += points;
        Debug.Log($"New score: {totalScore}");
    }
}
```

### Void Signal Handler

```csharp
public class GameController : MonoBehaviour
{
    [SerializeField] private VoidSignalChannel gameStartedSignal;

    private void OnEnable()
    {
        gameStartedSignal.OnRaised += OnGameStarted;
    }

    private void OnDisable()
    {
        gameStartedSignal.OnRaised -= OnGameStarted;
    }

    private void OnGameStarted(Unit _)
    {
        // Unit is like "void" for generic types
        Debug.Log("Game started!");
    }
}
```

### Via Inspector (Quick Setup)

1. Add `SignalListener` component to GameObject
2. Assign the channel in the Inspector
3. Add response under `On Signal Raised`
4. Drag target GameObject and select method

> [!TIP]
> Use Inspector listeners for simple UI updates and code listeners for complex game logic.

## Common Patterns

### One Script Raises, Many Listen

```csharp
// PlayerHealth.cs - Raises the signal
public class PlayerHealth : MonoBehaviour
{
    [SerializeField] private VoidSignalChannel playerDiedSignal;

    public void Die()
    {
        playerDiedSignal.Raise();
    }
}

// UIManager.cs - Listens and shows game over
public class UIManager : MonoBehaviour
{
    [SerializeField] private VoidSignalChannel playerDiedSignal;

    private void OnEnable() => playerDiedSignal.OnRaised += ShowGameOver;
    private void OnDisable() => playerDiedSignal.OnRaised -= ShowGameOver;

    private void ShowGameOver(Unit _) { /* Show UI */ }
}

// AudioManager.cs - Listens and plays sound
public class AudioManager : MonoBehaviour
{
    [SerializeField] private VoidSignalChannel playerDiedSignal;

    private void OnEnable() => playerDiedSignal.OnRaised += PlayDeathSound;
    private void OnDisable() => playerDiedSignal.OnRaised -= PlayDeathSound;

    private void PlayDeathSound(Unit _) { /* Play audio */ }
}
```

### Passing Complex Data

```csharp
// For complex data, use GameObject or custom types
[SerializeField] private GameObjectSignalChannel enemySpawnedSignal;

public void SpawnEnemy(GameObject enemy)
{
    enemySpawnedSignal.Raise(enemy);
}

// Listener
private void OnEnemySpawned(GameObject enemy)
{
    Debug.Log($"Enemy spawned: {enemy.name}");
}
```

### Testing Without Dependencies

```csharp
public class Weapon : MonoBehaviour
{
    [SerializeField] private IntSignalChannel ammoChangedSignal;

    public void Fire()
    {
        // No direct dependencies - easy to test!
        ammoChangedSignal?.Raise(currentAmmo);
    }
}
```

## Best Practices

> [!IMPORTANT]
> **Memory Management**
>
> - ✅ **DO**: Subscribe in `OnEnable()`, unsubscribe in `OnDisable()`
> - ❌ **DON'T**: Subscribe in `Start()` and forget to unsubscribe
> - ❌ **DON'T**: Subscribe multiple times without unsubscribing

### Naming Conventions

```csharp
// Good - Descriptive and clear
PlayerDiedSignal
ScoreChangedSignal
EnemySpawnedSignal
DoorOpenedSignal

// Bad - Vague and unclear
Signal1
EventChannel
MySignal
```

### Organization

```
Assets/
  Signals/
    Player/
      PlayerDiedSignal.asset
      PlayerHealthChangedSignal.asset
    UI/
      ButtonClickedSignal.asset
      MenuOpenedSignal.asset
    Gameplay/
      WaveCompletedSignal.asset
      GameOverSignal.asset
```

### Channel Descriptions

Always add descriptions in the Inspector to document what each channel does:

```
Description: "Raised when the player's health reaches zero.
Used by UI, audio, and game state systems."
```

## Debugging

### View Active Signals

1. Open `Window > SignalKit > Debugger`
2. Press Play
3. Watch signals being raised in real-time
4. Click to ping the channel in Project

> [!TIP]
> For detailed troubleshooting and solutions to common problems, see the [Troubleshooting Guide](/docs/troubleshooting).

## Keyboard Shortcuts

SignalKit provides keyboard shortcuts to speed up your workflow. All global shortcuts can be customized in Unity via `Edit > Shortcuts > SignalKit`.

### Global Shortcuts

| Action | Windows/Linux | macOS | Description |
|--------|---------------|-------|-------------|
| Open Signal Debugger | `Ctrl+Shift+D` | `⌘+Shift+D` | Opens the SignalKit Debugger window |
| Open Signal Recording | `Ctrl+Alt+R` | `⌘+⌥+R` | Opens the Signal Recording window |
| Raise Selected Channel | `Ctrl+Alt+Shift+R` | `⌘+⌥+Shift+R` | Raises the currently selected channel (Play mode only) |
| Toggle Favorite | `Ctrl+Alt+Shift+F` | `⌘+⌥+Shift+F` | Add/remove selected channel or group to favorites |

### Debugger Window Shortcuts

When the Debugger window is focused:

| Shortcut | Action |
|----------|--------|
| `Delete` | Clear log |
| `Space` | Pause/Resume |

### Recording Window Shortcuts

When the Recording window is focused (Play mode only):

| Shortcut | Action |
|----------|--------|
| `R` | Start/Stop recording |
| `Space` | Play/Pause playback |
| `←` / `→` | Step backward/forward |
| `L` | Toggle loop |

> [!TIP]
> Select a channel in the Project window and press `Ctrl+Alt+Shift+R` during Play mode to quickly test it without opening the Inspector.

## Next Steps

- **[Core Concepts](/docs/core-concepts)** - Deep dive into architecture
- **[Channels](/docs/channels)** - Learn about all channel types
- **[Listeners](/docs/listeners)** - Master listener patterns
- **[Editor Tools](/docs/editor-tools)** - Explore debugging tools
