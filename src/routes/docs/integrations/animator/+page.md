# Animator Integration

Raise SignalChannels from Animator state machine events using StateMachineBehaviours. Perfect for animation-driven gameplay, attack combos, and synchronized effects.

## When to Use Animator Integration

Use Animator integration when you need:

- **Animation Events** - Trigger gameplay from animation states
- **Combat Systems** - Attack combos, damage frames, hitbox timing
- **State-Driven Logic** - React to animation state changes
- **VFX Timing** - Spawn effects synchronized with animations
- **Audio Cues** - Play sounds at specific animation moments

## How It Works

- **StateMachineBehaviours** - Attach to Animator states
- **State callbacks** - OnStateEnter, OnStateUpdate, OnStateExit
- **All channel types** - 14 signal state behaviours for each type
- **Multiple signals** - Different channels for enter/update/exit
- **Inspector configuration** - No code required

## Available State Behaviours

All 14 built-in channel types have corresponding state behaviours:

- VoidSignalStateBehaviour
- BoolSignalStateBehaviour
- IntSignalStateBehaviour
- FloatSignalStateBehaviour
- DoubleSignalStateBehaviour
- StringSignalStateBehaviour
- Vector2SignalStateBehaviour
- Vector2IntSignalStateBehaviour
- Vector3SignalStateBehaviour
- Vector3IntSignalStateBehaviour
- ColorSignalStateBehaviour
- (Plus 3 more)

## Setup

1. Open Animator window
2. Select animation state
3. Click "Add Behaviour" in Inspector
4. Choose SignalStateBehaviour type
5. Assign SignalChannels for enter/update/exit

## Code Example

**No code required! Pure Inspector setup:**

1. Select "Attack" state in Animator
2. Add `VoidSignalStateBehaviour`
3. Assign channels:
   - On State Enter: `onAttackStarted`
   - On State Exit: `onAttackEnded`

**Result:** Signals raise when attack animation starts/ends

## Inspector Configuration

**VoidSignalStateBehaviour:**

```
┌─ Void Signal State Behaviour ─────┐
│                                    │
│ On State Enter:                    │
│   Channel: [onAttackStarted]       │
│                                    │
│ On State Update:                   │
│   Channel: [onAttackActive]        │
│                                    │
│ On State Exit:                     │
│   Channel: [onAttackEnded]         │
│                                    │
└────────────────────────────────────┘
```

## State Callbacks

**OnStateEnter:**
- Called once when entering state
- Use for: Start effects, play audio, set flags

**OnStateUpdate:**
- Called every frame while in state
- Use for: Continuous effects, position tracking
- Caution: High frequency, use sparingly

**OnStateExit:**
- Called once when leaving state
- Use for: Cleanup, stop effects, reset flags

You can assign different channels to each callback or leave them null.

## Common Patterns

**Pattern 1: Attack System (Void)**

```
Animator State: "Sword Attack"
├─ VoidSignalStateBehaviour
│  ├─ On Enter: onAttackStarted
│  ├─ On Update: (null - not needed)
│  └─ On Exit: onAttackEnded

Result:
- onAttackStarted → Enable hitbox
- onAttackEnded → Disable hitbox
```

**Pattern 2: Movement States (String)**

```
Animator States:
├─ "Idle" → StringStateBehaviour
│  └─ On Enter: onMovementState ("Idle")
├─ "Walk" → StringStateBehaviour
│  └─ On Enter: onMovementState ("Walk")
└─ "Run" → StringStateBehaviour
   └─ On Enter: onMovementState ("Run")

Result: onMovementState updates with current movement type
```

**Pattern 3: Combo System (Int)**

```
Animator States:
├─ "Attack1" → IntStateBehaviour
│  └─ On Enter: onComboStep (1)
├─ "Attack2" → IntStateBehaviour
│  └─ On Enter: onComboStep (2)
└─ "Attack3" → IntStateBehaviour
   └─ On Enter: onComboStep (3)

Result: Track combo progress with signal
```

**Pattern 4: Damage Frames (Bool)**

```
Animator State: "Enemy Attack"
├─ BoolSignalStateBehaviour
│  ├─ On Enter: onDamageFrameActive (true)
│  └─ On Exit: onDamageFrameActive (false)

Result: Enable/disable damage dealing
```

**Pattern 5: VFX Timing (Vector3)**

```
Animator State: "Special Move"
├─ Vector3SignalStateBehaviour
│  ├─ On Enter: onSpawnVFX (offset: 0, 1, 0)
│  └─ On Exit: onSpawnVFX (offset: 0, 0, 1)

Result: Spawn effects at animation start/end
```

**Pattern 6: Animation Speed (Float)**

```
Animator State: "Charge Attack"
├─ FloatSignalStateBehaviour
│  └─ On Update: onAnimationProgress (normalized time)

Result: Track animation progress (0-1)
```

**Pattern 7: Multiple Behaviours Per State**

```
Animator State: "Ultimate Attack"
├─ VoidSignalStateBehaviour
│  ├─ On Enter: onUltimateStarted
│  └─ On Exit: onUltimateEnded
├─ IntSignalStateBehaviour
│  └─ On Enter: onDamageMultiplier (3)
└─ BoolSignalStateBehaviour
   ├─ On Enter: onInvincible (true)
   └─ On Exit: onInvincible (false)

Result: Multiple signals from one state
```

**Pattern 8: Death State**

