extends Node

func desabilita():
	var interagiveis = get_children(true)
	for interagivel in interagiveis:
		interagivel.desabilita()

func habilita():
	var interagiveis = get_children(true)
	for interagivel in interagiveis:
		interagivel.habilita()
