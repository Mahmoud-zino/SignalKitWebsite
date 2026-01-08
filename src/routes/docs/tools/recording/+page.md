# Recording & Playback

Record, save, and replay signal events during Play mode for debugging and testing. Perfect for reproducing bugs, analyzing event sequences, and testing complex interactions.

## When to Use Recording

Use signal recording when you need to:

- **Debug Event Sequences** - Understand the order and timing of signals
- **Reproduce Bugs** - Record problematic event sequences to replay later
- **Test Edge Cases** - Replay specific event patterns to test behavior
- **Performance Analysis** - Measure how systems respond to signal patterns
- **Documentation** - Record and share event sequences with team members

## How It Works

- **Editor-only** - Recording happens in Unity Editor during Play mode
- **Automatic capture** - Records all signal raises with timestamps
- **Filterable** - Filter by channel, value, or time range
- **Exportable** - Save recordings to JSON files
- **Replayable** - Load and replay saved recordings

## Accessing the Recording Window

Open the Signal Recording window:
- **Unity Menu:** Window → SignalKit → Signal Recorder
- **Keyboard Shortcut:** Ctrl+Shift+R (Cmd+Shift+R on Mac)

## Recording Features

**Basic Recording:**
1. Open Signal Recording window
2. Press "Start Recording" button
3. Enter Play mode
4. Interact with your game
5. Press "Stop Recording"
6. Review recorded events

**Filtering Events:**
- Filter by channel name
- Filter by value content
- Filter by time range
- Search for specific patterns

**Exporting Recordings:**
- Save to JSON file
- Share with team members
- Version control friendly

**Replaying Recordings:**
- Load saved recording
- Play back at original speed
- Adjust playback speed (0.5x, 1x, 2x, 5x)
- Step through events one at a time

## Common Use Cases

**Use Case 1: Debugging Event Order**

```
Problem: Player takes damage before shield activates
Solution: Record event sequence to see exact order

Recorded Events:
1. [0.00s] onEnemyAttack raised
2. [0.01s] onDamageDealt raised (50)
3. [0.05s] onShieldActivated raised
4. [0.06s] onHealthChanged raised (50)

Issue: Shield activates too late!
Fix: Adjust shield activation timing or add priority
```

**Use Case 2: Reproducing Rare Bugs**

```
Problem: Game crashes occasionally during combat
Solution: Record all combat sessions until crash occurs

Recorded before crash:
1. onAbilityUsed (Fireball)
2. onDamageDealt (100)
3. onEnemyDied
4. onAbilityUsed (Fireball) <- during death animation
5. [CRASH]

Issue: Using ability during death animation causes crash
Fix: Disable abilities during death state
```

**Use Case 3: Performance Testing**

```
Problem: Game slows down with many enemies
Solution: Record signals during high-load scenario

Analysis:
- 500 onDamageDealt signals in 1 second
- 200 onHealthChanged signals in 1 second
- 100 onEnemyDied signals in 1 second

Issue: Too many individual damage signals
Fix: Batch damage calculations, raise once per frame
```

**Use Case 4: Tutorial Development**

```
Goal: Create tutorial showing correct sequence
Solution: Record player performing actions correctly

Recorded Sequence:
1. [0s] onPlayerMoved (to chest)
2. [1s] onInteractPressed
3. [1.1s] onChestOpened
4. [2s] onItemCollected (Key)
5. [3s] onPlayerMoved (to door)
6. [4s] onDoorUnlocked

Use: Replay to test tutorial hints timing
```

**Use Case 5: Multiplayer Testing**

```
Problem: Sync issues between clients
Solution: Record signals on both client and server

Client Recording:
1. [0.0s] onPlayerMoved (10, 5, 0)
2. [0.1s] onPlayerMoved (11, 5, 0)
3. [0.2s] onPlayerMoved (12, 5, 0)

Server Recording:
1. [0.0s] onPlayerMoved (10, 5, 0)
2. [0.3s] onPlayerMoved (12, 5, 0) <- Missing middle position!

Issue: Packet loss dropping position updates
Fix: Add interpolation or increase update rate
```

