# Devlog 2026-March

## 2026-03-11
- Refactored the world context and config provider to use a singleton pattern with godot autoloaders.
- Changed the world context and config provider usage to use the autoloader.
- Implemented the seed box for carrot for initial testing.
- Implemented the interatable component for the plot game object.

## 2026-03-12
- Finished the crop planing tool interaction.
- Tested crop stage advancement.
- Created and added the game object component to the tree, grass, plot and crop game objects.
- Refactored the game object manager to store game objects in a registry.
- Removed the physics queries in the interaction manager and integrated the object registries for querying objects at a tile.
- Add crop seed box sprites for carrot, wheat, radish and corn.