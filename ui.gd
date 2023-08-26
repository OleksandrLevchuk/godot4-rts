extends CanvasLayer
signal area_selected # we will signal the world script to select units

func _on_selectbox_area_selected(rect): # figure out a better way of doing this
	emit_signal("area_selected", rect )
