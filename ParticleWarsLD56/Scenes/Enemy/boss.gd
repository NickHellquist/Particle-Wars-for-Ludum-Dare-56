extends CharacterBody2D

@onready var attack_timer: Timer = %attacktimer

#var velocity: Vector2 = Vector2.ZERO

var randomnum: float

enum {
	SURROUND,
	ATTACK,
	HIT,
	DASH,
}

var state = SURROUND
var dash_duration: float = 1.2

@onready var dash_timer: Timer = %dashTimercd
var dash_timercd_wait_time: float = 10
@onready var circle_timer: Timer = %CircleTimer

@export var movement_speed: float = 100.0
@export var hp: float = 20
@export var knockback_recovery: float = 3.5
@export var experience: float = 1
@export var enemy_damage: float = 1

var knockback:Vector2 = Vector2.ZERO

@onready var sprite:Sprite2D = $Sprite2D
@onready var anim: AnimationPlayer = $AnimationPlayer

@onready var hitbox:Area2D = $HitBox
@onready var collision: CollisionShape2D = $HitBox/CollisionShape2D
@onready var hurtbox:Area2D = $HurtBox
@onready var shaderTimer: Timer = %shaderTimer
@onready var dash_timercd: Timer = %dashTimercd
@onready var circlespawn: Node2D = $circlespawn

var size_decrease: float = 0.9
var size_increase: float = 1.1
var current_scale: Vector2 = Vector2(0.2,0.2)
var min_size: Vector2 = Vector2(1.2,1.2)
var max_size: Vector2 = Vector2(2.0,2.0)


@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("player")
@onready var loot_base: Node2D = get_tree().get_first_node_in_group("loot")
@onready var snd_hit: AudioStreamPlayer2D = $snd_hit
@onready var timer: Timer = %Timer
var death_anim: PackedScene = preload("res://Scenes/Enemy/enemydeath.tscn")
var hit: PackedScene = preload("res://Scenes/Enemy/enemyhit.tscn")
var circle: PackedScene = preload("res://Scenes/Enemy/bossdmgcircle.tscn")
var hpitem_chance: int = 10
var xpmagnet_chance: int = 5
 
var radius: int
var previous_move_speed: float 
var dash_speed: int = 500
var dash_target: Vector2
var circle_wait_timer: float = 12

signal remove_from_array(object)

var count: int = 1
#Performance
var screen_size

func _ready():
	previous_move_speed = movement_speed
	if Globals.hard == true:
		dash_speed = 400
		hp += 10
		dash_duration = 1.5
		attack_timer.wait_time = randf_range(1,2.5)
		dash_timercd_wait_time = 12
		circle_wait_timer = 10
		experience += 1
		xpmagnet_chance+=2
		movement_speed += 5
		hpitem_chance = 5
		hp += 2
	elif Globals.very_hard == true:
		dash_speed = 500
		hp += 20
		dash_duration = 2
		attack_timer.wait_time = randf_range(1,1.5)
		dash_timercd_wait_time = 8
		circle_wait_timer = 6
		experience += 2
		xpmagnet_chance+=3
		movement_speed += 5
		hpitem_chance = 2
		hp += 2
	else:
		attack_timer.wait_time = randf_range(1,3.5)
		dash_timercd_wait_time = 15
		dash_speed = 300
		dash_duration = 1.2
	circle_timer.start()
	dash_timercd.start()
		
	collision.call_deferred("set","disabled", true)
	if player.experience_level > 4:
		experience += 1
		hp += randi_range(0,2)
		movement_speed += 5
	elif player.experience_level > 9:
		experience += 2
		hp += randi_range(0,6)
		movement_speed += 5
	elif player.experience_level > 14:
		experience += 3
		hp += randi_range(0,8)
		movement_speed += 5
	elif player.experience_level > 19:
		experience += 4
		hp += randi_range(2,10)
		movement_speed += 5
	set_size()
	current_scale = scale
	#SET BIGGER SIZE IF HP HIGHER
	
	radius = randi_range(50,30)
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	randomnum = rng.randf()

	add_to_group("enemy")
	
	
	anim.play("walk")
	hitbox.damage = enemy_damage
	screen_size = get_viewport_rect().size

