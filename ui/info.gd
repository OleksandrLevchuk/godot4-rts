extends Label

func update():
	var dict = { 
		'crystals': Game.Crystals,
		'energy': Game.Energy,
	}
	var tempstr = ''
	for key in dict:
		tempstr += key + ': ' + str(dict[key]) + ',\n'
	text = tempstr.left(-2) # remove the trailing comma and line break
