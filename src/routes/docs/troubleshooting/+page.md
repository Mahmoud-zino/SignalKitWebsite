# Troubleshooting

Having issues with SignalKit? This guide covers common problems and their solutions. If you don't find your issue here, please [report it on GitHub](https://github.com/Mahmoud-zino/SignalKitWebsite/issues/new?labels=bug).

## Installation Issues

### Q: I get import errors after installing SignalKit

**Symptoms:**
- Console shows compilation errors after importing the package
- Red error messages about missing assemblies or types

**Solutions:**

1. **Reimport the package:**
   ```
   Assets > Reimport All
   ```
   Wait for Unity to finish recompiling all scripts.

2. **Restart Unity:**
   Close Unity completely and reopen your project. This forces a full recompile.

3. **Check Unity version:**
   Ensure you're running Unity 2021.3 LTS or later. SignalKit requires:
   - Unity 2021.3 LTS or newer
   - .NET Standard 2.1 or .NET Framework 4.x
   - API Compatibility Level: .NET Standard 2.1

4. **Verify complete import:**
   Check that all files were imported:
   - Navigate to `Assets/SignalKit/`
   - Ensure you see folders: `Runtime/`, `Editor/`, `Examples/`
   - Check for `.asmdef` files in Runtime and Editor folders

5. **Clear Library folder (last resort):**
   ```
   1. Close Unity
   2. Delete the "Library" folder in your project directory
   3. Reopen Unity (will take time to reimport everything)
   ```

---

### Q: SignalKit menu items are missing from Window menu

**Symptoms:**
- Can't find `Window > SignalKit > Debugger`
- SignalKit menu doesn't appear at all

**Solutions:**

1. **Check package is fully imported:**
   - Look for `Assets/SignalKit/Editor/` folder
   - Verify `SignalKit.Editor.asmdef` file exists

2. **Reimport SignalKit folder:**
   ```
   1. Locate the SignalKit folder in your Project window
   2. Right-click on it
   3. Select "Reimport"
   ```

3. **Check for compilation errors:**
   - Open the Console window
   - Fix any red compilation errors
   - SignalKit editor tools won't load if there are compile errors

4. **Verify assembly definitions:**
   ```
   Assets/SignalKit/Runtime/SignalKit.Runtime.asmdef
   Assets/SignalKit/Editor/SignalKit.Editor.asmdef
   ```
   Both files should exist and have no errors.

---

### Q: Asset Store download keeps failing

**Symptoms:**
- Download starts but never completes
- "Download failed" error in Package Manager

**Solutions:**

1. **Check Unity login:**
   - Go to `Edit > Preferences > Account`
   - Ensure you're signed in with the account that owns SignalKit

2. **Clear Asset Store cache:**
   ```
   1. Go to Edit > Preferences > Asset Store
   2. Click "Clear cache"
   3. Restart Unity
   4. Try downloading again
   ```

3. **Check internet connection:**
   - Ensure stable internet connection
   - Try disabling VPN if you're using one
   - Check firewall isn't blocking Unity

4. **Use web browser:**
   - Go to https://assetstore.unity.com
   - Download SignalKit from browser
   - Import the `.unitypackage` manually via `Assets > Import Package > Custom Package`

---

## Setup and Configuration

### Q: "The type or namespace name 'SignalKit' could not be found"

**Symptoms:**
```csharp
// This line shows an error
using SignalKit.Runtime.Core.Channels;
```

**Solutions:**

1. **Check assembly definition references:**

   If you're using assembly definitions (`.asmdef` files) in your project, you need to reference SignalKit:

   ```
   1. Open your .asmdef file
   2. Add "SignalKit.Runtime" to "Assembly Definition References"
   3. Apply and let Unity recompile
   ```

2. **Verify namespace spelling:**
   ```csharp
   // Correct namespaces
   using SignalKit.Runtime.Core;
   using SignalKit.Runtime.Core.Channels;
   using SignalKit.Runtime.Core.Listeners;

   // NOT this (wrong)
   using SignalKit.Channels;  // Missing "Runtime.Core"
   ```

