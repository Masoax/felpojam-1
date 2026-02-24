extends Node2D

@onready var _animation_player = $AnimationPlayer
@onready var _sprite = $Path2D/PathFollow2D/Sprite2D
@onready var permite_clique = false

const SEM_BAPINHO: Texture2D = preload("res://Sprites/gameplay/Carimbos/carimbo_carinha_felps.png")
const COM_BAPINHO: Texture2D = preload("res://Sprites/gameplay/Carimbos/carimbo_carinha_com_bapinho_felps.png")


func _ready() -> void:
	_sprite.texture = SEM_BAPINHO

func _process(_delta: float) -> void:
	if permite_clique && not _animation_player.is_playing():
		_sprite.texture = COM_BAPINHO
	
	if Input.is_action_pressed("clique") && permite_clique:
		_animation_player.play("CarimbarCarinha")

func _on_click_control_mouse_entered() -> void:
	permite_clique = true
	_sprite.texture = COM_BAPINHO

func _on_click_control_mouse_exited() -> void:
	permite_clique = false
	if not _animation_player.is_playing():
		_sprite.texture = SEM_BAPINHO
