extends Node
var done = "
	change the tank orientation as it moves
	make some visual at the point you click, where the tank heads to
	optimize the way the select box sends a signal to the world node indirectly through the ui node
"
var todo = "
	fix the tank trembling when going in a straight line
	fix the tank forever trying to go through walls
	fix the tank running circles when the target is too close
	organize the fking project folder, maybe put scripts into a separate one
	i want triangular selection boxes
	i want some verticality
	as of now, there's only a drag selection. implement a single unit selection too
	instead of a constant speed, make the tank accelerate gradually, with reduced turn rate at high speeds
	deal with that terrible aliasing, like wtf. docs.godotengine.org/en/stable/tutorials/2d/2d_antialiasing.html
	try to make a photoshop like navigation in godot
	make the tank turret separate for future animations
	look into pathfinding...
	maybe precalculate destinations of units in moving groups, try making a visual aid first
"
