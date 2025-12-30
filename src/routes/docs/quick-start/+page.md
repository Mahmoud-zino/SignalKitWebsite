# Your First Signal

Create your first SignalKit signal in just a few minutes. This hands-on tutorial will walk you through creating a signal channel, raising events, and listening to them.

## What You'll Build

In this tutorial, you'll create a simple "player scored" event system. When the player collects a coin, a signal will be raised, and multiple game systems will respond - updating the UI, playing a sound, and logging to the console.

By the end, you'll understand:
- How to create a signal channel
- How to raise signals from your code
- How to listen to signals using components
- How to subscribe to signals via code

### Prefer to See It First?

If you'd rather explore the finished example before following the tutorial, you can find a complete working scene in your SignalKit package:

**Scene Location**: `Assets/SignalKit/Examples/QuickStart/QuickStart.unity`

Open this scene and press Play to see the example in action. You can then examine the scripts and setup to understand how everything works together. Come back to this tutorial when you're ready to build it yourself!

## Step 1: Create a Signal Channel

Signal channels are ScriptableObjects that act as event broadcasters. Let's create one for our score event.

1. In Unity, right-click in your **Project** window
2. Navigate to `Create > SignalKit > Channels > Void Signal Channel`
3. Name it **"PlayerScoredSignal"**
4. (Optional) Add a description in the Inspector: "Raised when the player collects a coin"

That's it! You've created your first signal channel. The `VoidSignalChannel` is perfect for simple events that don't need to pass data.

### Understanding Channel Types

SignalKit provides several built-in channel types:
- **VoidSignalChannel**: Simple events with no data (like "game started" or "player died")
- **IntSignalChannel**: Events with an integer value (like "score changed" or "ammo count")
- **StringSignalChannel**: Events with text data (like "player name changed")
- **FloatSignalChannel**: Events with decimal values (like "health percentage")

For now, we'll stick with `VoidSignalChannel` to keep things simple.

## Step 2: Raise the Signal

Now let's raise this signal when the player collects a coin.

Create a new script called `Coin.cs`:

```csharp
using UnityEngine;
using SignalKit.Runtime.Core.Channels;

public class Coin : MonoBehaviour
{
    [SerializeField] private VoidSignalChannel playerScoredSignal;

    private void OnTriggerEnter(Collider other)
    {
        if (other.CompareTag("Player"))
        {
            // Raise the signal - notify all listeners!
            playerScoredSignal.Raise();

            // Destroy the coin
            Destroy(gameObject);
        }
    }
}
```

### What's Happening Here?

1. We serialize a reference to our `VoidSignalChannel` so we can assign it in the Inspector
2. When the player collides with the coin, we call `Raise()` on the channel
3. All listeners subscribed to this channel will be notified automatically

Now:
1. Attach this script to a coin GameObject in your scene
2. In the Inspector, drag the **PlayerScoredSignal** asset into the `Player Scored Signal` field
3. Make sure your coin has a **Collider** with "Is Trigger" enabled

## Step 3: Listen Using a Component

Let's create a UI text element that updates when the player scores. SignalKit provides listener components that connect directly in the Inspector - no code required!

### Create the UI

1. Create a **Canvas** in your scene (`Right-click > UI > Canvas`)
2. Create a **Text - TextMeshPro** as a child of the Canvas
3. Name it "ScoreText"
4. Position it in the top-right corner
5. Set the text to "Score: 0"

### Add a Listener Component

1. Add a `SignalListener` component to your **ScoreText** GameObject
2. In the Inspector, drag the **PlayerScoredSignal** into the `Channel` field
3. Click the **+** button under `On Signal Raised` to add a response
4. Drag the **ScoreText** GameObject into the object field
5. Select `TextMeshProUGUI > SetText` from the dropdown
6. Enter "Score increased!" in the text field

Now, every time the signal is raised, the text will update!

### A More Practical Approach

For a real score counter, you'd want to track the actual score value. Here's a simple script you can attach to the ScoreText instead:

