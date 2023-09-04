extends Node

signal update_ui

var Crystals := 0: 
	set(x): 
		Crystals=x
		update_ui.emit()

var Energy := 0:
	set(x):
		Energy = x
		update_ui.emit()
