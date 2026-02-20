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

# Função que carrega as configurações salvas
func _ready():
	carregar_configuracoes()

# Função para abrir a cena da gameplay
func _on_btn_iniciar_pressed():
	get_tree().change_scene_to_packed(cena_gameplay)
	
# funções para trocar o menu inicial com o do tutorial
func exibir_tutorial(mostrar_tutorial: bool):
	menu_inicial.visible = !mostrar_tutorial
	menu_tutorial.visible = mostrar_tutorial

func _on_btn_tutorial_pressed():
	exibir_tutorial(true)
	
func _on_btn_voltar_pressed():
	exibir_tutorial(false)
	exibir_configuracoes(false)
	exibir_creditos(false)
	
# funções para trocar o menu inicial com o das configurações
func exibir_configuracoes(mostrar_config: bool):
	menu_inicial.visible = !mostrar_config
	menu_config.visible = mostrar_config

func _on_btn_config_pressed():
	exibir_configuracoes(true)
	
#func _on_btn_voltar_pressed():
#	exibir_configuracoes(false)
#	exibir_tutorial(false)

# Variaveis para guardas as configurações dos canais de audio
var bus_geral = AudioServer.get_bus_index("Master")
var bus_musica = AudioServer.get_bus_index("Musica")
var bus_sfx = AudioServer.get_bus_index("SFX")

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
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	salvar_configuracoes() # Salvando as alterações para quando o jogo abrir de novo
		
# funções para trocar o menu inicial com os dos creditos
func exibir_creditos(mostrar_creditos: bool):
	menu_inicial.visible = !mostrar_creditos
	menu_creditos.visible = mostrar_creditos

func _on_btn_creditos_pressed():
	exibir_creditos(true)
	
#func _on_btn_voltar_pressed():
		
# Função para fechar o jogo
func _on_btn_sair_pressed():
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