```csharp
using UnityEngine;
using TMPro;
using SignalKit.Runtime.Core;
using SignalKit.Runtime.Core.Channels;

public class ScoreDisplay : MonoBehaviour
{
    [SerializeField] private VoidSignalChannel playerScoredSignal;
    private TextMeshProUGUI scoreText;
    private int score = 0;

    private void Awake()
    {
        scoreText = GetComponent<TextMeshProUGUI>();
        UpdateDisplay();
    }

    private void OnEnable()
    {
        // Subscribe to the signal when enabled
        playerScoredSignal.OnRaised += OnPlayerScored;
    }

    private void OnDisable()
    {
        // Unsubscribe when disabled - important to prevent memory leaks!
        playerScoredSignal.OnRaised -= OnPlayerScored;
    }

    private void OnPlayerScored(Unit _)
    {
        score += 10;
        UpdateDisplay();
    }

    private void UpdateDisplay()
    {
        scoreText.text = $"Score: {score}";
    }
}
```

### Understanding the Unit Type

You might have noticed the `Unit _` parameter in the `OnPlayerScored` method. **What is `Unit`?**

`Unit` is SignalKit's way of representing "void" or "no data". Since `VoidSignalChannel` is actually a `SignalChannel<Unit>` under the hood, the callback must accept a `Unit` parameter - even though we don't use it.

**Why not just use `void`?**
- C# doesn't allow `void` as a generic type parameter (you can't write `SignalChannel<void>`)
- `Unit` is a special type that means "no meaningful value" but works with generics
- The underscore `_` is a discard that says "I receive this but don't need it"

**For typed signals** (like `IntSignalChannel`), you'd use the actual value:
```csharp
private void OnScoreChanged(int newScore)  // IntSignalChannel passes an int
{
    Debug.Log($"Score is now: {newScore}");
}
```

Don't worry - this pattern becomes natural quickly, and it keeps SignalKit's architecture clean and consistent!

## Step 4: Listen From Code

Sometimes you need more control than the Inspector provides. Let's add a sound effect that plays when the player scores.

Create a new script called `AudioManager.cs`:

```csharp
using UnityEngine;
using SignalKit.Runtime.Core;
using SignalKit.Runtime.Core.Channels;

public class AudioManager : MonoBehaviour
{
    [SerializeField] private VoidSignalChannel playerScoredSignal;
    [SerializeField] private AudioClip coinSound;
    private AudioSource audioSource;

    private void Awake()
    {
        audioSource = GetComponent<AudioSource>();
    }

    private void OnEnable()
    {
        // Subscribe to the signal
        playerScoredSignal.OnRaised += OnPlayerScored;
    }

    private void OnDisable()
    {
        // Always unsubscribe to prevent memory leaks
        playerScoredSignal.OnRaised -= OnPlayerScored;
    }

    private void OnPlayerScored(Unit _)
    {
        audioSource.PlayOneShot(coinSound);
        Debug.Log("Player scored! Playing sound effect.");
    }
}
```

### Setting Up the AudioManager

Now let's set up a GameObject with this script:

1. In your scene, create an **empty GameObject** (Right-click in Hierarchy > Create Empty)
2. Rename it to "AudioManager"
3. Add the **AudioManager** script to it
4. Add an **Audio Source** component (Click Add Component > Audio Source)
5. In the Inspector:
   - Drag the **PlayerScoredSignal** into the `Player Scored Signal` field
   - Drag your coin sound effect into the `Coin Sound` field
   - Optional: Uncheck **Play On Awake** on the Audio Source

Now when the player collects a coin, you'll hear the sound effect!

### Important: OnEnable/OnDisable Pattern

Notice how we subscribe in `OnEnable()` and unsubscribe in `OnDisable()`. This is crucial:
- **OnEnable**: Called when the GameObject becomes active
- **OnDisable**: Called when the GameObject is disabled or destroyed

This pattern ensures listeners are automatically cleaned up, preventing memory leaks and errors.

## Step 5: Test It All

Now let's see everything in action:

1. Create a simple scene with:
   - A player GameObject (capsule with a Rigidbody and "Player" tag)
   - A few coin GameObjects with the `Coin` script attached
   - The ScoreText UI with `ScoreDisplay` script
   - An AudioManager GameObject with the `AudioManager` script

