extends Area2D
class_name GatherableComponent

@export_enum("Energy","Crystals","Credits") var type
@export var timer : Timer
@export var health_component : HealthComponent

var units_gathering := 0


func damage( attack ):
	if health_component:
		health_component.damage(attack)


#func _get_configuration_warnings():
#	return ["test"]


func _on_body_entered(body):
	if not body.is_in_group('units'): return
	print('entered ', body)
	damage( 1 )
	if units_gathering == 0:
		timer.start()
	units_gathering += 1


func _on_body_exited(body):
	if not body.is_in_group('units'): return
	units_gathering -= 1
	if units_gathering == 0:
		timer.stop()


func _on_gathering_timer_timeout():
	damage( units_gathering )
