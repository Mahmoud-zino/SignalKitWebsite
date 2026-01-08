# Timeline Integration

Raise SignalChannels from Unity Timeline using Signal Tracks, Clips, and Markers. Perfect for cutscenes, cinematics, and synchronized gameplay events.

## When to Use Timeline Integration

Use Timeline integration when you need:

- **Cutscene Events** - Trigger gameplay from cinematics
- **Synchronized Timing** - Precise timing for audio, VFX, gameplay
- **Cinematic Gameplay** - Blend cutscenes with interactive moments
- **Scripted Sequences** - Designer-controlled event sequences
- **Complex Timing** - Visual timeline editor for event coordination

## How It Works

- **Signal Tracks** - Timeline tracks for signal events
- **Signal Clips** - Clips that raise signals at specific times
- **Signal Markers** - Point-in-time signal raises
- **All channel types** - Clips and markers for all 14 channel types
- **Preview support** - Signals raise in Editor during Timeline preview

## Timeline Integration Types

**Signal Markers:**
- Point-in-time events
- Raise signal at exact timestamp
- Best for simple triggers

**Signal Clips:**
- Duration-based events
- Raise signal when clip starts/ends
- Useful for state changes

**Signal Tracks:**
- Container for clips and markers
- Organize related signals
- Multiple tracks for organization

## Setup

1. Install Unity Timeline package (built-in)
2. Create Timeline asset
3. Add Signal Track to Timeline
4. Add Signal Clips or Markers
5. Assign SignalChannels in Inspector

## Available Timeline Types

**Signal Markers (14 types):**
- VoidSignalMarker
- BoolSignalMarker
- IntSignalMarker
- FloatSignalMarker
- DoubleSignalMarker
- StringSignalMarker
- Vector2SignalMarker
- Vector2IntSignalMarker
- Vector3SignalMarker
- Vector3IntSignalMarker
- ColorSignalMarker
- (Plus 3 more)

**Signal Clips (14 types):**
- VoidSignalClip
- IntSignalClip
- FloatSignalClip
- (And 11 more matching marker types)

## Common Patterns

**Pattern 1: Cutscene Triggers (Markers)**

```
Timeline: Opening Cutscene
├─ Signal Track: "Game Events"
│  ├─ [0.0s] VoidMarker → onCutsceneStarted
│  ├─ [5.5s] VoidMarker → onDialogueTriggered
│  ├─ [12.0s] VoidMarker → onDoorOpened
│  └─ [15.0s] VoidMarker → onCutsceneEnded

Result: Precise timing for cutscene events
```

**Pattern 2: Camera Shake (Clips)**

```
Timeline: Explosion Sequence
├─ Signal Track: "Effects"
│  ├─ [2.0-2.5s] FloatClip → onCameraShake (intensity: 0.8)
│  └─ [4.0-4.3s] FloatClip → onCameraShake (intensity: 1.0)

Result: Camera shakes during explosions
```

**Pattern 3: Enemy Spawning (Markers)**

```
Timeline: Boss Fight
├─ Signal Track: "Spawns"
│  ├─ [10s] Vector3Marker → onSpawnEnemy (position: 10, 0, 5)
│  ├─ [15s] Vector3Marker → onSpawnEnemy (position: -10, 0, 5)
│  └─ [20s] Vector3Marker → onSpawnEnemy (position: 0, 0, 10)

Result: Enemies spawn at specific times/positions
```

**Pattern 4: UI Messages (Markers)**

```
Timeline: Tutorial Sequence
├─ Signal Track: "UI"
│  ├─ [0s] StringMarker → onShowMessage ("Welcome!")
│  ├─ [3s] StringMarker → onShowMessage ("Press SPACE to jump")
│  └─ [6s] StringMarker → onShowMessage ("Collect coins!")

Result: Tutorial messages appear on schedule
```

**Pattern 5: Music Transitions (Clips)**

```
Timeline: Level Music
├─ Signal Track: "Audio"
│  ├─ [0-30s] StringClip → onMusicState ("Ambient")
│  ├─ [30-60s] StringClip → onMusicState ("Combat")
│  └─ [60-90s] StringClip → onMusicState ("Victory")

Result: Music changes based on clip timing
```

**Pattern 6: Light Color Changes (Markers)**

```
Timeline: Day/Night Cycle
├─ Signal Track: "Lighting"
│  ├─ [0s] ColorMarker → onAmbientColor (Dawn)
│  ├─ [10s] ColorMarker → onAmbientColor (Day)
│  ├─ [20s] ColorMarker → onAmbientColor (Dusk)
│  └─ [30s] ColorMarker → onAmbientColor (Night)

Result: Lighting transitions through day cycle
```

**Pattern 7: Multiple Tracks**

```
Timeline: Complex Cutscene
├─ Signal Track: "Gameplay"
│  ├─ Markers for player actions
├─ Signal Track: "UI"
│  ├─ Markers for UI updates
├─ Signal Track: "Audio"
│  ├─ Clips for music/SFX
└─ Signal Track: "Effects"
   └─ Markers for VFX triggers

Result: Organized, synchronized event system
```

**Pattern 8: Clip Start/End Events**

```
Timeline: Door Sequence
├─ Signal Track: "Doors"
│  └─ [5-10s] IntClip → onDoorState
│     ├─ Start: raises 1 (opening)
│     └─ End: raises 0 (closed)

Result: Door opens at start, closes at end
```

## Signal Markers vs Clips

