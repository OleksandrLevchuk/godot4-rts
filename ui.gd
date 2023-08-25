extends CanvasLayer
signal area_selected # we will signal the world script to select units

func _on_selectbox_area_selected(position, size): # figure out a better way of doing this
	emit_signal("area_selected", position, size )
