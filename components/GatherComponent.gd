extends ProgressBar
class_name GatherComponent

@export_enum("Energy") var type: String
@export var AMOUNT_GATHERED: int = 3
@export var GATHER_TIME: int = 3
@export var GATHER_DISTANCE: int = 3

@onready var progress: ProgressBar = %ProgressBar

signal gathered


func _on_entered_gather_area():
	progress.visible = true
	get_tree().create_timer(GATHER_TIME).timeout.connect(_on_timer_timeout)
	progress.value = 0
	create_tween().tween_property(progress,'value',progress.max_value,GATHER_TIME)


func _on_timer_timeout():
	progress.value = 0
	create_tween().tween_property(progress,'value',progress.max_value,GATHER_TIME)
	get_tree().create_timer(GATHER_TIME).timeout.connect(_on_timer_timeout)
	gathered.emit(AMOUNT_GATHERED, _on_resource_received)


func _on_resource_received(amount):
	
