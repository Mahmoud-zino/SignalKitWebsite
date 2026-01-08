# Input System Integration

Raise SignalChannels directly from Unity's Input System actions. No code required - connect Input Actions to signals visually in the Inspector.

## When to Use Input System Integration

Use Input System integration when you need:

- **Decouple Input from Logic** - Separate input handling from gameplay code
- **Designer-Friendly Input** - Let designers configure input without coding
- **Input Remapping** - Change input mapping without touching code
- **Multi-Device Support** - Handle keyboard, gamepad, touch with same signals
- **Input Debugging** - Monitor all input through Signal Debugger

## How It Works

- **MonoBehaviour raisers** - Add to any GameObject
- **Input Action References** - Assign Input Actions in Inspector
- **Automatic raising** - Raises signals on Started/Performed/Canceled
- **Type-specific** - Different raisers for different value types
- **No code required** - Configure entirely in Inspector

## Available Input Raisers

SignalKit provides raisers for common input types:

- **InputVoidSignalRaiser** - Button presses (no value)
- **InputBoolSignalRaiser** - Button state (pressed/released)
- **InputFloatSignalRaiser** - Single axis (triggers, scrollwheel)
- **InputVector2SignalRaiser** - 2D input (movement, look, thumbstick)
- **InputVector3SignalRaiser** - 3D input (VR controllers, spatial input)

## Setup Requirements

1. Install Unity Input System package
2. Create Input Actions asset
3. Add Input Raiser component
4. Assign Input Action and Signal Channels

## Code Example

**No code needed! Pure Inspector setup:**

1. Create Input Actions asset
2. Add "Jump" action (Button type)
3. Add `InputVoidSignalRaiser` component to GameObject
4. Assign Jump action reference
5. Assign `onJumpPressed` channel to `On Performed`

**Result:** Signal raises when Jump action is performed

## Inspector Configuration

**InputVoidSignalRaiser:**

```
┌─ Input Void Signal Raiser ────────┐
│                                    │
│ Input Action: [Jump]               │
│                                    │
│ Channels (assign as needed):       │
│   On Started:   [onJumpStarted]    │
│   On Performed: [onJumpPressed]    │
│   On Canceled:  [onJumpReleased]   │
│                                    │
└────────────────────────────────────┘
```

## Input Action Phases

Each raiser supports three action phases:

**Started** - Action begins (button pressed down)
```
Use for: Animation start, charge-up effects, UI feedback
```

**Performed** - Action completes (button fully pressed)
```
Use for: Jump, shoot, interact, primary action
```

**Canceled** - Action ends (button released)
```
Use for: Stop charging, release button, end action
```

You can assign different channels to each phase or leave them null.

## Common Patterns

**Pattern 1: Button Press (Void)**

```
Setup:
1. Add InputVoidSignalRaiser
2. Assign "Jump" action
3. Assign onJumpPressed to On Performed

Result: onJumpPressed raises when space/button pressed
```

**Pattern 2: Movement Input (Vector2)**

```
Setup:
1. Add InputVector2SignalRaiser
2. Assign "Move" action (2D Vector Composite)
3. Assign onMoveInput to On Performed

Result: onMoveInput raises with Vector2 direction
```

**Pattern 3: Analog Trigger (Float)**

```
Setup:
1. Add InputFloatSignalRaiser
2. Assign "Accelerate" action (Axis)
3. Assign onAccelerateInput to On Performed

Result: onAccelerateInput raises with 0-1 value
```

**Pattern 4: Button State Tracking (Bool)**

```
Setup:
1. Add InputBoolSignalRaiser
2. Assign "Sprint" action (Button)
3. Assign onSprintState to On Performed
4. Assign onSprintState to On Canceled

Result:
- onSprintState raises TRUE on press
- onSprintState raises FALSE on release
```

**Pattern 5: Multiple Actions, One Raiser**

```
Setup:
1. Add three InputVoidSignalRaisers to one GameObject
2. Raiser 1: Jump → onJumpPressed
3. Raiser 2: Shoot → onShootPressed
4. Raiser 3: Interact → onInteractPressed

Result: All input in one place, raising different channels
```

**Pattern 6: All Three Phases**

```
Setup:
1. Add InputVoidSignalRaiser
2. Assign "Attack" action
3. Assign channels:
   - On Started: onAttackCharged (start charging)
   - On Performed: onAttackReleased (attack fires)
   - On Canceled: onAttackCanceled (charge canceled)

Result: Full control over attack lifecycle
```

**Pattern 7: Camera Look (Vector2)**

```
Setup:
1. Add InputVector2SignalRaiser
2. Assign "Look" action (2D Vector)
3. Assign onCameraLook to On Performed

Result: onCameraLook raises with mouse/stick delta
```

**Pattern 8: Multiple Channels for Same Action**