**Use Markers when:**
- Point-in-time events
- Simple triggers
- No duration needed
- Example: Spawn enemy, play sound, trigger event

**Use Clips when:**
- Duration matters
- State changes
- Start and end events needed
- Example: Music state, door opening, phase transition

## Inspector Configuration

**Signal Marker:**

```
┌─ Void Signal Marker ──────────────┐
│                                    │
│ Time: 5.5s                         │
│ Channel: [onEventTriggered]        │
│                                    │
└────────────────────────────────────┘
```

**Signal Clip:**

```
┌─ Int Signal Clip ─────────────────┐
│                                    │
│ Start: 10.0s                       │
│ Duration: 5.0s                     │
│ Channel: [onPhaseChanged]          │
│ Value: [2]                         │
│                                    │
└────────────────────────────────────┘
```

## Timeline Playback

**Play Mode:**
```csharp
using UnityEngine;
using UnityEngine.Playables;

public class CutsceneController : MonoBehaviour
{
    [SerializeField] private PlayableDirector timeline;

    public void PlayCutscene()
    {
        timeline.Play();
        // Signals raise automatically during playback
    }
}
```

**Manual Control:**
```csharp
// Jump to specific time
timeline.time = 10.5f;

// Pause
timeline.Pause();

// Resume
timeline.Resume();

// Stop
timeline.Stop();
```

## Best Practices

### Do:
- **Use multiple tracks** - Organize by purpose (UI, Audio, Gameplay)
- **Name tracks clearly** - "Enemy Spawns", not "Track 1"
- **Use markers for triggers** - Simple, point-in-time events
- **Use clips for states** - Duration-based state changes
- **Preview in Editor** - Signals raise during Timeline preview

### Don't:
- **Don't overuse clips** - Markers are simpler for triggers
- **Don't forget to assign channels** - Clips/markers do nothing without channels
- **Don't spam signals** - Avoid too many markers close together
- **Don't use for high-frequency** - Timeline is for scripted events, not constant updates

## Performance Considerations

**Minimal overhead:**
- Timeline integration is lightweight
- Signals only raise during playback
- No Update() or polling
- Same performance as regular signal raises

**Recommendation:**
- Use freely for cutscenes and cinematics
- No performance concerns for typical use

## Debugging Timeline Signals

**Timeline Window:**
- See markers and clips visually
- Scrub timeline to test timing
- Preview raises signals in Editor

**Signal Debugger:**
- Open Window → SignalKit → Signal Debugger
- Play timeline in Editor
- See signals raise in real-time
- Verify correct channels and values

**Common Issues:**
- Channel not assigned → No signal raised
- Wrong channel type → Compilation error
- Marker at wrong time → Use Timeline scrubbing to verify

## Creating Custom Timeline Types

Generate custom signal clips/markers:

```
Tools → SignalKit → Generate Timeline Integration

Select your custom type:
- MyCustomData struct

Generates:
- MyCustomDataSignalClip.cs
- MyCustomDataSignalMarker.cs
```

Or extend manually:

```csharp
using SignalKit.Runtime.Integrations.Timeline;
using UnityEngine;

[System.Serializable]
public class CustomSignalMarker : SignalMarkerBase<CustomData>
{
    [SerializeField]
    private CustomData value;

    protected override CustomData GetValue() => value;
}
```

## Integration with Timeline Features

**Control Tracks:**
- Use alongside Animation, Audio, Activation tracks
- Signals coordinate with other Timeline features

**Track Bindings:**
- Signal tracks don't need bindings
- Channels assigned per marker/clip

**Playable Director:**
- Control playback speed
- Loop timeline
- Signals respect speed and looping

## When NOT to Use Timeline Integration

Timeline integration isn't appropriate when:

- **High-frequency events** - Use code for rapid signals
- **Dynamic timing** - Timeline is for pre-authored sequences
- **Gameplay-driven events** - Use code for gameplay-responsive signals
- **No Timeline package** - Requires Unity Timeline package

## Example: Boss Fight Timeline

```
Timeline: "Dragon Boss Fight"
├─ Signal Track: "Phase Changes"
│  ├─ [0s] IntMarker → onBossPhase (1)
│  ├─ [30s] IntMarker → onBossPhase (2)
│  └─ [60s] IntMarker → onBossPhase (3)
│
├─ Signal Track: "Music"
│  ├─ [0-30s] StringClip → onMusicState ("Phase1")
│  ├─ [30-60s] StringClip → onMusicState ("Phase2")
│  └─ [60-90s] StringClip → onMusicState ("Phase3")
│
├─ Signal Track: "Enemy Spawns"
│  ├─ [15s] Vector3Marker → onSpawnEnemy (left)
│  ├─ [20s] Vector3Marker → onSpawnEnemy (right)
│  ├─ [45s] Vector3Marker → onSpawnEnemy (center)
│  └─ [70s] Vector3Marker → onSpawnEnemy (all)
│
└─ Signal Track: "UI Updates"
   ├─ [0s] StringMarker → onShowMessage ("Phase 1 Begin!")
   ├─ [30s] StringMarker → onShowMessage ("Phase 2!")
   └─ [60s] StringMarker → onShowMessage ("Final Phase!")
```

## Related Features

- [**All Channel Types**](/docs/channels) - Explore all signal channels
- [**Animator Integration**](/docs/integrations/animator) - Animator signals

## Next Steps

- [**Animator Integration**](/docs/integrations/animator) - Learn about Animator integration
- [**Input System Integration**](/docs/integrations/input-system) - Learn about Input System