## Recording Window Features

**Event List:**
- Timestamp
- Channel name
- Signal value
- Frame number
- Color-coded by channel type

**Timeline View:**
- Visual timeline of events
- Zoom in/out
- Scrub through recording
- Jump to specific time

**Statistics:**
- Total events recorded
- Events per second
- Most raised channels
- Average time between raises

**Search & Filter:**
- Text search in values
- Filter by channel type
- Time range selection
- Value range filtering

## Best Practices

### Do:
- **Record problematic sessions** - Capture bugs as they happen
- **Save important recordings** - Export to files for later analysis
- **Filter noise** - Focus on relevant channels during analysis
- **Share recordings** - Export and share with team for collaboration
- **Use for testing** - Replay recordings to verify fixes

### Don't:
- **Don't record long sessions** - Recordings can get large (filter instead)
- **Don't record in builds** - Recording is Editor-only feature
- **Don't rely on timing** - Playback timing may vary slightly
- **Don't record sensitive data** - Recordings save values to JSON

## Workflow Example

**Debugging Combat Bug:**

1. **Setup**
   - Open Signal Recorder window
   - Filter to combat-related channels only
   - Start recording

2. **Reproduce**
   - Enter Play mode
   - Perform combat actions until bug occurs
   - Stop recording

3. **Analyze**
   - Review event sequence
   - Look for unexpected order
   - Check timing between events
   - Search for specific values

4. **Export**
   - Save recording as "combat_bug_2024.json"
   - Attach to bug report or version control

5. **Fix & Verify**
   - Implement fix
   - Load saved recording
   - Replay to verify fix works
   - Compare before/after behavior

## Recording File Format

Recordings are saved as JSON:

```json
{
  "version": 1,
  "createdAt": "2024-01-08T14:30:00",
  "duration": 10.5,
  "events": [
    {
      "timestamp": 0.0,
      "channelName": "onPlayerJumped",
      "channelType": "Void",
      "value": null,
      "frame": 0
    },
    {
      "timestamp": 1.5,
      "channelName": "onHealthChanged",
      "channelType": "Int",
      "value": "75",
      "frame": 90
    }
  ]
}
```

## Keyboard Shortcuts

While recording window is focused:

- **Ctrl+R** - Start/Stop recording
- **Ctrl+P** - Play/Pause playback
- **Ctrl+S** - Save recording
- **Ctrl+L** - Load recording
- **Space** - Play/Pause
- **← →** - Step backward/forward
- **Ctrl+F** - Focus search field

## Limitations

**Editor-only:**
- Recording only works in Unity Editor
- Not available in builds
- No runtime recording API

**Performance:**
- Large recordings (1000+ events) may slow Editor
- Filter channels to reduce overhead
- Clear recordings periodically

**Timing:**
- Replay timing approximates original
- Frame-perfect replay not guaranteed
- Use for sequence analysis, not timing precision

## Integration with Debugger

Recording works alongside Signal Debugger:

1. **Signal Debugger** - Real-time monitoring during development
2. **Signal Recorder** - Capture and analyze sequences
3. **Export recordings** - Share with team or save for later

Use both together for complete debugging workflow.

## When NOT to Use Recording

Recording isn't appropriate when:

- **Runtime analysis needed** - Recording is Editor-only
- **Precise timing required** - Playback timing is approximate
- **Sensitive data** - Values saved to JSON files
- **Build testing** - Use logging or analytics instead

## Performance Notes

- Minimal overhead during recording (&lt; 1ms per event)
- Memory scales with event count
- Filter channels to reduce overhead
- Recordings are compressed when saved

## Related Features

- [**Priority System**](/docs/features/priority) - Understand execution order
- [**Filters**](/docs/features/filters) - Conditional listening

## Next Steps

- [**UnityEvent Integration**](/docs/integrations/unityevents) - Connect signals to UnityEvents
- [**Input System Integration**](/docs/integrations/input-system) - Learn about Input System integration
