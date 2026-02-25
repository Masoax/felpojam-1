extends Node2D

@onready var click_control = $Sprite2D/ClickControl

@onready var _animation_player = $AnimationPlayer
@onready var _caminhante = $Path2D/PathFollow2D
@onready var _sprite = $Path2D/PathFollow2D/CoberturaAmarela
@onready var permite_clique = false


func _ready() -> void:
	_sprite.visible = false

func _process(_delta: float) -> void:
	if _caminhante.progress_ratio > 0.99:
		_caminhante.progress_ratio = 0
	
	if Input.is_action_pressed("clique") && permite_clique:
		_animation_player.play("DispensarAmarelo")

func _on_click_control_mouse_entered() -> void:
	permite_clique = true

func _on_click_control_mouse_exited() -> void:
	permite_clique = false

func desabilita():
	click_control.mouse_filter = Control.MOUSE_FILTER_IGNORE

func habilita():
	click_control.mouse_filter = Control.MOUSE_FILTER_STOP
