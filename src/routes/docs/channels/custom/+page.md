# Custom Signal Channels

Need to broadcast your own data types? SignalKit lets you create custom signal channels for any C# type - from simple structs to complex classes.

## When to Create Custom Channels

Create custom signal channels when the built-in 14 channels don't fit your needs:

- **Custom Data Structures** - Player stats, item data, quest information
- **Complex Events** - Damage events with attacker/victim/type, transaction data
- **Domain-Specific Data** - Card data, unit stats, building information
- **Composite Data** - Multiple values that belong together

## Creating a Custom Channel

### Step 1: Define Your Data Type

```csharp
using System;
using UnityEngine;

[Serializable]
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

### Step 2: Create the Signal Channel

```csharp
using SignalKit.Runtime.Core.Channels;
using UnityEngine;

[CreateAssetMenu(fileName = "DamageSignal", menuName = "SignalKit/Channels/Damage Signal")]
public class DamageSignalChannel : SignalChannel<DamageData>
{
    // That's it! The base class handles everything
}
```

### Step 3: Use Your Custom Channel

**Raising the signal:**

```csharp
using UnityEngine;
using SignalKit.Runtime.Core.Channels;

public class Weapon : MonoBehaviour
{
    [SerializeField] private DamageSignalChannel onDamageDealt;

    public void DealDamage(GameObject victim, Vector3 hitPoint)
    {
        DamageData damageData = new DamageData
        {
            attacker = gameObject,
            victim = victim,
            damageAmount = 25,
            hitPoint = hitPoint,
            damageType = DamageType.Physical
        };

        onDamageDealt.Raise(damageData);
    }
}
```

**Listening to the signal:**

```csharp
using UnityEngine;

public class CombatLogger : MonoBehaviour
{
    [SerializeField] private DamageSignalChannel onDamageDealt;

    private void OnEnable()
    {
        onDamageDealt.OnRaised += LogDamage;
    }

    private void OnDisable()
    {
        onDamageDealt.OnRaised -= LogDamage;
    }

    private void LogDamage(DamageData data)
    {
        Debug.Log($"{data.attacker.name} dealt {data.damageAmount} {data.damageType} damage to {data.victim.name}");
    }
}
```

## Best Practices

### Do:
- **Use [Serializable]** - Mark your data type as serializable for Inspector support
- **Keep data immutable** - Use structs or readonly properties when possible
- **Use descriptive names** - `DamageSignalChannel` is clearer than `CustomSignal`
- **Add CreateAssetMenu** - Makes it easy to create channel assets in Unity

### Don't:
- **Don't use for simple types** - Use built-in channels (Int, Float, etc.) when possible
- **Don't put logic in data** - Keep your data types simple; logic goes in listeners
- **Don't forget serialization** - Mark fields as public or use `[SerializeField]`
- **Don't make it too complex** - If your data type has 10+ fields, consider breaking it down

## Common Examples

### Example 1: Item Data Channel

```csharp
[Serializable]
public struct ItemData
{
    public string itemName;
    public int itemId;
    public int quantity;
    public Sprite icon;
}

[CreateAssetMenu(fileName = "ItemSignal", menuName = "SignalKit/Channels/Item Signal")]
public class ItemSignalChannel : SignalChannel<ItemData>
{
}
```

### Example 2: Quest Event Channel

```csharp
[Serializable]
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

[CreateAssetMenu(fileName = "QuestSignal", menuName = "SignalKit/Channels/Quest Signal")]
public class QuestSignalChannel : SignalChannel<QuestEvent>
{
}
```

### Example 3: Transaction Data Channel

```csharp
[Serializable]
public struct TransactionData
{
    public int itemId;
    public int quantity;
    public int cost;
    public TransactionType type;
}

public enum TransactionType
{
    Buy,
    Sell,
    Trade
}

[CreateAssetMenu(fileName = "TransactionSignal", menuName = "SignalKit/Channels/Transaction Signal")]
public class TransactionSignalChannel : SignalChannel<TransactionData>
{
}
```

### Example 4: Player Stats Channel

```csharp
[Serializable]
public struct PlayerStats
{
    public int health;
    public int maxHealth;
    public int stamina;
    public int maxStamina;
    public float moveSpeed;
    public int level;
}

[CreateAssetMenu(fileName = "PlayerStatsSignal", menuName = "SignalKit/Channels/Player Stats Signal")]
public class PlayerStatsSignalChannel : SignalChannel<PlayerStats>
{
}
```

## Advanced: Using Classes

You can also use classes instead of structs (useful for reference types):

```csharp
[Serializable]
public class InventoryChangeData
{
    public List<ItemData> addedItems;
    public List<ItemData> removedItems;
    public int totalWeight;

    public InventoryChangeData(List<ItemData> added, List<ItemData> removed, int weight)
    {
        addedItems = added;
        removedItems = removed;
        totalWeight = weight;
    }
}

[CreateAssetMenu(fileName = "InventorySignal", menuName = "SignalKit/Channels/Inventory Signal")]
public class InventorySignalChannel : SignalChannel<InventoryChangeData>
{
}
```

> [!NOTE]
> Classes are reference types and use more memory than structs. Use structs for small, immutable data types and classes for complex data with inheritance or reference semantics.

## When to Use Built-in vs Custom Channels

**Use Built-in Channels:**
- Single values (int, float, bool, string)
- Unity types (Vector2, Vector3, Color, Quaternion)
- Object references (GameObject, Transform)

**Use Custom Channels:**
- Multiple related values that should travel together
- Domain-specific game data (damage, items, quests)
- Complex events requiring context (who, what, where, when)

## Related Documentation

- [**All Channel Types**](/docs/channels) - See all 14 built-in channels
- [**Quick Start Guide**](/docs/quick-start) - Learn SignalKit basics

## Next Steps

Now that you know all channel types, explore advanced features:

- [**Priority System**](/docs/features/priority) - Control listener execution order
- [**Filters**](/docs/features/filters) - Conditional listening
- [**One-Shot Listeners**](/docs/features/one-shot) - Auto-unsubscribe after first raise
