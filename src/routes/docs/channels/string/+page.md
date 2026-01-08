# String Signal Channel

**StringSignalChannel** broadcasts text data - perfect for messages, identifiers, localization keys, and any text-based game data.

## When to Use String Signals

Use StringSignalChannel when you need to broadcast text values to multiple systems:

- **Messages** - Chat messages, notifications, debug logs
- **Identifiers** - Item names, level IDs, quest names
- **Localization Keys** - Translation keys for multi-language support
- **State Names** - Animation state names, scene names, mode names
- **User Input** - Text field changes, player names, search queries

## Code Example

**Raising a string signal:**

```csharp
using SignalKit.Runtime.Core.Channels;

[SerializeField] private StringSignalChannel onDialogueChanged;

// Raise the signal with a string value
onDialogueChanged.Raise("Hello, adventurer!");
onDialogueChanged.Raise("dialogue.greeting.morning"); // Localization key
```

**Listening to a string signal:**

```csharp
using SignalKit.Runtime.Core.Channels;

[SerializeField] private StringSignalChannel onDialogueChanged;

private void OnEnable()
{
    onDialogueChanged.OnRaised += DisplayDialogue;
}

private void OnDisable()
{
    onDialogueChanged.OnRaised -= DisplayDialogue;
}

private void DisplayDialogue(string text)
{
    dialogueText.text = text;
}
```

## Best Practices

### Do:
- **Use descriptive names** - `OnDialogueChanged` is clearer than `StringSignal`
- **Document string format** - Explain what format/convention the string follows
- **Use constants for known values** - Avoid magic strings with typos
- **Consider localization** - Use localization keys instead of hardcoded text
- **Validate input** - Check for null or empty strings if needed

### Don't:
- **Don't use for every frame** - String signals have overhead; avoid `Update()` raises
- **Don't use for enums** - Use `IntSignalChannel` with enum casting instead
- **Don't forget null checks** - Always validate string isn't null or empty
- **Don't use for large data** - Strings have memory overhead; use custom channels for big data

## When NOT to Use String Signals

String signals aren't appropriate when:

- **You have a fixed set of values** - Use `IntSignalChannel` with enums instead (more efficient)
- **You need numeric data** - Use `IntSignalChannel`, `FloatSignalChannel`, etc.
- **Updates every frame** - Use direct property access or `Update()` instead
- **No data is needed** - Use `VoidSignalChannel` for simple events

## Common Patterns

**Pattern 1: Dialogue System**

```csharp
[SerializeField] private StringSignalChannel onDialogueTriggered;

// Publisher
public void TriggerDialogue(string dialogueKey)
{
    onDialogueTriggered.Raise(dialogueKey);
}

// Listener
private void ShowDialogue(string key)
{
    string localizedText = LocalizationManager.GetText(key);
    dialogueBox.SetText(localizedText);
}
```

**Pattern 2: Debug Logger**

```csharp
[SerializeField] private StringSignalChannel onDebugMessage;

// Multiple systems can log messages
onDebugMessage.Raise("Player took damage");
onDebugMessage.Raise("Enemy spawned at checkpoint");
onDebugMessage.Raise("Quest completed: Main Story");

// Listener displays all messages
private void LogMessage(string message)
{
    debugConsole.AddLine($"[{Time.time:F2}] {message}");
}
```

**Pattern 3: Scene Loading**

```csharp
[SerializeField] private StringSignalChannel onSceneLoadRequested;

// Publisher
public void LoadLevel(string sceneName)
{
    onSceneLoadRequested.Raise(sceneName);
}

// Listener
private void HandleSceneLoad(string sceneName)
{
    StartCoroutine(LoadSceneAsync(sceneName));
}
```

**Pattern 4: State Changes**

```csharp
[SerializeField] private StringSignalChannel onGameStateChanged;

// Broadcast state name
onGameStateChanged.Raise("MainMenu");
onGameStateChanged.Raise("Playing");
onGameStateChanged.Raise("Paused");
onGameStateChanged.Raise("GameOver");

// Listener responds to state
private void HandleStateChange(string stateName)
{
    switch (stateName)
    {
        case "Playing":
            StartGameplay();
            break;
        case "Paused":
            PauseGameplay();
            break;
    }
}
```

## Related Channels

When string isn't quite right:

- [**Int Signal**](/docs/channels/int) - For enums and fixed value sets (more efficient)
- [**Void Signal**](/docs/channels/void) - For events without data
- [**Bool Signal**](/docs/channels/bool) - For on/off states

## Next Steps

- [**Vector2 Signals**](/docs/channels/vector2) - Learn about 2D position signals
- [**All Channel Types**](/docs/channels) - Explore all 15 signal channels
