extends Node
class_name CropComponent


@export var data: CropData
var current_stage = CropStage.SEED
@export var sprite: AnimatedSprite2D

# TEMP
@export var timer: Timer


enum CropStage {
	SEED,
	BUD,
	GROWING,
	RIPE,
	STALE,
	HARVESTED
}


func update_animation():
	sprite.play(data.animation)
	sprite.set_frame_and_progress(current_stage, 0)
	sprite.pause()

func set_crop(data_arg: CropData):
	data = data_arg
	
	# Start animation
	update_animation()
	start_stage_timer()

func advance_stage():
	var new_stage: int = current_stage + 1
	current_stage = new_stage as CropStage
	update_animation()
	start_stage_timer()
	print("advanced stage")


# TEMP
func start_stage_timer():
	if current_stage >= CropStage.RIPE:
		return
	
	var duration = data.stage_durations.get(current_stage, 0)
	if duration > 0:
		timer.start(duration)
		print("timer started for ", duration, " seconds")

func _on_timer_timeout() -> void:
	advance_stage()
