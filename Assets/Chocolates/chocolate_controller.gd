#NO carimbo tem uma chance dele criar uma com a cara do felps/dourado, conta como sucesso sempre
#Na checagem verificar tanto o estagio quanto o tipo
#Animação de falha pode ser tanto ele cair na lixeira quanto explodir (segundo só se a da lixeira ficar esquisita)
extends Node2D

#constantes estagios do chocolate
const MASSA:     int = 0
const DEFORMADO: int = 10
const FORMADO:   int = 200000
const COBERTO:   int = 3000
const CARIMBADO: int = 40

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

#constantes para as texturas dos chocolates
const MASSA_SPRITE:             Texture2D = preload("res://Sprites/gameplay/Chocolates/massa_do_chocolate_sem_formato.png")
const QUADRADO:                 Texture2D = preload("res://Sprites/gameplay/Chocolates/Quadrado/chocolate_quadrado.png")
const QUADRADO_DEFORMADO:       Texture2D = preload("res://Sprites/gameplay/Chocolates/Quadrado/chocolate_quadrado_defeituoso.png")
const QUADRADO_ROSA:            Texture2D = preload("res://Sprites/gameplay/Chocolates/Quadrado/chocolate_quadrado_rosa.png")
const QUADRADO_AMARELO:         Texture2D = preload("res://Sprites/gameplay/Chocolates/Quadrado/chocolate_quadrado_amarelo.png")
const QUADRADO_VERDE:           Texture2D = preload("res://Sprites/gameplay/Chocolates/Quadrado/chocolate_quadrado_verde.png")
const QUADRADO_CARINHA_ROSA:    Texture2D = preload("res://Sprites/gameplay/Chocolates/Quadrado/chocolate_quadrado_carinha_rosa.png")
const QUADRADO_CARINHA_AMARELO: Texture2D = preload("res://Sprites/gameplay/Chocolates/Quadrado/chocolate_quadrado_carinha_amarela.png")
const QUADRADO_CARINHA_VERDE:   Texture2D = preload("res://Sprites/gameplay/Chocolates/Quadrado/chocolate_quadrado_carinha_verde.png")
const QUADRADO_BELA_ROSA:       Texture2D = preload("res://Sprites/gameplay/Chocolates/Quadrado/chocolate_quadrado_bela_sapinho_rosa.png")
const QUADRADO_BELA_AMARELO:    Texture2D = preload("res://Sprites/gameplay/Chocolates/Quadrado/chocolate_quadrado_bela_sapinho_amarelo.png")
const QUADRADO_BELA_VERDE:      Texture2D = preload("res://Sprites/gameplay/Chocolates/Quadrado/chocolate_quadrado_bela_sapinho_verde.png")
const QUADRADO_MEIAUM_ROSA:     Texture2D = preload("res://Sprites/gameplay/Chocolates/Quadrado/chocolate_quadrado_meiaum_rosa.png")
const QUADRADO_MEIAUM_AMARELO:  Texture2D = preload("res://Sprites/gameplay/Chocolates/Quadrado/chocolate_quadrado_meiaum_amarelo.png")
const QUADRADO_MEIAUM_VERDE:    Texture2D = preload("res://Sprites/gameplay/Chocolates/Quadrado/chocolate_quadrado_meiaum_verde.png")
const REDONDO:                  Texture2D = preload("res://Sprites/gameplay/Chocolates/Redondo/chocolate_circular.png")
const REDONDO_DEFORMADO:        Texture2D = preload("res://Sprites/gameplay/Chocolates/Redondo/chocolate_circular_defeituoso.png")
const REDONDO_ROSA:             Texture2D = preload("res://Sprites/gameplay/Chocolates/Redondo/chocolate_circular_rosa.png")
const REDONDO_AMARELO:          Texture2D = preload("res://Sprites/gameplay/Chocolates/Redondo/chocolate_circular_amarelo.png")
const REDONDO_VERDE:            Texture2D = preload("res://Sprites/gameplay/Chocolates/Redondo/chocolate_circular_verde.png")
const REDONDO_CARINHA_ROSA:     Texture2D = preload("res://Sprites/gameplay/Chocolates/Redondo/chocolate_circular_carinha_rosa.png")
const REDONDO_CARINHA_AMARELO:  Texture2D = preload("res://Sprites/gameplay/Chocolates/Redondo/chocolate_circular_carinha_amarela.png")
const REDONDO_CARINHA_VERDE:    Texture2D = preload("res://Sprites/gameplay/Chocolates/Redondo/chocolate_circular_carinha_verde.png")
const REDONDO_BELA_ROSA:        Texture2D = preload("res://Sprites/gameplay/Chocolates/Redondo/chocolate_circular_bela_sapinho_rosa.png")
const REDONDO_BELA_AMARELO:     Texture2D = preload("res://Sprites/gameplay/Chocolates/Redondo/chocolate_circular_bela_sapinho_amarelo.png")
const REDONDO_BELA_VERDE:       Texture2D = preload("res://Sprites/gameplay/Chocolates/Redondo/chocolate_circular_bela_sapinho_verde.png")
const REDONDO_MEIAUM_ROSA:      Texture2D = preload("res://Sprites/gameplay/Chocolates/Redondo/chocolate_circular_meiaum_rosa.png")
const REDONDO_MEIAUM_AMARELO:   Texture2D = preload("res://Sprites/gameplay/Chocolates/Redondo/chocolate_circular_meiaum_amarela.png")
const REDONDO_MEIAUM_VERDE:     Texture2D = preload("res://Sprites/gameplay/Chocolates/Redondo/chocolate_circular_meiaum_verde.png")

