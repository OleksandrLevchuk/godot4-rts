class_name Unit extends CharacterBody2D

@export_enum("None", "Object", "Unit", "Building") var minimap_marker_type : String = "Unit"
@export var SPEED: float = 200
@onready var hover := $UIParent/Hover
@onready var selection := $UIParent/Selection
@onready var engine := $Engine # this node calculates acceleration and turning


func _ready():
	Game.minimap.add_marker(self)
	input_pickable = true
	set_process(false)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	engine.halted.connect(_on_engine_halted)


func select():
	selection.visible = true
	Game.deselected.connect(deselect)
	Game.ordered.connect(_on_ordered)


func _on_ordered( order: Order ):
	if order.type == 'point':
		start_moving_to( order.point )


func start_moving_to(dest: Vector2):
	print('started moving to ', dest )
	# subtracting vectors gives a direction between them
#	velocity = (dest - position).normalized() * SPEED
	engine.start( dest )
	set_process(true)


func _process(delta):
	velocity = engine.calculate(delta)
	rotation = velocity.angle()
	move_and_slide()


func _on_engine_halted():
	set_process(false)


func deselect():
	selection.visible = false
	Game.deselected.disconnect(deselect)
	Game.ordered.disconnect(_on_ordered)


func _on_mouse_entered():
	hover.visible = true


func _on_mouse_exited():
	hover.visible = false