3. **Check package is imported:**
   - Look for `Assets/SignalKit/Runtime/` folder
   - Verify files exist inside

---

### Q: My script can't see VoidSignalChannel or other channel types

**Symptoms:**
```csharp
// Shows error: "VoidSignalChannel does not exist"
[SerializeField] private VoidSignalChannel myChannel;
```

**Solutions:**

1. **Add the correct namespace:**
   ```csharp
   using SignalKit.Runtime.Core.Channels;  // Add this at top of file

   public class MyScript : MonoBehaviour
   {
       [SerializeField] private VoidSignalChannel myChannel;
   }
   ```

2. **Check spelling:**
   ```csharp
   // Correct
   VoidSignalChannel
   IntSignalChannel
   FloatSignalChannel

   // Wrong
   VoidChannel  // Missing "Signal"
   SignalChannel  // This is the base class, not a usable type
   ```

---

## Runtime Errors

### Q: "NullReferenceException: Object reference not set to an instance of an object"

**Symptoms:**
```
NullReferenceException when calling channel.Raise()
```

**Most Common Cause:**

You forgot to assign the channel in the Inspector!

**Solution:**

```csharp
public class MyScript : MonoBehaviour
{
    [SerializeField] private VoidSignalChannel myChannel;

    private void Start()
    {
        myChannel.Raise();  // Will crash if myChannel is null!
    }
}
```

**Fix:**
1. Select the GameObject with MyScript in the Hierarchy
2. Look at the Inspector
3. Find the "My Channel" field
4. Drag your signal channel asset into that field

**Prevention:**

Add null checks for extra safety:

```csharp
private void Start()
{
    if (myChannel == null)
    {
        Debug.LogError("Channel not assigned!", this);
        return;
    }

    myChannel.Raise();
}
```

Or use null-conditional operator:

```csharp
myChannel?.Raise();  // Only raises if myChannel is not null
```

---

### Q: Signal is raised but listeners don't respond

**Symptoms:**
- You call `channel.Raise()`
- No errors in console
- But your listener methods never execute

**Solutions:**

1. **Check channel assignment:**

   Verify both the raiser and listener are using the **same channel asset**:

   ```
   Raiser GameObject Inspector:
   - My Channel: [PlayerScoredSignal]

   Listener GameObject Inspector:
   - My Channel: [PlayerScoredSignal]  ✓ Same asset
   ```

   NOT this:
   ```
   Raiser: [PlayerScoredSignal]
   Listener: [PlayerScoredSignal 1]  ✗ Different asset!
   ```

2. **Verify listener is subscribed:**

   ```csharp
   private void OnEnable()
   {
       myChannel.OnRaised += MyHandler;  // Make sure this is called
   }
   ```

   Check that:
   - The GameObject is active in the scene
   - `OnEnable()` is actually being called (add a Debug.Log to verify)
   - You're using `+=` not `=` (easy typo!)

3. **Check listener method signature:**

   ```csharp
   // Correct for VoidSignalChannel
   private void MyHandler(Unit _) { }

   // Correct for IntSignalChannel
   private void OnScoreChanged(int score) { }

   // Wrong - won't compile or won't be called
   private void MyHandler() { }  // Missing parameter
   ```

4. **Use the debugger:**

   Open `Window > SignalKit > Debugger` and press Play. Watch to see:
   - Is the signal actually being raised?
   - How many listeners are subscribed?
   - Click on the channel to see which GameObjects are listening

---

### Q: "Events fire after GameObject is destroyed" or "Missing Reference Exception"

**Symptoms:**
```
MissingReferenceException: The object of type 'MyScript' has been destroyed
but you are still trying to access it.
```

**Cause:**

You forgot to unsubscribe from the signal when the GameObject is destroyed!

**Solution:**

