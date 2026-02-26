extends Control

# Para trocar de cena use o inspetor
@export var cena_gameplay: PackedScene

@onready var menu_inicial = $MenuInicial
@onready var menu_tutorial = $MenuTutorial
@onready var menu_config = $MenuConfig
@onready var menu_creditos = $MenuCreditos

# Variaveis para salvar as configuções e fazer elas carregarem quando o jogo abrir de novo
const ARQUIVO_SAVE = "user://config.cfg"

@onready var slider_geral = $MenuConfig/SliderGeral
@onready var slider_musica = $MenuConfig/SliderMusica
@onready var slider_sfx = $MenuConfig/SliderSFX
@onready var check_tela_cheia =$MenuConfig/CheckTelaCheia

# Variaveis visuais da bolinha dos sliders
@onready var ball_geral = $MenuConfig/SliderGeral/BallGeral
@onready var ball_musica = $MenuConfig/SliderMusica/BallMusica
@onready var ball_sfx = $MenuConfig/SliderSFX/BallSFX

# Variaveis de som
@onready var musica_menu = $MusicaMenu
@onready var sfx_clique = $SfxCliqueMenu
@onready var sfx_voltar = $SfxCliqueVoltar

# Variaveis da tela de Configurações
@onready var Visual_Config = %CadernoConfig

var textura_janela = preload("res://Sprites/Cadernos/CadernoConfigF.png")
var textura_Cheia = preload("res://Sprites/Cadernos/CadernoConfigW.png")

# Função que carrega as configurações salvas
func _ready():
	carregar_configuracoes()
	musica_menu.play()
	menu_inicial.visible = true
	exibir_tutorial(false)
	exibir_configuracoes(false)
	exibir_creditos(false)

# Função para abrir a cena da gameplay
func _on_btn_iniciar_pressed():
	sfx_clique.play(0.1)
	await get_tree().create_timer(0.3).timeout
	get_tree().change_scene_to_packed(cena_gameplay)
	
# funções para trocar o menu inicial com o do tutorial
func exibir_tutorial(mostrar_tutorial: bool):
	menu_inicial.visible = !mostrar_tutorial
	menu_tutorial.visible = mostrar_tutorial

func _on_btn_tutorial_pressed():
	sfx_clique.play(0.1)
	exibir_tutorial(true)
	
func _on_btn_voltar_pressed():
	sfx_voltar.play()
	exibir_tutorial(false)
	exibir_configuracoes(false)
	exibir_creditos(false)
	
# Funções para trocar o menu inicial com o das configurações
func exibir_configuracoes(mostrar_config: bool):
	menu_inicial.visible = !mostrar_config
	menu_config.visible = mostrar_config
	
func _on_btn_config_pressed():
	sfx_clique.play(0.1)
	exibir_configuracoes(!menu_config.visible)
	
# Função para mudar a posição da ball baseada no slider
func _process(_delta):
	var ballg = (slider_geral.value - slider_geral.min_value) / (slider_geral.max_value - slider_geral.min_value)
	var ballm = (slider_musica.value - slider_musica.min_value) / (slider_musica.max_value - slider_musica.min_value)
	var balls = (slider_sfx.value - slider_sfx.min_value) / (slider_sfx.max_value - slider_sfx.min_value)
	
	ball_geral.position.x = (ballg * 442) - 20
	ball_musica.position.x = (ballm * 436) - 20
	ball_sfx.position.x = (balls * 436) - 20
	
# Variaveis para guardas as configurações dos canais de audio
var bus_geral = AudioServer.get_bus_index("Master")
var bus_musica = AudioServer.get_bus_index("Musica")
var bus_sfx = AudioServer.get_bus_index("SFX")

func _on_slider_geral_value_changed(value: float):
	AudioServer.set_bus_volume_db(bus_geral, linear_to_db(value / 100))
	salvar_configuracoes()
	
func _on_slider_musica_value_changed(value: float):
	AudioServer.set_bus_volume_db(bus_musica, linear_to_db(value / 100))
	salvar_configuracoes()
	
func _on_slider_sfx_value_changed(value: float):
	AudioServer.set_bus_volume_db(bus_sfx, linear_to_db(value / 100))
	salvar_configuracoes()
	
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
	salvar_configuracoes()
		
# funções para trocar o menu inicial com os dos creditos e vice-versa
func exibir_creditos(mostrar_creditos: bool):
	menu_inicial.visible = !mostrar_creditos
	menu_creditos.visible = mostrar_creditos
	
func _on_btn_creditos_pressed():
	sfx_clique.play(0.1)
	exibir_creditos(!menu_creditos.visible)
	
# Função para fechar o jogo
func _on_btn_sair_pressed():
	sfx_voltar.play()
	await get_tree().create_timer(0.3).timeout
	get_tree().quit()
	
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
