extends Node2D

var units = []
var select_rect = RectangleShape2D.new()
@onready var camera = get_node("Camera")
@onready var camera_offset = get_viewport().get_visible_rect().size/2

func _ready():
	units = get_tree().get_nodes_in_group('units')

func _on_ui_area_selected( rect ):
	for unit in units:
		unit.set_selected( rect.has_point( unit.position + camera_offset ) ) # compensate negative coords to be more positive

func _input(event):
	if Input.is_action_pressed("quit"): get_tree().quit()
