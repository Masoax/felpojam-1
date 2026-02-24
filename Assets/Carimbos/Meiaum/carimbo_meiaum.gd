extends Node2D

@onready var _animation_player = $AnimationPlayer
@onready var _sprite = $Path2D/PathFollow2D/Sprite2D
@onready var _audio_player = $AudioStreamPlayer2D
@onready var permite_clique = false

const SEM_BAPINHO: Texture2D = preload("res://Sprites/gameplay/Carimbos/carimbo_meiaum.png")
const COM_BAPINHO: Texture2D = preload("res://Sprites/gameplay/Carimbos/carimbo_meiaum_com_o_bapinho.png")
#const PRENSA_SFX: AudioStreamMP3 = preload("res://Assets/Sons/windows-shutdown_lWRhnkD.mp3")


func _ready() -> void:
	_sprite.texture = SEM_BAPINHO

func _process(_delta: float) -> void:
	if permite_clique && not _animation_player.is_playing():
		_sprite.texture = COM_BAPINHO
	
	if Input.is_action_pressed("clique") && permite_clique:
		_animation_player.play("CarimbarMeiaum")
		#if not _audio_player.is_playing():
			#_audio_player.stream = PRENSA_SFX
			#_audio_player.play()

func _on_click_control_mouse_entered() -> void:
	permite_clique = true
	_sprite.texture = COM_BAPINHO

func _on_click_control_mouse_exited() -> void:
	permite_clique = false
	if not _animation_player.is_playing():
		_sprite.texture = SEM_BAPINHO