Always use the OnEnable/OnDisable pattern:

```csharp
private void OnEnable()
{
    myChannel.OnRaised += MyHandler;  // Subscribe
}

private void OnDisable()
{
    myChannel.OnRaised -= MyHandler;  // MUST unsubscribe!
}
```

**Why this matters:**

```csharp
// BAD - Memory leak and errors
private void Start()
{
    myChannel.OnRaised += MyHandler;  // Subscribe
}
// No unsubscribe - handler stays registered even after object is destroyed!

// GOOD - Automatic cleanup
private void OnEnable()
{
    myChannel.OnRaised += MyHandler;
}

private void OnDisable()
{
    myChannel.OnRaised -= MyHandler;  // Cleaned up when disabled/destroyed
}
```

---

### Q: Events fire multiple times per signal

**Symptoms:**
- Call `channel.Raise()` once
- Your handler method runs 2, 3, or more times

**Cause:**

You're subscribing multiple times without unsubscribing!

**Common mistakes:**

```csharp
// BAD - subscribes in Start()
private void Start()
{
    myChannel.OnRaised += MyHandler;
}
// If GameObject is disabled and re-enabled, Start won't run again,
// but if you're subscribing elsewhere, you can double-subscribe!

// BAD - subscribing in multiple places
private void Awake()
{
    myChannel.OnRaised += MyHandler;
}
private void OnEnable()
{
    myChannel.OnRaised += MyHandler;  // Subscribed twice!
}
```

**Solution:**

1. **Always pair subscribe with unsubscribe:**
   ```csharp
   private void OnEnable()
   {
       myChannel.OnRaised += MyHandler;
   }

   private void OnDisable()
   {
       myChannel.OnRaised -= MyHandler;
   }
   ```

2. **Unsubscribe before subscribing (defensive):**
   ```csharp
   private void OnEnable()
   {
       myChannel.OnRaised -= MyHandler;  // Remove if already subscribed
       myChannel.OnRaised += MyHandler;  // Then subscribe
   }
   ```

---

### Q: Cannot use `await channel.WaitForSignalAsync()` - compiler error

**Symptoms:**
```csharp
// Shows error
var result = await myChannel.WaitForSignalAsync();
```

**Cause:**

Your method isn't marked as `async`.

**Solution:**

```csharp
// Add async keyword
private async void Start()
{
    Debug.Log("Waiting for signal...");
    await myChannel.WaitForSignalAsync();
    Debug.Log("Signal received!");
}

// Or for a Task-returning method
private async Task WaitForGameStart()
{
    await gameStartSignal.WaitForSignalAsync();
    // Continue after signal is raised
}
```

---

## Editor Tool Issues

### Q: SignalKit Debugger window shows no signals

**Symptoms:**
- Opened `Window > SignalKit > Debugger`
- Window is empty or shows "No signals raised"
- But you know signals are being raised

**Solutions:**

1. **Make sure you're in Play mode:**

   The debugger only shows signals raised during Play mode. Press the Play button first.

2. **Check if signals are actually being raised:**

   Add debug logging:
   ```csharp
   myChannel.Raise();
   Debug.Log("Signal raised!");
   ```

3. **Try clearing and restarting:**
   - Click "Clear" in the debugger window
   - Stop Play mode
   - Start Play mode again
   - Raise a signal

4. **Check filter settings:**
   - Make sure "Pause" is not enabled
   - Clear any search/filter text
   - Ensure no specific channels are filtered

---

### Q: Debugger shows signal but "Listeners: 0"

**Symptoms:**
- Signal appears in debugger when raised
- But shows "0 listeners"

**Meaning:**

No GameObjects are currently subscribed to that channel.

**Verify:**

1. **Check your listener is enabled:**
   ```csharp
   private void OnEnable()
   {
       Debug.Log("Subscribing to signal");
       myChannel.OnRaised += MyHandler;
   }
   ```
   Add a debug log to confirm OnEnable runs.

