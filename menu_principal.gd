extends Control

# Para trocar de cena use o inspetor
@export var cena_gameplay: PackedScene

func _on_btn_iniciar_pressed():
	# Abre a cena da gameplay
	get_tree().change_scene_to_packed(cena_gameplay)

func _on_btn_sair_pressed():
	# Fecha o jogo
	get_tree().quit()
