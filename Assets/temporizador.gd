extends TextureProgressBar

@onready var timer: Timer = $Timer

func _process(_delta: float) -> void:
	value = (timer.time_left / timer.wait_time) * 100
