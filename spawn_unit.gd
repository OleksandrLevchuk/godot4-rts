extends Node2D

@onready var unit = preload("res://tank.tscn")

func _on_yes_pressed():
	var unit_path = get_tree().get_root().get_node('world/units')
	var unit1 = unit.instantiate()
	unit1.position = Vector2(200,200) + Vector2( randi()%100-50, randi()%100-50 )
	unit_path.add_child(unit1)

func _on_no_pressed():
	pass # Replace with function body.
