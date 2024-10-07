extends Area2D

@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("player")

var grabsize: float = 1000
@onready var sprite: Sprite2D = $Sprite2D
@onready var timer: Timer = $Timer
@onready var collision: CollisionShape2D = $CollisionShape2D

var target = null
var speed: float = -0.5

func _ready() -> void:
	if player.XP_magnet == true:
		queue_free()
	else:
		player.XP_magnet = true

func _physics_process(delta):
	if target != null:
		global_position = global_position.move_toward(target.global_position, speed)
		speed += 2 * delta

func _on_body_entered(body: CharacterBody2D) -> void:
	if body.is_in_group("player"):
		collision.call_deferred("set","disabled", true)
		player.previous_grabarea = player.grabarea.shape.radius
		player.grabarea.shape.radius = 1000
		sprite.visible = false
		print("GRABAREA SIZE: ",player.grabarea.shape.radius)
		timer.start()


func _on_timer_timeout() -> void:
	player.grabarea.shape.radius = player.previous_grabarea
	player.XP_magnet = false
	queue_free()
