# Coordinate Systems

This document describes all coordinate systems used in the project and how they relate to each other. A clear understanding of these systems is critical for movement, rendering, depth sorting, mouse picking, and saving/loading.

---

## 1. Overview

The game uses **three main coordinate spaces**:

1. **World Coordinates** – Godot’s 2D coordinate system (pixels)
2. **Tile Coordinates** – Logical grid coordinates (tile-based)
3. **Screen / Mouse Coordinates** – Player input space

Each system has a clear responsibility and should not be mixed casually.

---

## 2. World Coordinates

**Type:** `Vector2`

World coordinates are the native coordinate system used by Godot. All nodes exist in world space.

### Characteristics

* Origin `(0, 0)` is at the top-left
* +X → right
* +Y → down
* Units are pixels

### Usage

* Rendering sprites
* Physics and collision
* Depth sorting (Y-based)
* Camera movement

### Important Rule

World coordinates should be treated as **continuous** and never snapped directly for gameplay logic.

---

## 3. Tile Coordinates

**Type:** `Vector2i`

Tile coordinates represent the logical grid of the world.

### Characteristics

* Discrete integer values
* Origin `(0, 0)` refers to the first tile in the map
* Independent of pixel resolution

### Usage

* Farming logic (planted, tilled, watered)
* Pathfinding
* Saving/loading world state
* Interaction logic

### Example

```text
Tile (5, 3)
```

Represents the 6th column and 4th row in the logical grid.

---

## 4. Isometric Projection

The game uses an **isometric (diamond) projection** rendered via Godot’s `TileMap`.

### Tile Orientation

* Tiles are diamond-shaped
* Logical grid axes do not align with screen axes

### Visual Mapping

```text
Tile X increases → down-right
Tile Y increases → down-left
```

Godot handles this internally through the TileMap configuration.

---

## 5. TileMap Local Coordinates

Each TileMap has its own local coordinate space.

### Conversions

* **Tile → Local:** `map_to_local(tile_coords)`
* **Local → Tile:** `local_to_map(local_pos)`

These functions should be used instead of manual math.

---

## 6. Mouse / Screen Coordinates

Mouse input is received in **screen space**.

### Conversion Flow

```text
Mouse (screen)
→ Camera
→ World
→ TileMap local
→ Tile coordinates
```

### Example

```gdscript
var mouse_pos = get_global_mouse_position()
var local_pos = tilemap.to_local(mouse_pos)
var tile_coords = tilemap.local_to_map(local_pos)
```

---

## 7. Player Positioning Strategy

The player uses **world coordinates for movement** but may track an optional tile reference.

### Rules

* Movement is smooth and continuous
* Player is never snapped to tile centers
* Tile coordinates are derived when needed

This allows Stardew Valley–style movement.

---

## 8. Depth Sorting

Depth sorting is based on **world Y position**.

### Rule

> Lower Y value = drawn behind
> Higher Y value = drawn in front

### Implementation

* All entities that overlap vertically are children of a `YSort` node
* The origin of sprites is placed at their **feet / base**

No manual Z-index calculations are used.

---

## 9. Saving & Loading Considerations

Tile coordinates are preferred for persistence.

### Why

* Resolution independent
* Stable across camera or projection changes
* Easier versioning

World coordinates may be reconstructed from tile + offset if needed.

---

## 10. Golden Rules

* Never store gameplay logic in world pixels
* Always convert explicitly between spaces
* Prefer Godot’s built-in TileMap helpers
* Keep coordinate responsibilities separated

---

## 11. Future Extensions

* Chunk-based tile coordinates
* Multi-layer tilemaps (ground / objects)
* Height or elevation layers

---

**Last updated:** 2026-01-27
