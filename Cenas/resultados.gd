extends Control


# Sons FINAIS
@export var som_vitoria: AudioStream
@export var som_derrota: AudioStream
@onready var sfx_clique = $SfxCliqueMenu
@onready var sfx_voltar = $SfxCliqueVoltar

# Imagens para a animação FINAL
@export var img_vitoria1: Texture2D
@export var img_vitoria2: Texture2D
@export var img_derrota1: Texture2D
@export var img_derrota2: Texture2D

var troca_frame = true

# Cenas dos botões
@onready var cena_gameplay: PackedScene = load("res://Cenas/gameplay.tscn")
@onready var cena_menu:     PackedScene = load("res://Cenas/menu_principal.tscn")

# Tela final FINAL
@onready var fundo_final = $ArteFundo
@onready var musica_final = $MusicaFundo
@onready var texto_final = $TextoFundo

# 
func _ready():
	if Resultado.jogador_venceu == true:
		texto_final.text = "Vugnaes sreo! =D"
		musica_final.stream = som_vitoria
		fundo_final.texture = img_vitoria1
	else:
		texto_final.text = "Vugnaes sreo... '-'"
		musica_final.stream = som_derrota
		fundo_final.texture = img_derrota1
				
	musica_final.play()

func _on_timer_gif_timeout():
	troca_frame = !troca_frame
	
	if Resultado.jogador_venceu == true:
		if troca_frame:
			fundo_final.texture = img_vitoria1
		else:
			fundo_final.texture = img_vitoria2
	else:
		if troca_frame:
			fundo_final.texture = img_derrota1
		else:
			fundo_final.texture = img_derrota2

func _on_btn_jogar_novamente_pressed():
	sfx_clique.play(0.1)
	await get_tree().create_timer(0.3).timeout
	get_tree().change_scene_to_packed(cena_gameplay)
	
func _on_btn_menu_pressed():
	sfx_voltar.play()
	await get_tree().create_timer(0.3).timeout
	get_tree().change_scene_to_packed(cena_menu)