func _physics_process(delta):
	match state:
		SURROUND:
			move(get_circle_position(randomnum), delta)
		ATTACK:
			move(player.global_position, delta)
		HIT:
			move(player.global_position, delta)
		DASH:
			move(dash_target,delta)

func move(target, delta):
	knockback = knockback.move_toward(Vector2.ZERO, knockback_recovery)
	var direction = (target - global_position).normalized() 
	var desired_velocity = direction * movement_speed
	var steering = (desired_velocity - velocity) * delta * 2.5
	velocity += steering
	velocity += knockback
	move_and_slide()

func set_size() -> void:
	scale = clamp(scale,min_size,max_size)
	if hp == 1:
		scale = min_size
	elif hp == 2:
		scale = Vector2(1.3,1.3)
	elif hp == 3: 
		scale = Vector2(1.4,1.4)
	elif hp == 5: 
		scale = Vector2(1.5,1.5)
	elif hp == 6:
		scale = Vector2(1.6,1.6)
	elif hp == 7:
		scale = Vector2(1.7,1.7)
	elif hp == 8:
		scale = Vector2(1.8,1.8)
	elif hp == 9:
		scale = Vector2(1.9,1.9)
	elif hp >= 10:
		scale = max_size


func get_circle_position(random):
	var kill_circle_centre = player.global_position

	var angle = random * PI * 2;
	var x = kill_circle_centre.x + cos(angle) * radius;
	var y = kill_circle_centre.y + sin(angle) * radius;
	return Vector2(x, y)

func death():
	var enemy_death = death_anim.instantiate() as Node2D
	enemy_death.scale = scale
	enemy_death.global_position = global_position
	loot_base.call_deferred("add_child", enemy_death)
	
	player.signal_timer.start()
	Globals.emit_signal("boss_dead")
	
	emit_signal("remove_from_array", self)
	queue_free()


func _on_hurt_box_hurt(damage, angle, knockback_amount):
	snd_hit.play()
	hp -= damage
	knockback = angle * knockback_amount
	sprite.material.set_shader_parameter("start_frame",1)
	sprite.material.set_shader_parameter("mix_ratio",1)
	shaderTimer.start()
	current_scale = scale
	scale = clamp(scale,min_size,max_size)
	
	var enemy_hit = hit.instantiate() as Node2D
	enemy_hit.scale = scale
	enemy_hit.global_position = global_position
	loot_base.call_deferred("add_child", enemy_hit)
	if scale != min_size:
		var tween:Tween = create_tween()
		tween.tween_property(self, "scale", current_scale * size_decrease,0.5).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT).from(current_scale)
		tween.play()
	if hp <= 0:
		#player.lblKillCount.text = str(player.enemies_killed)
		death()



#func _on_hide_timer_timeout():
	#var location_dif = global_position - player.global_position
	#if abs(location_dif.x) > (screen_size.x/2) * 1.4 || abs(location_dif.y) > (screen_size.y/2) * 1.4:
		#visible = false
	#else: 
		#visible = true 
	

func _on_shader_timer_timeout() -> void:
	sprite.material.set_shader_parameter("mix_ratio",0)


func _on_attacktimer_timeout() -> void:
	attack_timer.wait_time = randf_range(1,3.5)
	state = ATTACK
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	randomnum = rng.randf()

func coll() -> void:
	collision.call_deferred("set","disabled", false)


func _on_dash_timercd_timeout() -> void:
	state = DASH
	previous_move_speed = movement_speed
	dash_target = player.global_position
	movement_speed = dash_speed
	timer.start()

func _on_timer_timeout() -> void:
	movement_speed = previous_move_speed
	dash_timercd.start()
	state = ATTACK


func _on_circle_timer_timeout() -> void:
	var crcle = circle.instantiate() as Area2D
	crcle.position = circlespawn.position
	circlespawn.call_deferred("add_child",crcle)
	circle_timer.start()
