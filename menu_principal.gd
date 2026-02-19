extends Control

# Para trocar de cena use o inspetor
@export var cena_gameplay: PackedScene

@onready var menu_inicial = $MenuInicial
@onready var menu_config = $MenuConfig

func _on_btn_iniciar_pressed():
	# Abre a cena da gameplay
	get_tree().change_scene_to_packed(cena_gameplay)

func _on_btn_sair_pressed():
	# Fecha o jogo
	get_tree().quit()
	
# função para trocar o menu inicial com o das configurações
func exibir_configuracoes(mostrar_config: bool):
	menu_inicial.visible = !mostrar_config
	menu_config.visible = mostrar_config

# Sinais dos botões das configurações
func _on_btn_config_pressed():
	exibir_configuracoes(true)
	
func _on_btn_voltar_pressed():
	exibir_configuracoes(false)

# Variaveis para guardas as configurações dos canais de audio
var bus_geral = AudioServer.get_bus_index("Master")
var bus_musica = AudioServer.get_bus_index("Musica")
var bus_sfx = AudioServer.get_bus_index("SFX")

func _on_slider_geral_value_changed(value: float):
	AudioServer.set_bus_volume_db(bus_geral, linear_to_db(value / 100))
	
func _on_slider_musica_value_changed(value: float):
	AudioServer.set_bus_volume_db(bus_musica, linear_to_db(value / 100))
	
func _on_slider_sfx_value_changed(value: float):
	AudioServer.set_bus_volume_db(bus_sfx, linear_to_db(value / 100))
	
# Configuração da tela cheia
func _on_check_tela_cheia_toggled(toggled_on: bool):
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
