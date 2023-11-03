@tool
extends EditorPlugin
var switch: bool


func _input(event: InputEvent):
	if event.as_text()=="Shift+Space": # this is the hotkey
		get_viewport().set_input_as_handled() # prevents the actual space character
		if not event.is_pressed(): return # prevents triggering on key release
		switch = not switch 
		get_editor_interface().set_main_screen_editor("2D" if switch else "Script")
