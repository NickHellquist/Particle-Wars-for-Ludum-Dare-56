extends StaticBody2D


func _ready() -> void:
	var tween:Tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1,1),1.0).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT).from(Vector2(0,0))
	tween.play()

func _on_timer_timeout() -> void:
	queue_free()
