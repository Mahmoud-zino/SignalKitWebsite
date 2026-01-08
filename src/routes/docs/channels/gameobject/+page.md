# GameObject Signal Channel

**GameObjectSignalChannel** broadcasts GameObject references - perfect for object spawning, selection, destruction events, and any situation where you need to pass object references between systems.

## When to Use GameObject Signals

Use GameObjectSignalChannel when you need to broadcast GameObject references:

- **Object Spawning** - Enemy spawned, projectile created, item dropped
- **Object Selection** - Player selected object, clicked entity, hovered target
- **Object Destruction** - Enemy destroyed, building demolished, item consumed
- **Object Interaction** - Object picked up, door opened, button pressed
- **Object Tracking** - Target acquired, focus changed, tracking lost

## Code Example

**Raising a GameObject signal:**

```csharp
using UnityEngine;
using SignalKit.Runtime.Core.Channels;

[SerializeField] private GameObjectSignalChannel onEnemySpawned;

// Raise the signal with a GameObject reference
GameObject enemy = Instantiate(enemyPrefab);
onEnemySpawned.Raise(enemy);
```

**Listening to a GameObject signal:**

```csharp
using UnityEngine;
using SignalKit.Runtime.Core.Channels;

[SerializeField] private GameObjectSignalChannel onEnemySpawned;

private void OnEnable()
{
    onEnemySpawned.OnRaised += TrackEnemy;
}

private void OnDisable()
{
    onEnemySpawned.OnRaised -= TrackEnemy;
}

private void TrackEnemy(GameObject enemy)
{
    activeEnemies.Add(enemy);
}
```

## Best Practices

### Do:
- **Use descriptive names** - `OnEnemySpawned` is clearer than `GameObjectSignal`
- **Check for null** - Always validate the GameObject isn't null before using it
- **Document ownership** - Clarify who owns/manages the GameObject lifecycle
- **Use for object events** - Perfect for spawn, destroy, select, interact events

### Don't:
- **Don't use for every frame** - GameObject signals have overhead; avoid `Update()` raises
- **Don't forget null checks** - Objects may be destroyed before listeners process them
- **Don't leak references** - Make sure to clear references when objects are destroyed
- **Don't use for data** - If you only need position/rotation, use Vector3/Quaternion channels

## When NOT to Use GameObject Signals

GameObject signals aren't appropriate when:

- **You only need position/rotation** - Use `Vector3SignalChannel` or `QuaternionSignalChannel` instead
- **You need Transform component** - Use `TransformSignalChannel` for transform references
- **Updates every frame** - Use direct references or `Update()` instead
- **No data is needed** - Use `VoidSignalChannel` for simple events

## Common Patterns

**Pattern 1: Enemy Spawn Tracking**

```csharp
[SerializeField] private GameObjectSignalChannel onEnemySpawned;
[SerializeField] private GameObjectSignalChannel onEnemyDestroyed;

// Publisher (Spawner)
public void SpawnEnemy()
{
    GameObject enemy = Instantiate(enemyPrefab, spawnPoint.position, Quaternion.identity);
    onEnemySpawned.Raise(enemy);
}

// Listener (Enemy Manager)
private void RegisterEnemy(GameObject enemy)
{
    activeEnemies.Add(enemy);
    UpdateEnemyCount();
}

private void UnregisterEnemy(GameObject enemy)
{
    activeEnemies.Remove(enemy);
    UpdateEnemyCount();
}
```

**Pattern 2: Object Selection**

```csharp
[SerializeField] private GameObjectSignalChannel onObjectSelected;

// Publisher
private void Update()
{
    if (Input.GetMouseButtonDown(0))
    {
        Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
        if (Physics.Raycast(ray, out RaycastHit hit))
        {
            onObjectSelected.Raise(hit.collider.gameObject);
        }
    }
}

// Listener
private void HandleSelection(GameObject selected)
{
    if (currentSelection != null)
        Deselect(currentSelection);

    currentSelection = selected;
    Select(selected);
}
```

**Pattern 3: Projectile Impact**

```csharp
[SerializeField] private GameObjectSignalChannel onProjectileHit;

// Publisher
private void OnCollisionEnter(Collision collision)
{
    onProjectileHit.Raise(collision.gameObject);
    Destroy(gameObject); // Destroy projectile
}

// Listener
private void HandleImpact(GameObject hitObject)
{
    if (hitObject != null && hitObject.TryGetComponent<Health>(out var health))
    {
        health.TakeDamage(damageAmount);
    }
}
```

**Pattern 4: Pickup System**

```csharp
[SerializeField] private GameObjectSignalChannel onItemPickedUp;

// Publisher
private void OnTriggerEnter(Collider other)
{
    if (other.CompareTag("Player"))
    {
        onItemPickedUp.Raise(gameObject);
        Destroy(gameObject);
    }
}

// Listener
private void HandlePickup(GameObject item)
{
    if (item != null && item.TryGetComponent<Item>(out var itemData))
    {
        inventory.AddItem(itemData);
        PlayPickupSound();
    }
}
```

## Related Channels

When GameObject isn't quite right:

- [**Transform Signal**](/docs/channels/transform) - For Transform component references
- [**Vector3 Signal**](/docs/channels/vector3) - For positions only (more efficient)
- [**Void Signal**](/docs/channels/void) - If you don't need the object reference

## Next Steps

- [**Transform Signals**](/docs/channels/transform) - Learn about Transform reference signals
- [**All Channel Types**](/docs/channels) - Explore all 15 signal channels
