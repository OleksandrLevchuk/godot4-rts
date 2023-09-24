extends Node2D
signal building_selected

func _ready():
	pass # Replace with function body.


func _process(_delta):
	pass


func _on_selected(pos:Vector2, dialog:Resource):
	building_selected.emit(pos, dialog)
