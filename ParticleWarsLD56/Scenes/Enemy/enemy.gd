extends CharacterBody2D

@onready var attack_timer: Timer = %attacktimer

#var velocity: Vector2 = Vector2.ZERO

var randomnum: float

enum {
	SURROUND,
	ATTACK,
	HIT,
}

var state = SURROUND

@export var movement_speed: float = 90.0
@export var hp: float = 1
@export var knockback_recovery: float = 3.5
@export var experience: float = 2
@export var enemy_damage: float = 1

var knockback:Vector2 = Vector2.ZERO

@onready var sprite:Sprite2D = $Sprite2D
@onready var anim: AnimationPlayer = $AnimationPlayer

@onready var hitbox:Area2D = $HitBox
@onready var collision: CollisionShape2D = $HitBox/CollisionShape2D
@onready var hurtbox:Area2D = $HurtBox
@onready var hideTimer:Timer = %hideTimer
@onready var shaderTimer: Timer = %shaderTimer

var size_decrease: float = 0.9
var size_increase: float = 1.1
var current_scale: Vector2 = Vector2(0.2,0.2)
var min_size: Vector2 = Vector2(0.7,0.7)
var max_size: Vector2 = Vector2(1.5,1.5)

@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("player")
@onready var loot_base: Node2D = get_tree().get_first_node_in_group("loot")
@onready var snd_hit: AudioStreamPlayer2D = $snd_hit

var death_anim: PackedScene = preload("res://Scenes/Enemy/enemydeath.tscn")
var exp_gem: PackedScene = preload("res://Scenes/Utility/xp_gem.tscn")
var hpitem: PackedScene = preload("res://Scenes/Items/hpitem.tscn")
var xpmagnet: PackedScene = preload("res://Scenes/Items/xpmagnet.tscn")
var hit: PackedScene = preload("res://Scenes/Enemy/enemyhit.tscn")
var hpitem_chance: int = 10
var xpmagnet_chance: int = 1

var radius: int

signal remove_from_array(object)
var count: int = 1
#Performance
var screen_size

func _ready():
	Globals.boss_dead.connect(death)
	if Globals.hard == true:
		experience += 1
		xpmagnet_chance+=1
		movement_speed += 5
		hpitem_chance = 5
		hp += 2
	elif Globals.very_hard == true:
		experience += 2
		xpmagnet_chance+=4
		movement_speed += 5
		hpitem_chance = 2
		hp += 2
	else:
		pass
	collision.call_deferred("set","disabled", true)
	if player.experience_level > 4:
		hp += randi_range(0,2)
		movement_speed += 5
	elif player.experience_level > 9:
		hp += randi_range(0,6)
		movement_speed += 5
	elif player.experience_level > 14:
		experience += 2
		hp += randi_range(0,8)
		movement_speed += 5
	elif player.experience_level > 19:
		experience += 3
		hp += randi_range(2,10)
		movement_speed += 5
	elif player.experience_level > 24:
		experience += 4
		hp += randi_range(2,10)
		movement_speed += 5
	set_size()
	current_scale = scale
	#SET BIGGER SIZE IF HP HIGHER
	attack_timer.wait_time = randf_range(1,3.5)
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
		scale = Vector2(0.8,0.8)
	elif hp == 3: 
		scale = Vector2(0.9,0.9)
	elif hp == 5: 
		scale = Vector2(1.0,1.0)
	elif hp == 6:
		scale = Vector2(1.1,1.1)
	elif hp == 7:
		scale = Vector2(1.2,1.2)
	elif hp == 8:
		scale = Vector2(1.3,1.3)
	elif hp == 9:
		scale = Vector2(1.4,1.4)
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
	enemy_death.scale = sprite.scale
	enemy_death.global_position = global_position
	loot_base.call_deferred("add_child", enemy_death)
	
	var new_gem = exp_gem.instantiate() as Area2D
	new_gem.global_position = global_position
	new_gem.experience = experience
	loot_base.call_deferred("add_child", new_gem)
	
	var randirange: int = randi_range(1,100)
	if randirange <= hpitem_chance:
		var hpi = hpitem.instantiate() as Area2D
		hpi.global_position = global_position
		loot_base.call_deferred("add_child", hpi)
	
	var rrange: int = randi_range(1,100)
	if rrange <= xpmagnet_chance:
		var xpg = xpmagnet.instantiate() as Area2D
		xpg.global_position = global_position
		loot_base.call_deferred("add_child", xpg)
	
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
	enemy_hit.scale = sprite.scale
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
