# Scene Hierarchy

This document defines the canonical scene hierarchy for the project. A strict hierarchy prevents circular dependencies, unclear ownership, and scene-level spaghetti as the game grows.

---

## 1. Design Goals

* Clear ownership of systems and data
* Predictable communication paths
* Easy debugging and extension
* Consistent depth sorting and rendering

---

## 2. Root World Scene

```
World (Node2D)
├── GroundTileMap      (TileMap)
├── ObjectTileMap      (TileMap, optional)
├── YSort              (YSort)
│   ├── Player         (CharacterBody2D)
│   ├── NPCs           (Node2D)
│   └── Props          (Node2D)
├── InteractionManager (Node)
├── Camera2D           (Camera2D)
└── WorldState         (Node)
```

The `World` scene is the authoritative owner of all runtime gameplay elements.

---

## 3. GroundTileMap

**Responsibility:**

* Floor tiles only
* No depth sorting required

**Rules:**

* Never contains tall tiles
* Never participates in YSort
* Never stores gameplay state

---

## 4. ObjectTileMap (Optional)

**Responsibility:**

* Static tall tiles (trees, walls, buildings)

**Rules:**

* Must be a child of `YSort`
* Tile origin must align with tile base
* No gameplay logic stored here

---

## 5. YSort

**Responsibility:**

* Automatic depth sorting of entities

**Contains:**

* Player
* NPCs
* Props

**Rules:**

* No logic scripts attached
* All children must have origin at feet/base

---

## 6. Player

**Type:** `CharacterBody2D`

**Responsibilities:**

* Movement
* Animation state
* Collision

**Rules:**

* Never directly modifies TileMaps
* Never owns camera
* Reports interactions via InteractionManager

---

## 7. NPCs

**Type:** `Node2D`

Container node for all NPC instances.

**Rules:**

* NPC logic lives inside individual scenes
* NPCs follow same depth and origin rules as Player

---

## 8. Props

**Type:** `Node2D`

Static or semi-static world objects.

Examples:

* Trees
* Chests
* Signs

---

## 9. InteractionManager

**Responsibility:**

* Resolves player intent
* Determines interaction priority

**Examples:**

* Harvest vs talk
* Open chest vs place item

---

## 10. Camera2D

**Responsibility:**

* Follows player smoothly
* Handles zoom and bounds

**Rules:**

* Never moves the player
* Never contains gameplay logic

---

## 11. WorldState

**Responsibility:**

* Holds persistent world data
* Acts as save/load boundary

**Examples:**

* Tile states
* Time of day
* Weather

---

## 12. Communication Rules

* Child → Parent via signals
* Sibling communication via World or Manager nodes
* No deep node path access (avoid `get_parent().get_parent()...`)

---

## 13. Anti-Patterns (Avoid)

* Player directly editing TileMaps
* Logic inside TileMap nodes
* Camera owned by Player
* Mixing ground and object tiles

---

**Last updated:** 2026-01-27
