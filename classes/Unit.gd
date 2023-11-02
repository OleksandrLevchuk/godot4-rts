class_name Unit extends CharacterBody2D

@export_enum("None", "Object", "Unit", "Building") var minimap_marker_type : String = "Unit"
@export var SPEED: float = 200

@onready var hover := $UIParent/Hover
@onready var selection := $UIParent/Selection
@onready var engine := $Engine # this node calculates acceleration and turning
@onready var turret := $Turret
@onready var minimap_timer := $MinimapUpdateTimer
@onready var attacked_highlight := $UIParent/Attacked
@onready var health := $UIParent/Health

var is_moving: bool = false

signal minimap_updated
signal died


func _ready():
	Game.minimap.add_marker(self)
	set_process( false ) # only process upon movement
	input_pickable = true # enables mouse hover 
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	engine.halted.connect(_on_engine_halted)
	minimap_timer.timeout.connect(_on_minimap_timer_timeout)


func select():
	selection.visible = true
	Game.deselected.connect(deselect)
	Game.ordered.connect(_on_ordered)


func _on_ordered( order: Order ):
	if order.type == 'point':
		start_moving_to( order.point )
	elif order.type == 'unit':
		start_attacking( order.unit )
	elif order.type == 'turret test':
		turret.shoot()


func start_moving_to(dest: Vector2):
	print('started moving to ', dest )
	if not is_moving:
		is_moving = true
		minimap_timer.start()
		set_process(true)
	engine.start( dest )


func start_attacking( unit ):
#	engine.follow( unit )
	unit.attacked_highlight.flash()
	turret.start_attacking( unit )


func _on_minimap_timer_timeout():
	minimap_updated.emit(position)


func _process(delta):
	velocity = engine.calculate(delta)
	rotation = velocity.angle()
	move_and_slide()


func _on_engine_halted():
	set_process(false)
	is_moving = false
	minimap_timer.stop()


func deselect():
	selection.visible = false
	Game.deselected.disconnect(deselect)
	Game.ordered.disconnect(_on_ordered)


func _on_mouse_entered():
	hover.visible = true


func _on_mouse_exited():
	hover.visible = false
