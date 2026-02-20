extends Node

#func _process(delta: float) -> void:
	#if Input.is_action_pressed("ui_accept"):
		#DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	#
	#if Input.is_action_pressed("ui_cancel"):
		#DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
