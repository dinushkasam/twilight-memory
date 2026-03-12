extends GameObjectComponent


# Overrides
func _ready():
	WorldContext.crop_registry.register_crop(self)
	super()

func _exit_tree():
	WorldContext.crop_registry.unregister_crop(self)
	super()
