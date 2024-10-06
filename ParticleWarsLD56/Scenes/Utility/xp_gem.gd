extends Area2D


@export var experience: float = 1

var rotation_speed: float = 4

var target = null
var speed: float = -0.5

@onready var sprite: Sprite2D = $Sprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var sound: AudioStreamPlayer2D = $snd_collected

#func _ready():
	#
	#if experience < 5:
		#return
	#elif experience < 25:
		#sprite.texture = spr_green
	#else:
		#sprite.texture = spr_red

func _physics_process(delta):
	rotation += rotation_speed * delta
	if target != null:
		global_position = global_position.move_toward(target.global_position, speed)
		speed += 2 * delta
	
func collect():
	sound.play()
	collision.call_deferred("set","disabled",true)
	sprite.visible = false
	return experience

func _on_snd_collected_finished():
	queue_free()