2. **Check GameObject is active:**
   - Look in Hierarchy
   - Make sure GameObject with listener is enabled (not greyed out)

3. **Check channel reference:**
   - Select listener GameObject
   - Verify the channel field shows the correct asset

---

### Q: Can't raise signal from Inspector in Play mode

**Symptoms:**
- Selected a channel in Project window
- In Play mode
- "Raise" button is greyed out or does nothing

**Solutions:**

1. **Check channel type:**

   - `VoidSignalChannel`: Button should work immediately
   - Typed channels (Int, Float, etc.): You need to enter a value first

   ```
   [Input field: 100]
   [Raise button]
   ```

2. **Object reference channels:**

   For `GameObjectSignalChannel` or `TransformSignalChannel`:
   - Drag a GameObject/Transform from Hierarchy into the field
   - Then click Raise

3. **Ensure Play mode is active:**
   - Signals can only be raised in Play mode
   - Check the Play button is highlighted

---

### Q: Recording feature doesn't capture events

**Symptoms:**
- Opened `Window > SignalKit > Signal Recording`
- Pressed Record
- Raised signals
- But recording is empty

**Solutions:**

1. **Start recording BEFORE raising signals:**
   ```
   1. Press Record button (turns red)
   2. Perform actions that raise signals
   3. Press Stop
   ```

2. **Check you're in Play mode:**
   Recording only works during Play mode.

3. **Verify signals are actually being raised:**
   - Open the Debugger window alongside Recording window
   - Confirm signals appear in Debugger

---

## Performance Issues

### Q: Raising signals causes frame drops or lag

**Symptoms:**
- Game stutters when raising signals
- Profiler shows high CPU usage in signal system

**Solutions:**

1. **Too many listeners:**

   If you have 100+ listeners on a single channel that fires every frame, consider:

   ```csharp
   // Instead of raising every frame
   void Update()
   {
       positionChannel.Raise(transform.position);  // Bad if 100+ listeners
   }

   // Throttle to reduce frequency
   private float throttle = 0f;
   void Update()
   {
       throttle += Time.deltaTime;
       if (throttle >= 0.1f)  // Only raise every 100ms
       {
           positionChannel.Raise(transform.position);
           throttle = 0f;
       }
   }
   ```

2. **Use built-in throttling:**

   SignalKit provides throttling features. See [Advanced Features](/docs/features) documentation.

3. **Expensive listener operations:**

   Profile your listener methods:
   ```csharp
   private void OnPositionChanged(Vector3 pos)
   {
       // If this is slow, optimize it
       UpdateComplexCalculation(pos);
   }
   ```

4. **Consider event batching:**

   Instead of raising a signal for each item:
   ```csharp
   // Bad - 100 signals raised
   foreach (var enemy in enemies)
   {
       enemyDiedChannel.Raise(enemy);
   }

   // Better - Use a different approach for batch processing
   // Or wait and raise once with summary data
   ```

---

### Q: Memory usage keeps increasing

**Symptoms:**
- Memory in Profiler grows over time
- Game eventually crashes or slows down

**Cause:**

Memory leak from not unsubscribing!

**Solution:**

1. **Check all subscriptions have corresponding unsubscriptions:**

   Search your codebase for:
   ```csharp
   .OnRaised +=
   ```

   For each one, verify there's a matching:
   ```csharp
   .OnRaised -=
   ```

2. **Use proper lifecycle:**
   ```csharp
   // CORRECT
   void OnEnable() => channel.OnRaised += Handler;
   void OnDisable() => channel.OnRaised -= Handler;

   // WRONG
   void Start() => channel.OnRaised += Handler;
   // No unsubscribe anywhere!
   ```

