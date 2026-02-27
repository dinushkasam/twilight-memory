extends Node
class_name CropComponent


@export var data: CropData
var current_stage = CropStage.SEED

enum CropStage {
	SEED,
	BUD,
	GROWING,
	RIPE,
	STALE,
	HARVESTED
}
