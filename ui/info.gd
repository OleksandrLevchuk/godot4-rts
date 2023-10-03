extends Label

func _ready():
	Game.update_ui.connect(update)
	update()
	
func update():
	# this hefty setup is handy for debugging, when there's a lot of lines
	var dict = { 
		crystals = Game.Crystals,
		energy = Game.Energy,
	}
	var tempstr = ''
	for key in dict:
		tempstr += key + ': ' + str(dict[key]) + '\n'
	text = tempstr
