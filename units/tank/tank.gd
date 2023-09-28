extends CharacterBody2D

@onready var minimap_id : int = Game.get_new_minimap_id()


func _ready():
	add_to_group('units', true)
