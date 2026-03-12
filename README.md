## Twilight Memory

An isometric farming game prototype built in Godot. This project explores core farming-sim mechanics such as tile-based interactions, crop growth cycles, and simple world object management.

### Current status

Based on the March 2026 devlog, the prototype currently includes:

- **World context & config**: Singleton-style world context and configuration provider via Godot autoloads.
- **Game objects & interaction**:
  - Interactable component for plot game objects.
  - Game object component added to trees, grass, plots, and crops.
  - Game object manager using a registry to track and query objects.
- **Crops & seeds**:
  - Seed box implementation (initially for carrot, extended to wheat, radish, and corn).
  - Crop planting tool interaction and full planting cycle.
  - Crops advance through growth stages up to ripe (currently remain at ripe stage).
- **Interaction queries**:
  - Interaction manager now uses object registries to query objects at a tile instead of physics queries.

### Goals

- Prototype and iterate on core farming mechanics (planting, growth, harvesting).
- Experiment with clean, data-driven world and object management.
- Provide a foundation for future systems such as inventory, economy, and NPCs.

### Getting started

1. **Clone the repository**
   ```bash
   git clone <this-repo-url>
   cd iso-farming-prototype
   ```
2. **Open in Godot**
   - Open the project in your installed version of the Godot editor.
   - Let the editor import assets and scripts.
3. **Run the game**
   - Use the Godot editor to run the main scene and experiment with crop planting and interactions.

> Note: Engine version and detailed setup steps are not yet documented. If you open this project with a different Godot version than originally used, you may need to update project settings or assets manually.

### Contributing / notes

- **Devlogs** in `docs/06_devlog/` track ongoing refactors and new features.
- As the prototype stabilizes, we can expand this README with:
  - Exact Godot version and dependencies.
  - Input mappings and control scheme.
  - Asset credits and licensing details.
