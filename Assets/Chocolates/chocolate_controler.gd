extends Node2D

@onready var area_colisao: Area2D = $Sprite2D/Area2D
@onready var condicao_sucesso = 0
@export var speed = 400

func _process(delta: float) -> void:
	position += Vector2.RIGHT * speed * delta
	#if Input.is_key_pressed(KEY_A):
		#position += Vector2.LEFT * 400 * delta
	#if Input.is_key_pressed(KEY_D):
		#position += Vector2.RIGHT * 400 * delta
		
	if Input.is_key_pressed(KEY_W):
		position = Vector2(90, 520)
		visible = true

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area_colisao.get_overlapping_areas().size() == 2 && condicao_sucesso:
		print("sucesso")
		visible = false
		condicao_sucesso = 0
	else:
		condicao_sucesso += 1
		print("deformou")
	print(condicao_sucesso)