```
Setup:
1. Add InputVoidSignalRaiser for "Jump"
2. Assign multiple channels to On Performed:
   - onJumpPressed
   - onPlayerAction
   - onAudioTrigger

Note: Only one channel per phase per raiser
Workaround: Add multiple raisers for same action
```

## Input Action Types

**Button:**
- Use: InputVoidSignalRaiser or InputBoolSignalRaiser
- Example: Jump, Shoot, Interact

**Axis:**
- Use: InputFloatSignalRaiser
- Example: Trigger, Scrollwheel, Throttle

**2D Vector:**
- Use: InputVector2SignalRaiser
- Example: Movement, Look, Thumbstick

**3D Vector:**
- Not directly supported
- Workaround: Use multiple Float raisers or custom raiser

## Creating Custom Input Raisers

Extend for custom value types:

```csharp
using SignalKit.Runtime.Core.Channels;
using UnityEngine;
using UnityEngine.InputSystem;

public class InputIntSignalRaiser : MonoBehaviour
{
    [SerializeField]
    private InputActionReference inputAction;

    [SerializeField]
    private IntSignalChannel onPerformed;

    private void OnEnable()
    {
        if (inputAction == null) return;

        inputAction.action.performed += OnPerformed;
        inputAction.action.Enable();
    }

    private void OnDisable()
    {
        if (inputAction == null) return;
        inputAction.action.performed -= OnPerformed;
    }

    private void OnPerformed(InputAction.CallbackContext context)
    {
        int value = (int)context.ReadValue<float>();
        if (onPerformed != null)
        {
            onPerformed.Raise(value);
        }
    }
}
```

## Best Practices

### Do:
- **Use one raiser per action** - Keep it simple and organized
- **Group raisers** - Put all input raisers on one "InputManager" GameObject
- **Name channels clearly** - `onJumpPressed`, not `onButtonA`
- **Assign only needed phases** - Leave unused phases null
- **Test with multiple devices** - Input System handles device differences

### Don't:
- **Don't put raisers everywhere** - Centralize on few GameObjects
- **Don't duplicate actions** - One raiser per action is enough
- **Don't forget to enable actions** - Input System actions must be enabled
- **Don't use for polling** - Use raisers for events, not continuous reading

## Performance Considerations

**Minimal overhead:**
- Input System integration is lightweight
- Only raises when action triggers
- No polling or Update() calls
- Comparable to direct Input System usage

**Recommendation:**
- Use raisers for all input
- No performance reason to avoid them
- Cleaner than scattered Input System code

## Debugging Input

**Signal Debugger:**
- Open Window → SignalKit → Signal Debugger
- See all input signals in real-time
- Filter by input channels
- Verify input is reaching signals

**Input System Debugger:**
- Use both together for complete picture
- Input System shows raw input
- Signal Debugger shows signal raises
- Identify issues in either layer

## Common Issues

**Action not triggering:**
- Check Input Action is enabled
- Verify device is detected (Input System Debugger)
- Ensure action has bindings
- Check channel is assigned in raiser

**Multiple raises:**
- Input Actions can trigger multiple times
- Use Interactions (Press, Hold, Tap) to control when action triggers
- Add filters to channels if needed

**Wrong values:**
- Check action type matches raiser type
- Button → Void/Bool
- Axis → Float
- 2D Vector → Vector2

## Integration with Input System Features

**Interactions:**
- Press, Hold, Tap, Slow Tap, Multi-Tap
- Configure in Input Actions asset
- Raisers respect interactions automatically

**Processors:**
- Invert, Clamp, Normalize, Scale
- Configure in Input Actions asset
- Values processed before raising

**Composite Bindings:**
- 2D Vector Composite (WASD → Vector2)
- 1D Axis Composite (separate buttons → float)
- Raisers handle composites automatically

## When NOT to Use Input System Integration

Input System integration isn't appropriate when:

- **Polling needed** - Use Input System API directly for continuous polling
- **Custom processing** - Complex input logic better in code
- **No Input System** - Requires Unity Input System package
- **Legacy Input Manager** - Use old Input Manager until you upgrade

## Migration from Input Manager

**Old Input Manager:**
```csharp
if (Input.GetButtonDown("Jump"))
{
    onJumpPressed.Raise();
}
```

**New Input System:**
```
Add InputVoidSignalRaiser
Assign Jump action
Assign onJumpPressed channel
Delete code
```

Benefits:
- No code to maintain
- Works across all devices
- Remappable without code changes
- Visible in Inspector

## Related Features

- [**UnityEvent Integration**](/docs/integrations/unityevents) - Connect signals to UnityEvents
- [**All Channel Types**](/docs/channels) - Explore all signal channels

## Next Steps

- [**Timeline Integration**](/docs/integrations/timeline) - Learn about Timeline integration
- [**Animator Integration**](/docs/integrations/animator) - Learn about Animator integration