```
Animator State: "Death"
├─ VoidSignalStateBehaviour
│  ├─ On Enter: onCharacterDied
│  └─ On Exit: (null - never exits)

Result: Trigger death logic once
```

## Animator Layers

State behaviours work across all Animator layers:

```
Base Layer:
├─ "Idle" → Behaviour → onIdleEntered
└─ "Walk" → Behaviour → onWalkStarted

Upper Body Layer:
├─ "Attack" → Behaviour → onAttackStarted
└─ "Block" → Behaviour → onBlockStarted

Result: Signals from all layers work independently
```

## Sub-State Machines

Behaviours work in sub-state machines:

```
Combat Sub-State Machine:
├─ Entry → Behaviour → onCombatEntered
├─ "Light Attack"
├─ "Heavy Attack"
└─ Exit → Behaviour → onCombatExited

Result: Signals from sub-state entry/exit
```

## Best Practices

### Do:
- **Use Enter/Exit for triggers** - Clean start/stop events
- **Avoid Update for signals** - Update fires every frame (expensive)
- **Name states clearly** - "Sword Attack 1", not "State1"
- **Group related states** - Use sub-state machines
- **Test in Animator window** - Preview transitions

### Don't:
- **Don't spam Update** - OnStateUpdate fires every frame
- **Don't forget to assign channels** - Behaviours do nothing without channels
- **Don't use for non-animation logic** - Use code subscriptions instead
- **Don't duplicate logic** - One behaviour per state is enough

## Performance Considerations

**Minimal overhead:**
- OnStateEnter/Exit have minimal cost
- OnStateUpdate fires every frame (use sparingly)
- Comparable to regular StateMachineBehaviour

**Recommendation:**
- Use Enter/Exit freely
- Limit Update usage
- Use for animation-driven events only

## Debugging Animator Signals

**Animator Window:**
- See which state is active
- Test transitions
- Verify behaviours attached

**Signal Debugger:**
- Open Window → SignalKit → Signal Debugger
- Play game
- See signals raise as states change
- Verify correct channels and timing

**Common Issues:**
- Behaviour not attached → Signals don't raise
- Channel not assigned → No effect
- Wrong channel type → Compilation error
- Transition too fast → Signal may not fire

## Integration with Animator Features

**Animator Parameters:**
- Use parameters to control transitions
- Signals raise independently of parameters

**Blend Trees:**
- Behaviours on blend tree nodes
- Signals raise when blend tree enters/exits

**Animation Events:**
- Use Animation Events for frame-specific timing
- Use State Behaviours for state-level events
- Both can coexist

**IK:**
- State behaviours work with IK
- No special consideration needed

## Creating Custom State Behaviours

Extend for custom logic:

```csharp
using SignalKit.Runtime.Core.Channels;
using UnityEngine;

public class CustomSignalStateBehaviour : StateMachineBehaviour
{
    [SerializeField]
    private VoidSignalChannel onEnter;

    [SerializeField]
    private VoidSignalChannel onExit;

    [SerializeField]
    private float delayBeforeRaise = 0.2f;

    private float _timer;

    public override void OnStateEnter(
        Animator animator,
        AnimatorStateInfo stateInfo,
        int layerIndex)
    {
        _timer = 0f;
    }

    public override void OnStateUpdate(
        Animator animator,
        AnimatorStateInfo stateInfo,
        int layerIndex)
    {
        _timer += Time.deltaTime;
        if (_timer >= delayBeforeRaise && onEnter != null)
        {
            onEnter.Raise();
            onEnter = null; // Raise once
        }
    }

    public override void OnStateExit(
        Animator animator,
        AnimatorStateInfo stateInfo,
        int layerIndex)
    {
        if (onExit != null)
        {
            onExit.Raise();
        }
    }
}
```

## Common Use Cases

**Combat System:**
```
Attack States → Signals
├─ Hit detection windows
├─ Combo tracking
├─ Damage application
└─ Cancel windows
```

**Movement System:**
```
Movement States → Signals
├─ Footstep sounds
├─ Dust particles
├─ Movement speed changes
└─ Animation blending
```

**Enemy AI:**
```
AI States → Signals
├─ Aggro state changes
├─ Attack patterns
├─ Phase transitions
└─ Death events
```

**Cutscenes:**
```
Cutscene States → Signals
├─ Camera changes
├─ Dialogue triggers
├─ Gameplay pauses
└─ Scene transitions
```

## When NOT to Use Animator Integration

Animator integration isn't appropriate when:

- **Logic unrelated to animation** - Use code subscriptions
- **High-frequency updates** - OnStateUpdate is expensive
- **No Animator** - Requires Mecanim Animator
- **Simple triggers** - Animation Events may be simpler

## Animation Events vs State Behaviours

**Use Animation Events when:**
- Frame-specific timing needed
- Single point in animation
- Example: Footstep sound on specific frame

**Use State Behaviours when:**
- State-level events
- Enter/exit timing
- Example: Enable hitbox during attack state

**Use both when:**
- State behaviour for state logic
- Animation events for frame-specific effects

## Related Features

- [**Timeline Integration**](/docs/integrations/timeline) - Timeline signals
- [**All Channel Types**](/docs/channels) - Explore all signal channels

## Next Steps

- [**Input System Integration**](/docs/integrations/input-system) - Learn about Input System
- [**UnityEvent Integration**](/docs/integrations/unityevents) - Connect signals to UnityEvents
