extends HBoxContainer

@onready var pedido_scene: PackedScene = preload("res://Assets/Chocolates/pedido.tscn")

func _ready() -> void:
	for i in range(6):
		var pedido = pedido_scene.instantiate()
		add_child(pedido)

func get_pedidos():
	pass

func set_pedidos():
	pass
