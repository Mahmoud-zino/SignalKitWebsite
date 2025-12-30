# Basic Concepts

Before diving into your first signal, let's understand the three building blocks of SignalKit: **Channels**, **Listeners**, and **Signals**.

## The Radio Station Analogy

Think of SignalKit like a radio broadcast system:

- **Channels** = Radio stations (FM 101.5, AM 820, etc.)
- **Listeners** = Radios tuned to those stations
- **Signals** = The messages being broadcast

When a radio station broadcasts a message, all radios tuned to that station receive it - but the station doesn't need to know which radios are listening.

This is exactly how SignalKit works in your game!

> [!NOTE]
> Throughout this documentation, we use the terms "raise a signal" and "broadcast a signal" interchangeably - they both mean sending an event through a channel to notify all listeners.

## What is a Channel?

A **Signal Channel** is a ScriptableObject asset in your project that acts as a communication hub. Components can "broadcast" messages through it without knowing who's listening.

**Creating a channel:**
1. Right-click in Project window
2. Select `Create > SignalKit > Channels > Void Signal Channel`
3. Name it something descriptive like "PlayerScoredSignal"

That's it! You now have a channel that any script can reference and use.

**Types of channels:**
- **Void** - Simple events with no data (button clicked, game started)
- **Int** - Events with a number (score changed, ammo count)
- **Float** - Events with a decimal (health percentage, timer)
- **String** - Events with text (player name, message)
- And many more for Unity types (Vector3, Color, GameObject, etc.)

## What is a Listener?

A **Listener** is any code that wants to be notified when a signal is raised. There are two ways to listen:

**1. Component-based (No code):**
Add a `SignalListener` component to any GameObject, assign your channel, and configure what happens when the signal is raised - all in the Inspector!

**2. Code-based (More control):**
Subscribe to the channel in your script:

```csharp
using SignalKit.Runtime.Core;
using SignalKit.Runtime.Core.Channels;

public class MyScript : MonoBehaviour
{
    [SerializeField] private VoidSignalChannel myChannel;

    private void OnEnable()
    {
        myChannel.OnRaised += MyHandler;
    }

    private void OnDisable()
    {
        myChannel.OnRaised -= MyHandler;
    }

    private void MyHandler(Unit _)
    {
        Debug.Log("Signal received!");
    }
}
```

> [!IMPORTANT]
> Always unsubscribe in `OnDisable()` to prevent memory leaks! This is the most common mistake when using SignalKit.

## What is a Signal?

A **Signal** is the actual event being raised. When you call `channel.Raise()`, all listeners are notified automatically.

```csharp
// Raise a void signal
playerScoredChannel.Raise();

// Raise a signal with data
scoreChangedChannel.Raise(100);
healthChangedChannel.Raise(75.5f);
```

## How They Work Together

Here's a simple example showing all three concepts:

**1. Create the Channel (Asset):**
Create a `VoidSignalChannel` asset named "ButtonClickedSignal"

**2. Raise the Signal (Button script):**
```csharp
using UnityEngine;
using SignalKit.Runtime.Core.Channels;

public class MyButton : MonoBehaviour
{
    [SerializeField] private VoidSignalChannel buttonClickedSignal;

    public void OnClick()
    {
        buttonClickedSignal.Raise();
    }
}
```

**3. Listen for the Signal (UI script):**
```csharp
using UnityEngine;
using SignalKit.Runtime.Core;
using SignalKit.Runtime.Core.Channels;

public class UIManager : MonoBehaviour
{
    [SerializeField] private VoidSignalChannel buttonClickedSignal;

    private void OnEnable()
    {
        buttonClickedSignal.OnRaised += OnButtonClicked;
    }

    private void OnDisable()
    {
        buttonClickedSignal.OnRaised -= OnButtonClicked;
    }

    private void OnButtonClicked(Unit _)
    {
        Debug.Log("Button was clicked!");
    }
}
```

**What happened:**
1. MyButton raises a signal through the channel
2. UIManager (and any other listeners) receives the signal
3. MyButton doesn't know about UIManager - they're completely decoupled!

## Why is This Better?

### Traditional Approach (Tightly Coupled):
```csharp
public class MyButton : MonoBehaviour
{
    public UIManager uiManager;  // Direct reference

    public void OnClick()
    {
        uiManager.OnButtonClicked();  // Direct call
    }
}
```

**Problems:**
- MyButton must know about UIManager
- Hard to add more systems that need to respond
- Can't test MyButton without UIManager
- Creates dependencies between unrelated systems

### SignalKit Approach (Decoupled):
```csharp
public class MyButton : MonoBehaviour
{
    [SerializeField] private VoidSignalChannel buttonClickedSignal;

    public void OnClick()
    {
        buttonClickedSignal.Raise();  // Just broadcast
    }
}
```

**Benefits:**
- MyButton only knows about the channel
- Any number of systems can listen
- Easy to test (just check if signal was raised)
- No dependencies between systems
- Can add/remove listeners without changing MyButton

## The Unit Type Explained

You might wonder: what is `Unit _` in the handler methods?

Since `VoidSignalChannel` doesn't carry data, it uses a special type called `Unit` (similar to "void" but works with generics). The underscore `_` means we're discarding that parameter.

**For void signals:**
```csharp
private void MyHandler(Unit _)  // Discard Unit
{
    // Do something
}
```

**For typed signals:**
```csharp
private void OnScoreChanged(int newScore)  // Use the value
{
    Debug.Log($"New score: {newScore}");
}
```

## Key Takeaways

- **Channels** are assets that broadcast signals
- **Listeners** subscribe to channels and respond when signals are raised
- **Signals** are the events flowing through the system
- This creates **decoupled** architecture - systems don't know about each other
- Always **unsubscribe** in OnDisable() to prevent memory leaks

## Next Steps

Ready to build something? Check out the [Quick Start](/docs/quick-start) guide where you'll create your first signal-based system in just a few minutes!

Want to dive deeper? The [Core Concepts](/docs/core-concepts) page provides an in-depth technical explanation with architecture diagrams, signal flow visualizations, and advanced patterns.