2. Make sure all the signal channel references are assigned in the Inspector

3. Press **Play**

4. Move your player to collect a coin

You should see:
- The coin disappears
- The score text updates
- A sound effect plays
- A message appears in the Console

All of this happens with **zero coupling** between the systems. The Coin doesn't know about the UI or AudioManager, and vice versa. They all just communicate through the signal channel!

## Understanding the Benefits

Let's compare this to traditional approaches:

### Traditional Approach (Tightly Coupled)

```csharp
public class Coin : MonoBehaviour
{
    private void OnTriggerEnter(Collider other)
    {
        if (other.CompareTag("Player"))
        {
            // Tightly coupled - Coin knows about UI and Audio
            FindObjectOfType<ScoreDisplay>().AddScore(10);
            FindObjectOfType<AudioManager>().PlayCoinSound();
            Destroy(gameObject);
        }
    }
}
```

**Problems:**
- `Coin` is tightly coupled to `ScoreDisplay` and `AudioManager`
- Hard to test in isolation
- Difficult to add new listeners without modifying `Coin`
- Performance issues with `FindObjectOfType`

### SignalKit Approach (Decoupled)

```csharp
using UnityEngine;
using SignalKit.Runtime.Core.Channels;

public class Coin : MonoBehaviour
{
    [SerializeField] private VoidSignalChannel playerScoredSignal;

    private void OnTriggerEnter(Collider other)
    {
        if (other.CompareTag("Player"))
        {
            playerScoredSignal.Raise();
            Destroy(gameObject);
        }
    }
}
```

**Benefits:**
- `Coin` only knows about the signal channel
- Easy to test - just verify the signal is raised
- Add new listeners without touching `Coin`
- No performance overhead
- Systems can be enabled/disabled independently

## Next Steps

Congratulations! You've created your first signal-based event system. Here's what to explore next:

- **[Core Concepts](/docs/core-concepts)** - Deep dive into how SignalKit works under the hood
- **[Channels](/docs/channels)** - Learn about typed channels that pass data (Int, Float, String, etc.)
- **[Listeners](/docs/listeners)** - Master the different ways to subscribe to signals
- **[Editor Tools](/docs/editor-tools)** - Discover the powerful debugger and Inspector tools

### Quick Tips

1. **Use Descriptive Names**: Name your channels clearly (e.g., "PlayerDiedSignal" not "Signal1")
2. **Add Descriptions**: Use the description field in the Inspector to document what each signal does
3. **Organize Your Channels**: Create a "Signals" folder in your project to keep channels organized
4. **Always Unsubscribe**: Remember the OnEnable/OnDisable pattern to prevent memory leaks
5. **Use the Debugger**: Open `Window > SignalKit > Debugger` to see signals being raised in real-time

### Common Mistakes to Avoid

- **Forgetting to Assign Channels**: Always check that your channel references are assigned in the Inspector
- **Not Unsubscribing**: Always pair subscribe (`+=`) with unsubscribe (`-=`)
- **Using Wrong Channel Type**: Make sure you're using the right channel type for your data (Void, Int, Float, etc.)

## Troubleshooting

### "NullReferenceException: Object reference not set to an instance of an object"

This usually means you forgot to assign the signal channel in the Inspector. Check all your `[SerializeField]` channel references.

### "Signal raised but nothing happens"

Make sure:
1. Your listener is subscribed (check OnEnable is being called)
2. The correct channel is assigned in both the raiser and listener
3. The listener GameObject is active in the scene

### "Events fire after GameObject is destroyed"

You forgot to unsubscribe in `OnDisable()`. Always clean up your subscriptions!

## Summary

You've learned:
- ✓ How to create a signal channel (ScriptableObject)
- ✓ How to raise signals using `channel.Raise()`
- ✓ How to listen using SignalListener components (Inspector)
- ✓ How to subscribe/unsubscribe via code (OnEnable/OnDisable)
- ✓ Why decoupling is powerful for game architecture

Ready to level up? Check out the [Core Concepts](/docs/core-concepts) guide to understand the full power of SignalKit.
