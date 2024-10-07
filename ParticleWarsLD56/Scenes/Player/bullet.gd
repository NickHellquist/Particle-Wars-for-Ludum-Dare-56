extends Area2D

var hp: int = 1
var speed: float = 120
var damage: float = 1.0
var knockback_amount: float = 100
var attack_size: float = 1.0

@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var sprite: Sprite2D = $Sprite2D
@onready var timer: Timer = $Timer2

var explosion: PackedScene = preload("res://Scenes/Player/bullet_explosion.tscn")


var target:Vector2 = Vector2.ZERO
var angle:Vector2 = Vector2.ZERO
var rotation_speed: float = 4

@onready var point_light: PointLight2D = $PointLight2D

@onready var gpu = $GPUParticles2D

@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("player")
@onready var loot_base: Node2D = get_tree().get_first_node_in_group("loot")

signal remove_from_array(object)

func _ready() -> void:
	attack_size *= player.attack_size
	angle = global_position.direction_to(target)
	rotation = angle.angle() + deg_to_rad(135)
	hp = 2 + player.whp
	speed = 110 * player.projectile_speed
	knockback_amount = 65 * player.knockback_increase
	if Globals.very_hard == true:
		var tween:Tween = create_tween()
		tween.tween_property(self, "scale", Vector2(0.7,0.7) * attack_size,0.5).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT).from(Vector2(0,0))
		tween.play()
	else:
		var tween:Tween = create_tween()
		tween.tween_property(self, "scale", Vector2(1,1) * attack_size,0.5).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT).from(Vector2(0,0))
		tween.play()
func _physics_process(delta):
	position += angle * speed * delta
	rotation += rotation_speed * delta
	
func enemy_hit(charge: int = 1):
	if player.explosion_active == true:
		var randinr: int = randi_range(1,100)
		if randinr <= player.explosion_chance:
			var explo = explosion.instantiate() as Area2D
			explo.position = position
			loot_base.call_deferred("add_child", explo)
	
	hp -= charge
	if hp <= 0:
		point_light.visible = false
		gpu.emitting = true
		sprite.visible = false
		speed *=0.8
		timer.start()
		collision.call_deferred("set","disabled", true)


func _on_timer_timeout() -> void:
	emit_signal("remove_from_array", self)
	queue_free()


func _on_timer_2_timeout() -> void:
	emit_signal("remove_from_array", self)
	queue_free()
