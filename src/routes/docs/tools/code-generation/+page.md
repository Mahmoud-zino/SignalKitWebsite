# Code Generation

Automatically generate SignalChannels and SignalListeners for custom types using the `[GenerateSignal]` attribute. No manual boilerplate needed.

## When to Use Code Generation

Use code generation when you need custom signal types:

- **Custom Data Types** - Generate channels for your game-specific structs/classes
- **Reduce Boilerplate** - Avoid manually writing repetitive channel/listener code
- **Type Safety** - Ensure channels and listeners match your data types
- **Project Organization** - Automatically place generated files in custom folders
- **Rapid Prototyping** - Quickly add signal support to new types

## How It Works

- **Attribute-based** - Mark types with `[GenerateSignal]`
- **Manual generation** - Run "SignalKit → Regenerate All" menu command
- **Customizable** - Control namespace, menu path, and output folder
- **Two artifacts** - Generates SignalChannel&lt;T&gt; and SignalListener&lt;T&gt; classes

## Code Example

**Basic code generation:**

```csharp
using System;
using SignalKit.Runtime.CodeGen;
using UnityEngine;

[Serializable]
[GenerateSignal]
public struct PlayerStats
{
    public int health;
    public int maxHealth;
    public int stamina;
    public int maxStamina;
    public float moveSpeed;
}
```

**After adding the attribute, run:**
- Unity Menu: **SignalKit → Regenerate All**

**Generated files:**
- `PlayerStatsSignalChannel.cs` - Channel for broadcasting PlayerStats
- `PlayerStatsSignalListener.cs` - MonoBehaviour listener with UnityEvent

**Custom configuration:**

```csharp
using SignalKit.Runtime.CodeGen;
using System;

[Serializable]
[GenerateSignal(
    Channel = true,
    Listener = true,
    MenuPath = "Game/Player/Player Stats Signal",
    Namespace = "MyGame.Signals",
    OutputFolder = "Assets/MyGame/Signals/Generated"
)]
public struct PlayerStats
{
    public int health;
    public int stamina;
}
```

## GenerateSignal Attribute Options

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `Channel` | bool | true | Generate SignalChannel class |
| `Listener` | bool | true | Generate SignalListener component |
| `MenuPath` | string | auto | Unity menu path for CreateAssetMenu |
| `Namespace` | string | null | Namespace for generated classes |
| `OutputFolder` | string | "Assets/SignalKit/Generated" | Where to save generated files |

## Best Practices

### Do:
- **Mark types as [Serializable]** - Required for Unity serialization
- **Use descriptive type names** - Generated classes use the type name
- **Organize output folders** - Use OutputFolder to keep generated code organized
- **Add XML comments** - Comments on types appear in generated code
- **Manually regenerate after changes** - Run "SignalKit → Regenerate All" when type changes

### Don't:
- **Don't hand-edit generated files** - They'll be overwritten on regeneration
- **Don't forget [Serializable]** - Generated channels won't work without it
- **Don't use generic types** - Code generation doesn't support generic types
- **Don't use nested types** - Keep types at top level for best results

## Common Patterns

**Pattern 1: Game Event Data**

```csharp
using System;
using SignalKit.Runtime.CodeGen;
using UnityEngine;

[Serializable]
[GenerateSignal(
    MenuPath = "Game/Events/Quest Event",
    Namespace = "MyGame.Events"
)]
public struct QuestEvent
{
    public int questId;
    public string questName;
    public QuestStatus status;
    public float progress;
}

public enum QuestStatus
{
    Started,
    InProgress,
    Completed,
    Failed
}
```

**Pattern 2: Combat Data**

```csharp
using System;
using SignalKit.Runtime.CodeGen;
using UnityEngine;

[Serializable]
[GenerateSignal(
    MenuPath = "Game/Combat/Damage Data",
    Namespace = "MyGame.Combat"
)]
public struct DamageData
{
    public GameObject attacker;
    public GameObject victim;
    public int damageAmount;
    public Vector3 hitPoint;
    public DamageType damageType;
}

public enum DamageType
{
    Physical,
    Fire,
    Ice,
    Poison
}
```

**Pattern 3: UI Events**

```csharp
using System;
using SignalKit.Runtime.CodeGen;

[Serializable]
[GenerateSignal(
    MenuPath = "Game/UI/Button Event",
    Namespace = "MyGame.UI",
    OutputFolder = "Assets/MyGame/UI/Signals"
)]
public struct ButtonClickEvent
{
    public string buttonId;
    public int clickCount;
}
```

**Pattern 4: Network Messages**

