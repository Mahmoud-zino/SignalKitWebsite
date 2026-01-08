# Color Signal Channel

**ColorSignalChannel** broadcasts color data - perfect for visual effects, UI themes, lighting changes, and any color-based game data.

## When to Use Color Signals

Use ColorSignalChannel when you need to broadcast color values:

- **Visual Effects** - Hit flash effects, damage tints, power-up colors
- **UI Themes** - Theme color changes, accent colors, button states
- **Lighting** - Dynamic lighting color, time-of-day color, environmental mood
- **Material Colors** - Object tinting, team colors, customization
- **Health/Status Indicators** - Health bar colors, status effect colors

## Code Example

**Raising a color signal:**

```csharp
using UnityEngine;
using SignalKit.Runtime.Core.Channels;

[SerializeField] private ColorSignalChannel onHealthColorChanged;

// Raise the signal with a Color value
onHealthColorChanged.Raise(Color.red);
onHealthColorChanged.Raise(new Color(1f, 0.5f, 0f)); // Orange
```

**Listening to a color signal:**

```csharp
using UnityEngine;
using SignalKit.Runtime.Core.Channels;

[SerializeField] private ColorSignalChannel onHealthColorChanged;

private void OnEnable()
{
    onHealthColorChanged.OnRaised += UpdateHealthBar;
}

private void OnDisable()
{
    onHealthColorChanged.OnRaised -= UpdateHealthBar;
}

private void UpdateHealthBar(Color color)
{
    healthBarImage.color = color;
}
```

## Best Practices

### Do:
- **Use descriptive names** - `OnThemeColorChanged` is clearer than `ColorSignal`
- **Use Color.Lerp()** - For smooth color transitions
- **Consider alpha channel** - Don't forget transparency (RGBA)
- **Use predefined colors** - `Color.red`, `Color.blue` are more readable than raw values

### Don't:
- **Don't use for every frame** - Color signals have overhead; avoid `Update()` raises
- **Don't forget alpha** - Make sure alpha is set correctly (default is 1.0)
- **Don't hardcode values** - Use constants or inspector fields for color values
- **Don't use for simple on/off** - Use `BoolSignalChannel` if you just need visibility toggle

## When NOT to Use Color Signals

Color signals aren't appropriate when:

- **You only need on/off visibility** - Use `BoolSignalChannel` instead
- **Updates every frame** - Use direct property access or `Update()` instead
- **You need multiple colors** - Use custom signal channels for color palettes
- **No data is needed** - Use `VoidSignalChannel` for simple events

## Common Patterns

**Pattern 1: Health Bar Color**

```csharp
[SerializeField] private ColorSignalChannel onHealthColorChanged;

// Publisher
private void UpdateHealthColor(float healthPercent)
{
    Color color = Color.Lerp(Color.red, Color.green, healthPercent);
    onHealthColorChanged.Raise(color);
}

// Listener
private void UpdateHealthBarColor(Color color)
{
    healthBarFill.color = color;
}
```

**Pattern 2: Theme Switcher**

```csharp
[SerializeField] private ColorSignalChannel onThemeColorChanged;

// Publisher
public void SetTheme(string themeName)
{
    Color themeColor = themeName switch
    {
        "Dark" => new Color(0.1f, 0.1f, 0.1f),
        "Light" => new Color(0.95f, 0.95f, 0.95f),
        "Blue" => new Color(0.2f, 0.4f, 0.8f),
        _ => Color.white
    };
    onThemeColorChanged.Raise(themeColor);
}

// Listener
private void UpdateTheme(Color color)
{
    backgroundImage.color = color;
}
```

**Pattern 3: Damage Flash**

```csharp
[SerializeField] private ColorSignalChannel onDamageFlash;

// Publisher
public void TakeDamage()
{
    onDamageFlash.Raise(Color.red);
    Invoke(nameof(ResetColor), 0.1f);
}

private void ResetColor()
{
    onDamageFlash.Raise(Color.white);
}

// Listener
private void FlashSprite(Color color)
{
    spriteRenderer.color = color;
}
```

**Pattern 4: Team Color**

```csharp
[SerializeField] private ColorSignalChannel onTeamColorChanged;

// Publisher
public void SetTeam(int teamId)
{
    Color teamColor = teamId switch
    {
        0 => Color.blue,
        1 => Color.red,
        2 => Color.green,
        _ => Color.gray
    };
    onTeamColorChanged.Raise(teamColor);
}

// Listener
private void UpdatePlayerColor(Color color)
{
    playerMaterial.color = color;
    minimapIcon.color = color;
}
```

## Related Channels

When Color isn't quite right:

- [**Bool Signal**](/docs/channels/bool) - For simple visibility on/off
- [**String Signal**](/docs/channels/string) - For theme names or color IDs
- [**Int Signal**](/docs/channels/int) - For discrete color indices

## Next Steps

- [**GameObject Signals**](/docs/channels/gameobject) - Learn about object reference signals
- [**All Channel Types**](/docs/channels) - Explore all 15 signal channels
