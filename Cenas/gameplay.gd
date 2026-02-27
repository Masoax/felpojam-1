extends Node

const ARQUIVO_SAVE = "user://config.cfg"

@onready var MENU: PackedScene = load("res://Cenas/menu_principal.tscn")

@onready var sfx_clique = $SfxCliqueMenu
@onready var sfx_voltar = $SfxCliqueVoltar

@onready var temporizador = $Control/Hud/Fundo/Temporizador
@onready var path_follow = $CaminhoChocolateReto/PathFollow2D
@onready var menu_pause = $Control/PauseMenu
@onready var slider_geral = $Control/PauseMenu/FundoPause/SliderGeral
@onready var slider_musica = $Control/PauseMenu/FundoPause/SliderMusica
@onready var slider_sfx = $Control/PauseMenu/FundoPause/SliderSFX
@onready var check_tela_cheia = $Control/PauseMenu/FundoPause/CheckTelaCheia
@onready var button_pausar = $Control/BtnPausar
@onready var button_voltar = $Control/PauseMenu/FundoPause/BtnVoltar
@onready var button_voltar_menu = $Control/PauseMenu/FundoPause/BtnVoltarMenu
@onready var interagiveis = $interagiveis

# Variaveis visuais da bolinha dos sliders
@onready var ball_geral = $Control/PauseMenu/FundoPause/SliderGeral/BallGeral
@onready var ball_musica = $Control/PauseMenu/FundoPause/SliderMusica/BallMusica
@onready var ball_sfx = $Control/PauseMenu/FundoPause/SliderSFX/BallSFX

# Variaveis da tela de Configurações
@onready var Visual_Config = $Control/PauseMenu/FundoPause/CadernoConfig

var textura_janela = preload("res://Sprites/Cadernos/CadernoConfigF.png")
var textura_Cheia = preload("res://Sprites/Cadernos/CadernoConfigW.png")

# Variaveis para guardas as configurações dos canais de audio
var bus_geral = AudioServer.get_bus_index("Master")
var bus_musica = AudioServer.get_bus_index("Musica")
var bus_sfx = AudioServer.get_bus_index("SFX")

func _ready() -> void:
	interagiveis.habilita()
	menu_pause.visible = false
	habilita_botoes(false)

# Função para mudar a posição da ball baseada no slider
func _process(_delta):
	var ballg = (slider_geral.value - slider_geral.min_value) / (slider_geral.max_value - slider_geral.min_value)
	var ballm = (slider_musica.value - slider_musica.min_value) / (slider_musica.max_value - slider_musica.min_value)
	var balls = (slider_sfx.value - slider_sfx.min_value) / (slider_sfx.max_value - slider_sfx.min_value)
	
	ball_geral.position.x = (ballg * 312) - 15
	ball_musica.position.x = (ballm * 306) - 15
	ball_sfx.position.x = (balls * 306) - 15
	
	if Input.is_action_just_pressed("ui_cancel") && not button_pausar.disabled:
		pausar()
	elif Input.is_action_just_pressed("ui_cancel") && button_pausar.disabled:
		despausar()

func _on_button_pausar_button_down() -> void:
	pausar()

func _on_btn_voltar_button_down() -> void:
	despausar()

func _on_btn_voltar_menu_button_down() -> void:
	get_tree().change_scene_to_packed(MENU)
	
func _on_slider_geral_value_changed(value: float):
	AudioServer.set_bus_volume_db(bus_geral, linear_to_db(value / 100))
	salvar_configuracoes() # Salvando as alterações para quando o jogo abrir de novo
	
func _on_slider_musica_value_changed(value: float):
	AudioServer.set_bus_volume_db(bus_musica, linear_to_db(value / 100))
	salvar_configuracoes() # Salvando as alterações para quando o jogo abrir de novo
	
func _on_slider_sfx_value_changed(value: float):
	AudioServer.set_bus_volume_db(bus_sfx, linear_to_db(value / 100))
	salvar_configuracoes() # Salvando as alterações para quando o jogo abrir de novo
	
# Configuração da tela cheia
func _on_check_tela_cheia_toggled(toggled_on: bool):
	if toggled_on:
		sfx_clique.play(0.1)
		Visual_Config.texture = textura_janela
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		sfx_clique.play(0.1)
		Visual_Config.texture = textura_Cheia
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	salvar_configuracoes() # Salvando as alterações para quando o jogo abrir de novo

# Salvando as configurações para serem usadas quando o jogo for aberto de novo
func salvar_configuracoes():
	var config = ConfigFile.new()
	
	config.set_value("Audio", "Geral", slider_geral.value)
	config.set_value("Audio", "Musica", slider_musica.value)
	config.set_value("Audio", "SFX", slider_sfx.value)
	config.set_value("Video", "TelaCheia", check_tela_cheia.button_pressed)
	
	config.save(ARQUIVO_SAVE)
	
# Carregando as configurações salvas de quando o jogo foi aberto pela ultima vez
func carregar_configuracoes():
	var config = ConfigFile.new()
	
	if config.load(ARQUIVO_SAVE) != OK:
		return
		
	slider_geral.value = config.get_value("Audio", "Geral", 100.0)
	slider_musica.value = config.get_value("Audio", "Musica", 100.0) 
	slider_sfx.value = config.get_value("Audio", "SFX", 100.0)
	check_tela_cheia.button_pressed = config.get_value("Video", "TelaCheia", false)

##false desabilita interações, true habilita
func habilita_botoes(status: bool): 
	slider_geral.editable = status
	slider_musica.editable = status
	slider_sfx.editable = status
	button_pausar.disabled = status
	check_tela_cheia.disabled = not status
	button_voltar.disabled = not status
	button_voltar_menu.disabled = not status

func pausar():
	%TimerEsteira.paused = true
	path_follow.pausar()
	temporizador.pausar()
	interagiveis.desabilita()
	sfx_clique.play(0.1)
	button_pausar.visible = false
	menu_pause.visible = true
	habilita_botoes(true)

func despausar():
	%TimerEsteira.paused = false
	path_follow.despausar()
	temporizador.despausar()
	interagiveis.habilita()
	sfx_clique.play(0.1)
	button_pausar.visible = true
	menu_pause.visible = false
	habilita_botoes(false)

# Masoax passou por aqui
@export var img_esteira1: Texture2D
@export var img_esteira2: Texture2D

@onready var Visual_Esteira = %Esteira

var troca_frame = true

func _on_timer_esteira_timeout():
	troca_frame = !troca_frame
	
	if Resultado.jogador_venceu == true:
		if troca_frame:
			Visual_Esteira.texture = img_esteira1
		else:
			Visual_Esteira.texture = img_esteira2
	else:
		if troca_frame:
			Visual_Esteira.texture = img_esteira1
		else:
			Visual_Esteira.texture = img_esteira2