```csharp
using System;
using SignalKit.Runtime.CodeGen;

[Serializable]
[GenerateSignal(
    MenuPath = "Game/Network/Player Position",
    Namespace = "MyGame.Network"
)]
public struct PlayerPositionMessage
{
    public int playerId;
    public Vector3 position;
    public Quaternion rotation;
    public float timestamp;
}
```

**Pattern 5: Channel Only (No Listener)**

```csharp
using System;
using SignalKit.Runtime.CodeGen;

[Serializable]
[GenerateSignal(
    Channel = true,
    Listener = false,  // Don't generate listener component
    MenuPath = "Game/Internal/System Event"
)]
public struct InternalSystemEvent
{
    public string eventName;
    public int eventCode;
}
```

**Pattern 6: Listener Only (No Channel)**

```csharp
using System;
using SignalKit.Runtime.CodeGen;

// Useful if you want to use an existing channel
[Serializable]
[GenerateSignal(
    Channel = false,  // Don't generate channel
    Listener = true,
    Namespace = "MyGame.Listeners"
)]
public struct CustomEvent
{
    public string data;
}
```

## Generated Code Example

**Input:**

```csharp
[Serializable]
[GenerateSignal]
public struct PlayerStats
{
    public int health;
    public int stamina;
}
```

**Generated Channel (PlayerStatsSignalChannel.cs):**

```csharp
using SignalKit.Runtime.Core.Channels;
using UnityEngine;

[CreateAssetMenu(
    fileName = "PlayerStatsSignal",
    menuName = "SignalKit/Channels/Player Stats Signal"
)]
public class PlayerStatsSignalChannel : SignalChannel<PlayerStats>
{
}
```

**Generated Listener (PlayerStatsSignalListener.cs):**

```csharp
using SignalKit.Runtime.Core.Listeners;
using UnityEngine;
using UnityEngine.Events;

[AddComponentMenu("SignalKit/Listeners/Player Stats Signal Listener")]
public class PlayerStatsSignalListener : SignalListener<PlayerStats>
{
    [Space(8)]
    [Tooltip("Response invoked when the signal is raised")]
    public UnityEvent<PlayerStats> onSignalRaised = new();

    protected override void InvokeResponse(PlayerStats value)
    {
        onSignalRaised.Invoke(value);
    }
}
```

## Regenerating Code

To regenerate after modifying a type:

1. **Manual:** SignalKit → Regenerate All (in Unity menu)
2. **After changes:** You must manually regenerate when modifying types
3. **Force:** Delete generated files and run regenerate

## Organizing Generated Code

**Recommended folder structure:**

```
Assets/
├── MyGame/
│   ├── Events/
│   │   ├── QuestEvent.cs
│   │   └── Generated/
│   │       ├── QuestEventSignalChannel.cs
│   │       └── QuestEventSignalListener.cs
│   ├── Combat/
│   │   ├── DamageData.cs
│   │   └── Generated/
│   │       ├── DamageDataSignalChannel.cs
│   │       └── DamageDataSignalListener.cs
```

Use `OutputFolder` parameter to control location:

```csharp
[GenerateSignal(
    OutputFolder = "Assets/MyGame/Events/Generated"
)]
```

## When NOT to Use Code Generation

Code generation isn't appropriate when:

- **Built-in types are sufficient** - Use the 14 built-in channels instead
- **Type changes frequently** - Manual control may be better
- **Complex inheritance** - Generated code may not handle inheritance well
- **Need custom behavior** - Write channel/listener manually for custom logic

## Troubleshooting

**Generated files not appearing:**
- Run "SignalKit → Regenerate All" from Unity menu
- Check Unity console for errors
- Ensure type is marked `[Serializable]`
- Check OutputFolder path is valid

**Compilation errors:**
- Ensure type has no generic parameters
- Check namespace doesn't conflict
- Verify all referenced types are accessible

**Menu items missing:**
- Check MenuPath string is valid
- Refresh Unity (Assets → Refresh)
- Check generated file exists in OutputFolder

## Performance Notes

- Code generation happens manually in Editor (no runtime cost)
- Generated code is identical to hand-written channels
- No overhead compared to manual channel creation
- Regeneration is fast (milliseconds per type)
- No automatic regeneration means no compile-time slowdown

## Related Features

- [**Custom Channels**](/docs/channels/custom) - Manually creating custom channels
- [**Priority System**](/docs/features/priority) - Control listener execution order

## Next Steps

- [**Recording & Playback**](/docs/tools/recording) - Learn about debugging with signal recording
- [**All Channel Types**](/docs/channels) - Explore all built-in signal channels
