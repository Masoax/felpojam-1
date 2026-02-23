extends PathFollow2D

#consatantes pontos no caminho
const PONTO_INICIO:       float = 0.00
const FIM_ZONA_FORMAS:    float = 0.33
const FIM_ZONA_DISPENSER: float = 0.53
const PONTO_CHECAGEM:     float = 0.77
const PONTO_FINAL:        float = 0.99

#constantes estagios do chocolate
const MASSA:     int = 0
const DEFORMADO: int = 10
const FORMADO:   int = 20
const COBERTO:   int = 30
const CARIMBADO: int = 40

const MAX_SPEED = 0.2
const CHOCOLATES: Array[int] = [213141 , 213142 , 213143 , 
								213241 , 213242 , 213243 , 
								213341 , 213342 , 213343 , 
								223141 , 223142 , 223143 , 
								223241 , 223242 , 223243 , 
								223341 , 223342 , 223343 ]

@onready var chocolate = $ChocolateBase

@onready var speed = MAX_SPEED
@onready var checado = false

func _ready() -> void:
	progress_ratio = 0

func _process(delta: float) -> void:
	progress_ratio += speed * delta
	print(chocolate.condicao_sucesso)
	
	if snappedf(progress_ratio, 0.01) == PONTO_CHECAGEM && not checado:
		trata_checagem()
	
	if snappedf(progress_ratio, 0.01) == FIM_ZONA_FORMAS && chocolate.condicao_sucesso > 0:
		chocolate.set_monitorable(false)
		print("AAAA")
	elif snappedf(progress_ratio, 0.01) == FIM_ZONA_DISPENSER && chocolate.condicao_sucesso > 0:
		chocolate.set_monitorable(false)
		print("AAAaaaaaA")
	
	if progress_ratio > PONTO_FINAL:
		volta_inicio()
	
	debug_keys()

func trata_checagem() -> void:
	speed = 0
	checado = true
	
	if chocolate.tipo_chocolate in CHOCOLATES:
		print("chegou correto")
		speed = MAX_SPEED
	else:
		print("chegou errado")
		volta_inicio()

func volta_inicio() -> void:
	progress_ratio = 0
	checado = false
	chocolate.reseta_chocolate()
	speed = MAX_SPEED

func debug_keys() -> void:
	if Input.is_key_pressed(KEY_W):
		progress_ratio = PONTO_INICIO
		chocolate.visible = true
		
	if Input.is_key_pressed(KEY_5):
		chocolate.set_estagio(MASSA)
	if Input.is_key_pressed(KEY_1):
		chocolate.set_estagio(DEFORMADO)
	if Input.is_key_pressed(KEY_2):
		chocolate.set_estagio(FORMADO)
	if Input.is_key_pressed(KEY_3):
		chocolate.set_estagio(COBERTO)
	if Input.is_key_pressed(KEY_4):
		chocolate.set_estagio(CARIMBADO)
