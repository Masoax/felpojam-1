extends PathFollow2D

#consatantes pontos no caminho
const PONTO_CHECAGEM = 0.77
const PONTO_INICIO = 0
const PONTO_FINAL = 0.99

#constantes estagios do chocolate
const MASSA:     int = 0
const DEFORMADO: int = 10
const FORMADO:   int = 20
const COBERTO:   int = 30
const CARIMBADO: int = 40

const MAX_SPEED = 0.3

@onready var chocolate = $ChocolateBase

@onready var speed = MAX_SPEED
@onready var checado = false

func _ready() -> void:
	progress_ratio = 0

func _process(delta: float) -> void:
	progress_ratio += speed * delta
	
	if snappedf(progress_ratio, 0.01) == PONTO_CHECAGEM && not checado:
		trata_checagem()
	
	if progress_ratio > PONTO_FINAL:
		volta_inicio()
	
	debug_keys()

func trata_checagem() -> void:
	speed = 0
	checado = true
	
	if chocolate.estagio == CARIMBADO:
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
