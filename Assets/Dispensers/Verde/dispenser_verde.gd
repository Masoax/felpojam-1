extends Node2D

@onready var _animation_player = $AnimationPlayer
@onready var _caminhante = $Path2D/PathFollow2D
@onready var _sprite = $Path2D/PathFollow2D/CoberturaVerde
@onready var _audio_player = $AudioStreamPlayer2D
@onready var permite_clique = false

#const PRENSA_SFX: AudioStreamMP3 = preload("res://Assets/Sons/windows-shutdown_lWRhnkD.mp3")


func _ready() -> void:
	_sprite.visible = false

func _process(_delta: float) -> void:
	if _caminhante.progress_ratio > 0.99:
		_caminhante.progress_ratio = 0
	
	if Input.is_action_pressed("clique") && permite_clique:
		_animation_player.play("DispensarVerde")
		#if not _audio_player.is_playing():
			#_audio_player.stream = PRENSA_SFX
			#_audio_player.play()

func _on_click_control_mouse_entered() -> void:
	permite_clique = true

func _on_click_control_mouse_exited() -> void:
	permite_clique = false
