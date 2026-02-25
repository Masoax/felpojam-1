extends TextureProgressBar

@onready var timer: Timer = $Timer

func _process(_delta: float) -> void:
	value = (timer.time_left / timer.wait_time) * 100

func pausar():
	timer.paused = true

func despausar():
	timer.paused = false