3. **Check for lambda subscriptions:**
   ```csharp
   // VERY BAD - Can't unsubscribe!
   void Start()
   {
       channel.OnRaised += (data) => {
           Debug.Log(data);
       };
       // No reference to the lambda, can't unsubscribe!
   }

   // GOOD - Use named method
   void OnEnable() => channel.OnRaised += OnChannelRaised;
   void OnDisable() => channel.OnRaised -= OnChannelRaised;
   void OnChannelRaised(int data) => Debug.Log(data);
   ```

---

## Common Mistakes

### Q: Channel reference shows "None" or "Missing" in Inspector

**Symptoms:**
```
My Channel: None (VoidSignalChannel)
```

**Causes and Solutions:**

1. **You deleted the channel asset:**

   If you deleted the ScriptableObject asset from your project:
   - Create a new channel: `Create > SignalKit > Channels > [Type]`
   - Reassign it in all GameObjects that need it

2. **Channel is in a different scene:**

   Channels are assets, not scene objects. They should be in your Project window, not Hierarchy.

3. **Wrong folder:**

   Search for the channel:
   ```
   In Project window search bar, type: t:VoidSignalChannel
   ```
   This finds all VoidSignalChannel assets.

---

### Q: My channel doesn't appear in Create menu

**Symptoms:**
- Right-click in Project window
- `Create > SignalKit > Channels >` shows some channels but not the one you want

**Solutions:**

1. **Check if it's a generated type:**

   If you created a custom signal type with code generation, verify:
   - The `[GenerateSignal]` attribute is present
   - Code generation completed successfully
   - Check `Assets/SignalKit/Generated/` for your type

2. **Use correct menu:**

   Built-in types are under:
   ```
   Create > SignalKit > Channels > [Type] Signal Channel
   ```

   Custom types appear after code generation.

3. **Refresh Asset Database:**
   ```
   Right-click in Project window > Refresh
   ```

---

### Q: IntelliSense doesn't show SignalKit types

**Symptoms:**
- Typing `VoidSignalChannel` doesn't autocomplete
- Visual Studio or Rider doesn't suggest SignalKit types

**Solutions:**

1. **Regenerate project files:**

   In Unity:
   ```
   Edit > Preferences > External Tools
   Click "Regenerate project files"
   ```

2. **Reimport SignalKit:**
   ```
   Right-click SignalKit folder > Reimport
   ```

3. **Restart your IDE:**
   Close and reopen Visual Studio, Rider, or VS Code.

4. **Check assembly definitions:**
   If using .asmdef files, ensure SignalKit.Runtime is referenced.

---

## Still Having Issues?

If none of these solutions helped, please:

1. **Check Unity Console for errors:**
   - Red error messages contain important clues
   - Copy the full error message when reporting issues

2. **Verify your setup:**
   - Unity version 2021.3+
   - SignalKit fully imported
   - No compilation errors

3. **Try the example scenes:**
   - Open `Assets/SignalKit/Examples/QuickStart/QuickStart.unity`
   - If examples work, compare with your setup

4. **Get help:**
   - 📚 Read the [Core Concepts](/docs/core-concepts) guide
   - 🐛 [Report a bug](https://github.com/Mahmoud-zino/SignalKitWebsite/issues/new?labels=bug) with details:
     - Unity version
     - SignalKit version
     - Full error message
     - Steps to reproduce
   - 💬 Ask on the [Unity Asset Store Q&A](https://assetstore.unity.com)
   - ✉️ Contact support email

---

## Quick Debugging Checklist

Before asking for help, verify:

- [ ] Channel is assigned in Inspector (not "None")
- [ ] Both raiser and listener use the **same** channel asset
- [ ] GameObject with listener is active in scene
- [ ] `OnEnable()` subscribes with `+=`
- [ ] `OnDisable()` unsubscribes with `-=`
- [ ] No compilation errors in Console
- [ ] SignalKit Debugger shows the signal being raised
- [ ] Listener method signature matches channel type
- [ ] You're in Play mode when testing

Most issues come down to:
1. Forgot to assign channel in Inspector
2. Forgot to unsubscribe in OnDisable
3. Using different channel assets in raiser vs listener
