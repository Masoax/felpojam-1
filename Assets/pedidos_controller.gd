extends HBoxContainer

signal pedido_checado(passou)

const TIPOS_CHOCOLATES: Array[int] = [213141 , 213142 , 213143 , 
									  213241 , 213242 , 213243 , 
									  213341 , 213342 , 213343 , 
									  223141 , 223142 , 223143 , 
									  223241 , 223242 , 223243 , 
									  223341 , 223342 , 223343 ]

const CENA_DERROTA: PackedScene = preload("res://Cenas/derrota_temp.tscn")
const CENA_VITORIA: PackedScene = preload("res://Cenas/vitoria_temp.tscn")

@onready var pedido_scene:       PackedScene = preload("res://Assets/Chocolates/pedido.tscn")
@onready var chocolates:          Array[int] = []
@onready var qtd_chocolates:             int = 0
@onready var caminho_chocolate: PathFollow2D =  $"../../../../../CaminhoChocolateReto/PathFollow2D"

func _ready() -> void:
	caminho_chocolate.chegou_checagem.connect(remove_pedido)
	qtd_chocolates = randi_range(6, 12)
	for i in range(qtd_chocolates):
		var tipo_chocolate = TIPOS_CHOCOLATES[randi_range(0, 17)]
		chocolates.append(tipo_chocolate)
		var pedido = pedido_scene.instantiate()
		pedido.tipo = tipo_chocolate
		add_child(pedido)

func _process(delta: float) -> void:
	if chocolates.is_empty():
		await get_tree().create_timer(0.3).timeout
		get_tree().change_scene_to_packed(CENA_VITORIA)
#quando os pedidos acabarem mandar para tela de vitória

func remove_pedido(tipo_chocolate):
	if tipo_chocolate in chocolates:
		var pedidos = get_children()
		for pedido in pedidos:
			if pedido.tipo == tipo_chocolate:
				remove_child(pedido)
				break
		chocolates.erase(tipo_chocolate)
		pedido_checado.emit(true)
	else:
		pedido_checado.emit(false)


func _on_timer_timeout() -> void:
	await get_tree().create_timer(0.3).timeout
	get_tree().change_scene_to_packed(CENA_DERROTA)
