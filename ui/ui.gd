extends CanvasLayer

func _ready():
	Game.update_ui.connect($info.update)
