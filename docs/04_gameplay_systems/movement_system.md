# Movement System

This document describes how player movement works in the game. The goal is to achieve **smooth, analog-feeling movement** similar to Stardew Valley, while remaining compatible with an isometric tile-based world.

---

## 1. Design Goals

* Smooth, continuous movement (no tile snapping)
* Responsive but relaxed controls
* Predictable collision behavior
* Easy integration with animation later

---

## 2. Movement Model

**Movement Type:** Velocity-based

The player moves freely in world space using continuous velocities rather than tile-to-tile steps.

### Key Characteristics

* Movement uses `CharacterBody2D`
* Velocity is updated every frame
* Tile coordinates are *derived*, not enforced

---

## 3. Input Handling

### Input Actions

Defined in Godot Input Map:

* `move_up`
* `move_down`
* `move_left`
* `move_right`

Input is treated as a **directional vector**, not discrete actions.

---

## 4. Direction Vector

Input is combined into a normalized direction vector:

```gdscript
var input_dir = Vector2(
    Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
    Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
)

if input_dir.length() > 0:
    input_dir = input_dir.normalized()
```

This ensures consistent speed in diagonal movement.

---

## 5. Acceleration & Deceleration

Movement uses acceleration for natural feel.

### Variables

* `max_speed`
* `acceleration`
* `friction`

### Behavior

* Player accelerates toward desired velocity
* Player decelerates smoothly when input stops

This avoids instant starts/stops and feels more organic.

---

## 6. Applying Movement

Movement is applied via `move_and_slide()`.

```gdscript
velocity = velocity.move_toward(input_dir * max_speed, acceleration * delta)
velocity = velocity.move_toward(Vector2.ZERO, friction * delta) if input_dir == Vector2.ZERO else velocity

move_and_slide()
```

---

## 7. Isometric Considerations

Although the world is isometric visually, movement is performed in **world space**.

### Rule

* Player moves along world X/Y axes
* Tile logic handles projection separately

This simplifies collision and physics.

---

## 8. Collision Handling

* Player uses `CollisionShape2D`
* World obstacles use static bodies
* Slopes and vertical movement are ignored

Movement should never directly modify tile state.

---

## 9. Facing Direction

The movement vector determines facing direction.

### Example States

* Up
* Down
* Left
* Right

This data is forwarded to the animation system.

---

## 10. Tile Awareness (Optional)

The player may track the tile they are currently over:

```gdscript
current_tile = tilemap.local_to_map(tilemap.to_local(global_position))
```

Used for:

* Interaction
* Planting
* Contextual actions

---

## 11. Anti-Patterns (Avoid)

* Snapping player to tile centers
* Moving the player via TileMap
* Encoding movement logic in tile coordinates

---

## 12. Future Extensions

* Sprinting
* Movement modifiers (mud, water)
* Mounts or vehicles

---

**Last updated:** 2026-01-27
