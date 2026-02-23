extends Control

const COR_ROSA:    Color = Color("FF7ED6FF")
const COR_AMARELO: Color = Color("FFFC8DFF")
const COR_VERDE:   Color = Color("9AFE63FF")

const ICONE_REDONDO_BELA:     Texture2D = preload("res://Sprites/gameplay/Chocolates/Icones/icone_chocolate_circular_bela_sapinho_transparente.png")
const ICONE_REDONDO_CARINHA:  Texture2D = preload("res://Sprites/gameplay/Chocolates/Icones/icone_chocolate_circular_carinha_transparente.png")
const ICONE_REDONDO_MEIAUM:   Texture2D = preload("res://Sprites/gameplay/Chocolates/Icones/icone_chocolate_circular_meiaum_transparente.png")
const ICONE_QUADRADO_BELA:    Texture2D = preload("res://Sprites/gameplay/Chocolates/Icones/icone_chocolate_quadrado_bela_sapinho_transparente.png")
const ICONE_QUADRADO_CARINHA: Texture2D = preload("res://Sprites/gameplay/Chocolates/Icones/icone_chocolate_quadrado_carinha_transparente.png")
const ICONE_QUADRADO_MEIAUM:  Texture2D = preload("res://Sprites/gameplay/Chocolates/Icones/icone_chocolate_quadrado_meiaum_transparente.png")

@onready var textura = $PedidoTexture
@onready var cor_fundo = $PedidoTexture/ColorRect
var texturas = [ICONE_QUADRADO_BELA, ICONE_QUADRADO_CARINHA, ICONE_QUADRADO_MEIAUM, 
				ICONE_REDONDO_BELA, ICONE_REDONDO_CARINHA, ICONE_REDONDO_MEIAUM]
var cores    = [COR_AMARELO, COR_ROSA, COR_VERDE]

func _ready() -> void:
	textura.texture = texturas[randi_range(0, 5)]
	cor_fundo.color = cores[randi_range(0, 2)]

func get_textura() -> Texture2D:
	return textura.texture

func set_textura(sprite: Texture2D) -> void:
	textura.texture = sprite

func get_cor_fundo() -> Color:
	return cor_fundo.color

func set_cor_fundo(color: Color) -> void:
	cor_fundo.color = color
