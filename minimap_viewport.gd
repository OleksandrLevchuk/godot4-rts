extends SubViewport

const UPDATE_RATE := 1.0
var factory := preload("res://factory_sprite.tscn")
var tank := preload("res://tank_sprite.tscn")
var crystal := preload("res://crystal_sprite.tscn")
var elapsed := 0.0

@onready var units_node = get_tree().get_root().get_node('world/units')
@onready var objects_node = get_tree().get_root().get_node('world/objects')
@onready var buildings_node = get_tree().get_root().get_node('world/buildings')


func update_minimap():
	for unit in $units.get_children():
		var unit_sprite := tank.instantiate()
		$units.add_child(unit_sprite)
		unit_sprite.position = unit.position

func _ready():
	update_minimap()

func _process(delta):
	if elapsed < UPDATE_RATE: 
		elapsed += delta 
	else:
		update_minimap()
		elapsed = 0.0
		
	var cameraWorld = get_tree().get_root().get_node('world/camera')
	$camera.position = cameraWorld.position
	$camera.zoom = cameraWorld.zoom
