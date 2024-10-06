extends Area2D

@onready var hit_box: Area2D = $HitBox
var enemy_damage: float = 1
signal remove_from_array(object)
var wait_time_size: float = 3
@onready var timer: Timer = $Timer
var size: Vector2 = Vector2(1.0,1.0)

func _ready() -> void:
	if Globals.hard == true:
		wait_time_size = 2
		timer.wait_time = wait_time_size
		timer.start()
		size = Vector2(1.1,1.1)
	elif Globals.very_hard == true:
		wait_time_size = 1.5
		timer.wait_time = wait_time_size
		timer.start()
		size = Vector2(1.2,1.2)
	var tween:Tween = create_tween()
	tween.tween_property(self, "scale", size,wait_time_size).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT).from(Vector2(0,0))
	tween.play()
	hit_box.damage = enemy_damage


func _on_timer_timeout() -> void:
	emit_signal("remove_from_array", self)
	queue_free()
