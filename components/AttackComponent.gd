extends Node2D
class_name AttackComponent

@export var DAMAGE : int = 5
@export var COOLDOWN : float = 2
var target : Node2D

signal attacked


func attack():
	attacked.emit(DAMAGE)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
