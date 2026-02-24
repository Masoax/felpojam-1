extends PathFollow2D

signal chegou_checagem(tipo_chocolate)

#consatantes pontos no caminho
const PONTO_INICIO:       float = 0.00
const PONTO_CHECAGEM:     float = 0.77
const PONTO_FINAL:        float = 0.99

#constantes estagios do chocolate
const MASSA:     int = 0
const DEFORMADO: int = 10
const FORMADO:   int = 20
const COBERTO:   int = 30
const CARIMBADO: int = 40

const MAX_SPEED = 0.2
const TIPOS_CHOCOLATES: Array[int] = [213141 , 213142 , 213143 , 
									  213241 , 213242 , 213243 , 
									  213341 , 213342 , 213343 , 
									  223141 , 223142 , 223143 , 
									  223241 , 223242 , 223243 , 
									  223341 , 223342 , 223343 ]

@onready var chocolate:          Node2D = $ChocolateBase
@onready var animacoes: AnimationPlayer = $"../../AnimationPlayer"
@onready var pedidos:     HBoxContainer = $"../../Control/Hud/Fundo/BordaPedidos/HBoxContainer"
@onready var speed:               float = MAX_SPEED
@onready var checado:              bool = false
@export  var animacao_acabou:      bool = false

func _ready() -> void:
	chocolate.visible = true
	pedidos.pedido_checado.connect(trata_condicao)
	progress_ratio = 0

func _process(delta: float) -> void:
	progress_ratio += speed * delta
	
	if animacao_acabou:
		volta_inicio()
		animacao_acabou = false
	
	if snappedf(progress_ratio, 0.01) == PONTO_CHECAGEM && not checado:
		trata_checagem()
	
	if progress_ratio > PONTO_FINAL:
		volta_inicio()

func trata_checagem() -> void:
	speed = 0
	checado = true
	if chocolate.tipo_chocolate in TIPOS_CHOCOLATES:
		chegou_checagem.emit(chocolate.tipo_chocolate)
	else:
		animacoes.play("Pedido Errado")

func volta_inicio() -> void:
	progress_ratio = 0
	chocolate.reseta_chocolate()
	visible = true
	checado = false
	speed = MAX_SPEED

func trata_condicao(passou):
	if passou:
		speed = MAX_SPEED
	else:
		animacoes.play("Pedido Errado")
