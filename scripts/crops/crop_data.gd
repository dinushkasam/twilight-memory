extends Resource
class_name CropData


@export var crop_name: String
@export var animation: String
@export var regrows: bool = false

@export var stage_durations: Dictionary = {
	CropComponent.CropStage.SEED: 1.0,
	CropComponent.CropStage.BUD: 1.0,
	CropComponent.CropStage.GROWING: 1.0,
	CropComponent.CropStage.RIPE: 1.0,
	CropComponent.CropStage.STALE: 1.0,
	CropComponent.CropStage.HARVESTED: 1.0
}
