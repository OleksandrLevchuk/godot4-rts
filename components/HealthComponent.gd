extends ProgressBar
class_name HealthComponent

@onready var bar_bg := %BackgroundBar

signal died


func _ready():
	bar_bg.max_value = max_value
	value = max_value
	bar_bg.value = value
	visible = false


func take_damage( dmg ):
	visible=true
	get_tree().create_timer(3).timeout.connect(func(): visible=false)
	value -= dmg
	create_tween().tween_property( bar_bg, 'value', value, 0.5 ).set_trans(Tween.TRANS_CUBIC)
#	tween.set_ease(Tween.EASE_IN)
	if value <= 0:
		died.emit()
		await get_tree().create_timer(1).timeout
		get_parent().queue_free()


func _on_selected():
	visible = true


func _on_deselected():
	visible = false