@onready var sprite:         Sprite2D = $Sprite2D
@onready var area_colisao:     Area2D = $Sprite2D/Area2D
@onready var condicao_sucesso:    int = 0
@onready var estagio:             int = MASSA
@onready var tipo_chocolate:      int = MASSA
@onready var cor:                 int = 0
@onready var forma:               int = 0

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area_colisao.get_overlapping_areas().size() != 2 && not condicao_sucesso:
		if area.is_in_group("Prensa Quadrada"):
			sprite.texture = QUADRADO_DEFORMADO
			if area.name == "AreaDireita":
				sprite.flip_h = true
		elif area.is_in_group("Prensa Redonda"):
			sprite.texture = REDONDO_DEFORMADO
			if area.name == "AreaDireita":
				sprite.flip_h = true
		elif area.is_in_group("Dispenser Rosa"):
			if forma == FORMADO_QUADRADO:
				sprite.texture = QUADRADO_ROSA
			if forma == FORMADO_REDONDO:
				sprite.texture = REDONDO_ROSA
			set_estagio(COBERTO)
			set_tipo(COBERTO_ROSA)
			cor = COBERTO_ROSA
		elif area.is_in_group("Dispenser Amarelo"):
			if forma == FORMADO_QUADRADO:
				sprite.texture = QUADRADO_AMARELO
			if forma == FORMADO_REDONDO:
				sprite.texture = REDONDO_AMARELO
			set_estagio(COBERTO)
			set_tipo(COBERTO_AMARELO)
			cor = COBERTO_AMARELO
		elif area.is_in_group("Dispenser Verde"):
			if forma == FORMADO_QUADRADO:
				sprite.texture = QUADRADO_VERDE
			if forma == FORMADO_REDONDO:
				sprite.texture = REDONDO_VERDE
			set_estagio(COBERTO)
			set_tipo(COBERTO_VERDE)
			cor = COBERTO_VERDE
		else:
			condicao_sucesso += 1
	else:
		if area.is_in_group("Prensa Quadrada"):
			sprite.texture = QUADRADO
			set_estagio(FORMADO)
			set_tipo(FORMADO_QUADRADO)
			forma = FORMADO_QUADRADO
		elif area.is_in_group("Prensa Redonda"):
			sprite.texture = REDONDO
			set_estagio(FORMADO)
			set_tipo(FORMADO_REDONDO)
			forma = FORMADO_REDONDO
		elif area.is_in_group("Carimbo Bela"):
			if forma == FORMADO_QUADRADO:
				if cor == COBERTO_ROSA:
					sprite.texture = QUADRADO_BELA_ROSA
				elif cor == COBERTO_AMARELO:
					sprite.texture = QUADRADO_BELA_AMARELO
				elif cor == COBERTO_VERDE:
					sprite.texture = QUADRADO_BELA_VERDE
			if forma == FORMADO_REDONDO:
				if cor == COBERTO_ROSA:
					sprite.texture = REDONDO_BELA_ROSA
				elif cor == COBERTO_AMARELO:
					sprite.texture = REDONDO_BELA_AMARELO
				elif cor == COBERTO_VERDE:
					sprite.texture = REDONDO_BELA_VERDE
			set_estagio(CARIMBADO)
			set_tipo(CARIMBADO_BELA)
		elif area.is_in_group("Carimbo Carinha"):
			if forma == FORMADO_QUADRADO:
				if cor == COBERTO_ROSA:
					sprite.texture = QUADRADO_CARINHA_ROSA
				elif cor == COBERTO_AMARELO:
					sprite.texture = QUADRADO_CARINHA_AMARELO
				elif cor == COBERTO_VERDE:
					sprite.texture = QUADRADO_CARINHA_VERDE
			if forma == FORMADO_REDONDO:
				if cor == COBERTO_ROSA:
					sprite.texture = REDONDO_CARINHA_ROSA
				elif cor == COBERTO_AMARELO:
					sprite.texture = REDONDO_CARINHA_AMARELO
				elif cor == COBERTO_VERDE:
					sprite.texture = REDONDO_CARINHA_VERDE
			set_estagio(CARIMBADO)
			set_tipo(CARIMBADO_CARINHA)
		elif area.is_in_group("Carimbo Meiaum"):
			if forma == FORMADO_QUADRADO:
				if cor == COBERTO_ROSA:
					sprite.texture = QUADRADO_MEIAUM_ROSA
				elif cor == COBERTO_AMARELO:
					sprite.texture = QUADRADO_MEIAUM_AMARELO
				elif cor == COBERTO_VERDE:
					sprite.texture = QUADRADO_MEIAUM_VERDE
			if forma == FORMADO_REDONDO:
				if cor == COBERTO_ROSA:
					sprite.texture = REDONDO_MEIAUM_ROSA
				elif cor == COBERTO_AMARELO:
					sprite.texture = REDONDO_MEIAUM_AMARELO
				elif cor == COBERTO_VERDE:
					sprite.texture = REDONDO_MEIAUM_VERDE
			set_estagio(CARIMBADO)
			set_tipo(CARIMBADO_MEIAUM)
		condicao_sucesso = 0

func reseta_chocolate() -> void:
	sprite.flip_h = false
	condicao_sucesso = 0
	sprite.texture = MASSA_SPRITE
	cor = 0
	forma = 0
	set_estagio(MASSA)
	tipo_chocolate = 0
	set_monitorable(true)

func set_monitorable(condicao: bool) -> void:
	area_colisao.monitorable = condicao

func set_estagio(estagio_arg: int) -> void:
	estagio = estagio_arg

func set_tipo(tipo: int) -> void:
	tipo_chocolate += tipo
