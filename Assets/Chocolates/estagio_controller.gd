extends Node2D

#constantes estagios do chocolate
const MASSA:     int = 0
const DEFORMADO: int = 10
const FORMADO:   int = 200000
const COBERTO:   int = 3000
const CARIMBADO: int = 40

const CHOCOLATES: Array[int] = [213141 , 213142 , 213143 , 
								213241 , 213242 , 213243 , 
								213341 , 213342 , 213343 , 
								223141 , 223142 , 223143 , 
								223241 , 223242 , 223243 , 
								223341 , 223342 , 223343 ]

#COLINHA MONTAR CHOCOLATE        COMO         ID     i
#quadrado_amarelo_carinha = 210000+3100+41 (213141) (0)
#quadrado_amarelo_meiaum  = 210000+3100+42 (213142) (1)
#quadrado_amarelo_bela    = 210000+3100+43 (213143) (2)
#quadrado_rosa_carinha    = 210000+3200+41 (213241) (3)
#quadrado_rosa_meiaum     = 210000+3200+42 (213242) (4)
#quadrado_rosa_bela       = 210000+3200+43 (213243) (5)
#quadrado_verde_carinha   = 210000+3300+41 (213341) (6)
#quadrado_verde_meiaum    = 210000+3300+42 (213342) (7)
#quadrado_verde_bela      = 210000+3300+43 (213343) (8)
#redondo_amarelo_carinha  = 220000+3100+41 (223141) (9)
#redondo_amarelo_meiaum   = 220000+3100+42 (223142) (10)
#redondo_amarelo_bela     = 220000+3100+43 (223143) (11)
#redondo_rosa_carinha     = 220000+3200+41 (223241) (12)
#redondo_rosa_meiaum      = 220000+3200+42 (223242) (13)
#redondo_rosa_bela        = 220000+3200+43 (223243) (14)
#redondo_verde_carinha    = 220000+3300+41 (223341) (15)
#redondo_verde_meiaum     = 220000+3300+42 (223342) (16)
#redondo_verde_bela       = 220000+3300+43 (223343) (17)

#constantes tipos do chocolate
const DEFORMADO_ESQ:     int = 11
const DEFORMADO_DIR:     int = 12
const FORMADO_QUADRADO:  int = 210000
const FORMADO_REDONDO:   int = 220000
const COBERTO_AMARELO:   int = 3100
const COBERTO_ROSA:      int = 3200
const COBERTO_VERDE:     int = 3300
const CARIMBADO_CARINHA: int = 41
const CARIMBADO_MEIAUM:  int = 42
const CARIMBADO_BELA:    int = 43

@onready var area_colisao: Area2D = $Sprite2D/Area2D
@onready var label: Label = $Label
@onready var condicao_sucesso: int = 0
@onready var estagio: int = MASSA
@onready var tipo_chocolate: int = MASSA

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area_colisao.get_overlapping_areas().size() == 2 && condicao_sucesso:
		#Olhar se grupos (groups) ou camadas de colisão (collision layers/masks) são úteis para identificar qual prensa/cobertura/carimbo acertou o chocolate
		#Ver questão de animação para o dispensers de cobertura, algum splash (olhar jogo da gatinha)
		#Verificar qual forma prensou (utilizar o nome/id_unico da prensa)
		#	somar o valor na variavel tipo_chocolate
		#	alterar sprite para o correspondente
		#Realizar o mesmo para as coberturas e para o carimbo
		#Verificar se o cholate passou pela area das prensas sem ser prensado (desabilitar colisão)
		#	realizar o mesmo para a cobertura e carimbo
		#Utilizar do mesmo sistema das prensas para os dispensers e carimbos
		#NO carimbo tem uma chance dele criar uma com a cara do felps/dourado, conta como sucesso sempre
		#Na checagem verificar tanto o estagio quanto o tipo
		#Animação de falha pode ser tanto ele cair na lixeira quanto explodir (segundo só se a da lixeira ficar esquisita)
		
		print("sucesso")
		set_estagio(FORMADO)
		condicao_sucesso = 0
	else:
		condicao_sucesso += 1
		set_estagio(DEFORMADO)
		print("deformou")
	print(condicao_sucesso)

func reseta_chocolate() -> void:
	condicao_sucesso = 0
	set_estagio(MASSA)
	set_monitorable(true)

func set_monitorable(condicao: bool) -> void:
	area_colisao.monitorable = condicao

func set_estagio(estagio_arg: int) -> void:
	estagio = estagio_arg
	if estagio == MASSA:
		label.text = "MASSA"
	elif estagio == DEFORMADO:
		label.text = "DEFORMADO"
	elif estagio == FORMADO:
		label.text = "FORMADO"
	elif estagio == COBERTO:
		label.text = "COBERTO"
	else:
		label.text = "CARIMBADO"
