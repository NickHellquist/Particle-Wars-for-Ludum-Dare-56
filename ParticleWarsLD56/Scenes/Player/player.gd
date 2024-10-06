extends CharacterBody2D

var hp: int = 5
var maxhp: int = 10
var maxhp_cap: int = 10
var movement_speed = 125
var armor: int = 0
var experience: float = 0
var experience_level: int = 1
var collected_experience: float = 0
@onready var snd_click: AudioStreamPlayer = $snd_click
@onready var snd_music: AudioStreamPlayer = $snd_music
@onready var info: Label = %Info
@onready var dashanim: AnimationPlayer = %dashanim


var previous_movement_speed: float = 0

var dash_speed: float = 700
var dash_count: int = 2
var dash_disabled: bool = false

var dash_cooldown: float = 0
var atkspeed: float = 0
var knockback_increase: float = 1
var attack_size: float = 1.0
var whp: int = 0

var size_decrease: float = 0.9
var size_increase: float = 1.1
var current_scale: Vector2 = Vector2(0.5,0.5)
var projectile_speed: float = 1

var invincible_timer: float = 0.50

var previous_grabarea: float = 0

var min_size: Vector2 = Vector2(0.5,0.5)
var max_size: Vector2 = Vector2(1.3,1.3)

var time: int = 0

var itemOptions: PackedScene = preload("res://Scenes/Utility/item_options.tscn")
var bullet: PackedScene = preload("res://Scenes/Player/bullet.tscn")
var dashfx: PackedScene = preload("res://Scenes/Utility/dash_fx.tscn")

var upgrade_options = []

@onready var enemy_close_area: Area2D = $EnemyClose
@onready var enemy_near_collision: CollisionShape2D = $EnemyClose/CollisionShape2D
@onready var enemyclosecircle: Sprite2D = $enemyclosecircle


@onready var attract_area: CollisionShape2D = $CircleEnemyAttract/CollisionShape2D

@onready var atk_timer: Timer = %atkTimer
@onready var atk_timer_2: Timer = %atkTimer2
@onready var enemy_near_timer: Timer = $EnemyNearTimer
@onready var enemy_near_timeratk: Timer = $EnemyNearTimer/EnemyNearTimeratk

var explosion_chance: int = 20
var explosion_active: bool = false
var sgammo: int = 0
var sg_wait_time: float = 60
var sg: PackedScene = preload("res://Scenes/Player/knockback.tscn")

@onready var lblTimer: Label = %lblTimer
@onready var dashlbl: Label = $CanvasLayer/Control/Dashlbl

@onready var expBar: TextureProgressBar = %expBar
@onready var lblLevel: Label = %lblLevel
@onready var level_panel: Panel = %LevelPanel
@onready var upgradeOptions: VBoxContainer = %upgradeOptions
@onready var snd_hit: AudioStreamPlayer = %snd_hit

@onready var dashTimer: Timer = $dashTimer
@onready var dashTimer2: Timer = $dashTimer2
@onready var dashReload: Timer = $dashReload


@onready var heart_1: TextureRect = %heart1
@onready var heart_2: TextureRect = %heart2
@onready var heart_3: TextureRect = %heart3
@onready var heart_4: TextureRect = %heart4
@onready var heart_5: TextureRect = %heart5
@onready var heart_6: TextureRect = %heart6
@onready var heart_7: TextureRect = %heart7
@onready var heart_8: TextureRect = %heart8
@onready var heart_9: TextureRect = %heart9
@onready var heart_10: TextureRect = %heart10

@onready var blackheart_1: TextureRect = %blackheart1
@onready var blackheart_2: TextureRect = %blackheart2
@onready var blackheart_3: TextureRect = %blackheart3
@onready var blackheart_4: TextureRect = %blackheart4
@onready var blackheart_5: TextureRect = %blackheart5
@onready var blackheart_6: TextureRect = %blackheart6
@onready var blackheart_7: TextureRect = %blackheart7
@onready var blackheart_8: TextureRect = %blackheart8
@onready var blackheart_9: TextureRect = %blackheart9
@onready var blackheart_10: TextureRect = %blackheart10
@onready var kbspawner: Node2D = $kbspawner
@onready var snd_win: AudioStreamPlayer = $snd_win
@onready var h_box_container: HBoxContainer = $CanvasLayer/Control/HBoxContainer
@onready var h_box_container_2: HBoxContainer = $CanvasLayer/Control/HBoxContainer2
@onready var hardcheck: CheckBox = %hard
@onready var veryhard: CheckBox = %veryhard


var hard: bool = false
var very_hard: bool = false

var collected_defensive_modifiers: int = 0
var collected_offensive_modifier: int = 0

var ammo: int = 0
var baseammo: int = 1
var additional_ammo: int = 0

var nearammo: int = 0
var near_baseammo: int = 0
var near_additional_ammo: int = 0

var collected_modifiers: Array = []

var enemy_near: Array = []

var nr: int = 3
@onready var lbl_timer: Label = %lbl_timer

@onready var hurt_box: Area2D = $HurtBox
@onready var disable_timer: Timer = $HurtBox/DisableTimer
@onready var grabarea: CollisionShape2D = $GrabArea/CollisionShape2D

@onready var lbl_offensive: Label = %lbl_offensive
@onready var lbl_defensive: Label = %lbl_defensive
@onready var sg_timer: Timer = %sgTimer

@onready var black: ColorRect = %black
@onready var lbl_death: Label = %lbl_death
@onready var deathsprite: Sprite2D = %deathsprite

@onready var deathanim: AnimationPlayer = %deathanim

@onready var buttons: VBoxContainer = %Buttons
@onready var btnplay: Button = %Button
@onready var btnmenu: Button = %Button2
@onready var pausebtn: Button = %pausebtn
@onready var black_2: ColorRect = %black2
@onready var fullscreen: CheckBox = %fullscreen
@onready var hurtanim: AnimationPlayer = $hurtanim
@onready var music: CheckBox = %music

@onready var signal_timer: Timer = %signalTimer

func _ready() -> void:
	if Globals.fullscreen == true:
		fullscreen.button_pressed = true
	else:
		fullscreen.button_pressed = false
	if Globals.music == true:
		music.button_pressed = true
	else:
		music.button_pressed = false
	if Globals.hard == true:
		hardcheck.button_pressed = true
	elif Globals.very_hard == true:
		veryhard.button_pressed = true
	
	dashlbl.text = str("Dash: ",dash_count)
	h_box_container.visible = false
	h_box_container_2.visible = false
	music.visible = false
	fullscreen.visible = false
	lbl_timer.visible = false
	pausebtn.disabled = true
	pausebtn.visible = false
	black_2.visible = false
	buttons.visible = false
	black.visible = false
	lbl_death.visible = false
	deathsprite.visible = false
	lbl_offensive.text = str("Offensive Modifiers: ",collected_offensive_modifier,"/",nr)
	lbl_defensive.text = str("Defensive Modifiers: ",collected_defensive_modifiers,"/",nr)
	enemy_near_collision.call_deferred("set","disabled", true)
	enemyclosecircle.scale = Vector2(1.0,1.0)
	enemy_close_area.scale = Vector2(1.0,1.0)
	enemyclosecircle.visible = false
	previous_movement_speed = movement_speed
	if Globals.hard == true:
		maxhp = 3
		maxhp_cap = 6
	elif Globals.very_hard == true:
		maxhp = 1
		maxhp_cap = 3
	else:
		maxhp = 6
		maxhp_cap = 10
	maxhp = clamp(maxhp,1,maxhp_cap)
	hp = maxhp
	set_blackhearts()
	set_hearts()
	grabarea.shape.radius = 50
	previous_grabarea = grabarea.shape.radius
	lblLevel.text = str("Level: ", experience_level)
	hp = clamp(hp,0,maxhp)
	set_size()
	current_scale = scale
	set_expbar(experience, calculate_experiencecap())
	level_panel.visible = false
	attack()
	_on_hurt_box_hurt(0, 0, 0)
	
func _physics_process(_delta: float) -> void:
	movement()
func movement():
	var x_mov = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	var y_mov = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	var mov: Vector2 = Vector2(x_mov, y_mov)
	velocity = mov.normalized() * movement_speed
	move_and_slide()
	
	look_at(get_global_mouse_position())
	
	pause()
	
	if dash_count > 0:
		dash()

func pause() -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		if level_panel.visible == true:
			pass
		elif get_tree().paused == false:
			black_2.visible = true
			lbl_death.visible = true
			pausebtn.disabled = false
			pausebtn.visible = true
			buttons.visible = true
			music.visible = true
			pausebtn.grab_focus()
			lbl_death.text = str("Paused")
			snd_music.volume_db = -12
			fullscreen.visible = true
			get_tree().paused = true
		elif get_tree().paused == true and level_panel.visible == false:
			pausebtn.disabled = true
			pausebtn.visible = false
			black_2.visible = false
			lbl_death.visible = false
			buttons.visible = false
			fullscreen.visible = false
			music.visible = false
			snd_music.volume_db = -5
			get_tree().paused = false


func dash():
	if Input.is_action_just_pressed("dash") and dash_count > 0 and dash_disabled == false and velocity != Vector2.ZERO:
		dashlbl.visible = true
		previous_movement_speed = movement_speed
		movement_speed += dash_speed
		if dashTimer.is_stopped():
			dashTimer.start()
		elif dashTimer2.is_stopped():
			dashTimer2.start()
		dash_count -= 1
		dashlbl.text = str("Dash: ",dash_count)
		var dash_fx = dashfx.instantiate() as Node2D
		dash_fx.position = position
		add_child(dash_fx)
		if dash_count <= 0:
			dashlbl.visible = false
		dashReload.start()
		dash_disabled = true
func _on_dash_reload_timeout() -> void:
	movement_speed = previous_movement_speed
	dash_disabled = false

func _on_dash_timer_timeout() -> void:
	dash_count += 1
	dashlbl.visible = true
	dashlbl.text = str("Dash: ",dash_count)
	if dashanim.is_playing():
		pass
	else:
		dashanim.play("dashavailable")
	#lbl_dash.visible = true
	#lbl_dash.text = str("Dash Available: ", dash_count)
func _on_dash_timer_2_timeout() -> void:
	dash_count += 1
	dashlbl.visible = true
	dashlbl.text = str("Dash: ",dash_count)
	if dashanim.is_playing():
		pass
	else:
		dashanim.play("dashavailable")
	#lbl_dash.visible = true
	#lbl_dash.text = str("Dash Available: ", dash_count)
	
func btn_grab_focus():
	btnplay.grab_focus()

func _on_hurt_box_hurt(damage, _angle, _knockback):
		if hurtanim.is_playing() == false:
			hurtanim.play("hurt")
		snd_hit.play()
		hp -= damage
		hp = clamp(hp,0,maxhp)
		set_hearts()
		current_scale = scale
		attract_area.shape.radius *= 1.10
		scale = clamp(scale,min_size,max_size)
		if scale != min_size:
			var tween:Tween = create_tween()
			tween.tween_property(self, "scale", current_scale * size_decrease,0.5).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT).from(current_scale)
			tween.play()
		if sgammo > 0:
			var kb = sg.instantiate() as StaticBody2D
			kb.position = kbspawner.position
			kbspawner.call_deferred("add_child", kb)
			sg_timer.wait_time = sg_wait_time
			sg_timer.start()
			sgammo -= 1
		if hp == 0:
			death()
		#hitsnd.play()
		
func death():
	deathanim.play("new_animation")
	lbl_timer.visible = true
	lbl_timer.text = str("Time: ", time)
	buttons.visible = true
	black.visible = true
	lbl_death.visible = true
	lbl_death.text = str("Defeated")
	get_tree().paused = true

	
func _on_grab_area_area_entered(area):
	if area.is_in_group("loot"):
		area.target = self
	elif area.is_in_group("items"):
		area.target = self
func _on_collect_area_area_entered(area):
	if area.is_in_group("loot"):
		var gem_exp = area.collect()
		calculate_experience(gem_exp)
		
func calculate_experience(gem_exp):
	var exp_required = calculate_experiencecap()
	collected_experience += gem_exp
	if experience + collected_experience >= exp_required: #level up
		collected_experience -= exp_required - experience
		experience_level += 1
		experience = 0
		exp_required = calculate_experiencecap()
		levelup()
	else:
		experience += collected_experience
		collected_experience = 0
		
	set_expbar(experience, exp_required)
	
func calculate_experiencecap():
	var exp_cap = experience_level
	if experience_level < 20:
		exp_cap = experience_level*5
	elif experience_level < 40:
		exp_cap = 95 + (experience_level-19)*8
	else:
		exp_cap = 255 + (experience_level-39)*12
		
	return exp_cap
	
func set_expbar(set_value: float = 1, set_max_value: float = 100):
	expBar.value = set_value
	expBar.max_value = set_max_value

func levelup():
	snd_music.volume_db = -12
	level_panel.visible = true
	lblLevel.text = str("Level:", experience_level)
	var tween = level_panel.create_tween()
	tween.tween_property(level_panel,"modulate",Color(1,1,1,1),0.2).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN).from(Color(1,1,1,0))
	tween.play()

	var options: int = 0
	var optionsmax: int = 3
	while options < optionsmax:
		var option_choices = itemOptions.instantiate() as ColorRect
		option_choices.item = get_random_item()
		upgradeOptions.add_child(option_choices)
		options += 1
	get_tree().paused = true
	
func get_random_item():
	var randnumber: int = randi_range(1,100)
	var dblist = []
	for i in UpgradeDb.UPGRADES:
		if i in collected_modifiers: 
			pass
		elif i in upgrade_options: 
			pass
		elif UpgradeDb.UPGRADES[i]["level"] == "Level 1" and UpgradeDb.UPGRADES[i]["type"] == "defensive_modifier" and collected_defensive_modifiers > 2:
			pass
		elif UpgradeDb.UPGRADES[i]["level"] == "Level 1" and UpgradeDb.UPGRADES[i]["type"] == "offensive_modifier" and collected_offensive_modifier > 2:
			pass
		elif UpgradeDb.UPGRADES[i]["rarity"] == "R10" and randnumber >= 10:
			pass
		elif UpgradeDb.UPGRADES[i]["rarity"] == "R25" and randnumber >= 25:
			pass
		elif maxhp == maxhp_cap and UpgradeDb.UPGRADES[i]["displayname"] == "maxhp1":
			pass 
		elif UpgradeDb.UPGRADES[i]["prerequisite"].size() > 0:
			var to_add = true
			for n in UpgradeDb.UPGRADES[i]["prerequisite"]:
				if not n in collected_modifiers:
					to_add = false
			if to_add:
				dblist.append(i)
		else:
			dblist.append(i)
	if dblist.size() > 0:
		var randomitem = dblist.pick_random()
		upgrade_options.append(randomitem)
		return randomitem
	else:
		return null
func upgrade_character(upgrade):
	match upgrade:
		"knockback1":
			knockback_increase += 0.050
			print(knockback_increase)
		"knockback2":
			knockback_increase += 0.10
		"knockback3":
			knockback_increase += 0.15
		"attackspeed1":
			atkspeed += 0.05
			print(atkspeed)
		"attackspeed2":
			atkspeed += 0.10
		"attackspeed3":
			atkspeed += 0.20
		"bulletsize1":
			attack_size += 0.050
		"bulletsize2":
			attack_size += 0.075
		"bulletsize3":
			attack_size += 0.10
		"DashCooldown1":
			dash_cooldown += 0.025
		"DashCooldown2":
			dash_cooldown += 0.050
		"DashCooldown3":
			dash_cooldown += 0.10
		"maxhp1":
			collected_defensive_modifiers += 1
			lbl_defensive.text = str("Defensive Modifiers: ",collected_defensive_modifiers,"/",nr)
			collected_modifiers.append(upgrade)
			scale = clamp(scale,min_size,max_size)
			if maxhp <= maxhp_cap:
				attract_area.shape.radius *= 0.90
				hp = clamp(hp,0,maxhp)
				hp += 2
				maxhp += 2
				set_blackhearts()
				set_hearts()
				current_scale = scale
				if scale != max_size:
					var tween:Tween = create_tween()
					tween.tween_property(self, "scale", current_scale * size_increase,0.5).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT).from(current_scale)
					tween.play()
			else:
				if hp < maxhp:
					attract_area.shape.radius *= 0.90
					hp = clamp(hp,0,maxhp)
					hp += 2
					set_hearts()
					current_scale = scale
					if scale != max_size:
						var tween:Tween = create_tween()
						tween.tween_property(self, "scale", current_scale * size_increase,0.5).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT).from(current_scale)
						tween.play()
		"maxhp2":
			collected_modifiers.append(upgrade)
			scale = clamp(scale,min_size,max_size)
			if maxhp <= maxhp_cap:
				attract_area.shape.radius *= 0.90
				hp = clamp(hp,0,maxhp)
				hp += 2
				maxhp += 2
				set_blackhearts()
				set_hearts()
				current_scale = scale
				if scale != max_size:
					var tween:Tween = create_tween()
					tween.tween_property(self, "scale", current_scale * size_increase,0.5).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT).from(current_scale)
					tween.play()
			else:
				if hp < maxhp:
					attract_area.shape.radius *= 0.90
					hp = clamp(hp,0,maxhp)
					hp += 2
					set_hearts()
					current_scale = scale
					if scale != max_size:
						var tween:Tween = create_tween()
						tween.tween_property(self, "scale", current_scale * size_increase,0.5).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT).from(current_scale)
						tween.play()
		"piercing1":
			whp += 1
		"piercing2":
			whp += 2
		"piercing3":
			whp += 3
		"projectilespeed1":
			projectile_speed += 0.10
		"projectilespeed2":
			projectile_speed += 0.15
		"projectilespeed3":
			projectile_speed += 0.20
		"Invinsibility1":
			collected_defensive_modifiers += 1
			lbl_defensive.text = str("Defensive Modifiers: ",collected_defensive_modifiers,"/",nr)
			disable_timer.wait_time += 0.5
			collected_modifiers.append(upgrade)
		"Invinsibility2":
			collected_modifiers.append(upgrade)
			disable_timer.wait_time += 0.25
		"Invinsibility3":
			collected_modifiers.append(upgrade)
			disable_timer.wait_time += 0.25
			
		"xparea1":
			grabarea.shape.radius *= 1.05
			previous_grabarea *= 1.05
		"xparea2":
			grabarea.shape.radius *= 1.10
			previous_grabarea *= 1.10
		"xparea3":
			grabarea.shape.radius *= 1.15
			previous_grabarea *= 1.15
		"movespeed1":
			previous_movement_speed *= 1.050
			movement_speed *= 1.050
		"movespeed2":
			previous_movement_speed *= 1.075
			movement_speed *= 1.075
		"movespeed3":
			previous_movement_speed *= 1.15
			movement_speed *= 1.15
		"baseammo1":
			collected_offensive_modifier += 1
			lbl_offensive.text = str("Offensive Modifiers: ",collected_offensive_modifier,"/",nr)
			collected_modifiers.append(upgrade)
			additional_ammo += 1
		"baseammo2":
			collected_modifiers.append(upgrade)
			additional_ammo += 1
		"enemynear1":
			near_baseammo += 1
			enemy_near_collision.call_deferred("set","disabled", false)
			collected_offensive_modifier += 1
			lbl_offensive.text = str("Offensive Modifiers: ",collected_offensive_modifier,"/",nr)
			collected_modifiers.append(upgrade)
			enemyclosecircle.visible = true
		"enemynear2":
			collected_modifiers.append(upgrade)
			near_additional_ammo += 1
		"enemynear3":
			collected_modifiers.append(upgrade)
			near_additional_ammo += 1
		"explosiveshot1":
			collected_offensive_modifier += 1
			lbl_offensive.text = str("Offensive Modifiers: ",collected_offensive_modifier,"/",nr)
			explosion_chance = 20
			explosion_active = true
			collected_modifiers.append(upgrade)
		"explosiveshot2":
			collected_modifiers.append(upgrade)
			explosion_chance += 10
		"explosiveshot3":
			collected_modifiers.append(upgrade)
			explosion_chance += 20
		"safeguard1":
			collected_modifiers.append(upgrade)
			collected_defensive_modifiers += 1
			lbl_defensive.text = str("Defensive Modifiers: ",collected_defensive_modifiers,"/",nr)
			sgammo += 1
			sg_wait_time = 60
		"safeguard2":
			collected_modifiers.append(upgrade)
			sg_wait_time = 45
		"safeguard3":
			collected_modifiers.append(upgrade)
			sg_wait_time = 30
	var option_children = upgradeOptions.get_children()
	for i in option_children:
		i.queue_free()
	upgrade_options.clear()
	attack()
	level_panel.visible = false
	get_tree().paused = false
	snd_music.volume_db = -5
	calculate_experience(0)
	
func change_time(argtime = 0):
	time = argtime
	var get_m = int (time/60.0)
	var get_s = time % 60
	if get_m < 10:
		get_m = str(0, get_m)
	if get_s < 10:
		get_s = str(0, get_s) 
	lblTimer.text = str(get_m, ":", get_s)
	
func attack() -> void:
	atk_timer.wait_time *= (1-atkspeed) 
	if atk_timer.wait_time <= atk_timer_2.wait_time:
		atk_timer.wait_time += 0.10
	if atk_timer.is_stopped():
		atk_timer.start()
	if enemy_near_timer.is_stopped():
		enemy_near_timer.start()

func _on_atk_timer_timeout() -> void:
	ammo += baseammo + additional_ammo
	atk_timer_2.start()

func _on_timer_timeout() -> void:
	if ammo > 0:
		var atk = bullet.instantiate() as Area2D
		atk.position = position
		atk.target = get_global_mouse_position()
		add_child(atk)
		ammo -= 1
		if ammo > 0:
			atk_timer_2.start()
		else:
			atk_timer_2.stop()

	
func _on_enemy_near_timer_timeout() -> void:
	nearammo += near_baseammo + near_additional_ammo
	enemy_near_timeratk.start()

func _on_enemy_near_timeratk_timeout() -> void:
	if nearammo > 0 and enemy_near != []:
		var atk = bullet.instantiate() as Area2D
		atk.position = position
		atk.target = get_close_target()
		add_child(atk)
		enemy_near_timer.start()
		nearammo -= 1
		if nearammo > 0:
			enemy_near_timeratk.start()
		else:
			enemy_near_timeratk.stop()
			
func _on_circle_enemy_atk_body_entered(body: CharacterBody2D) -> void:
	if body.is_in_group("CircleEnemy"):
		body.state = body.HIT


func _on_circle_enemy_atk_body_exited(body: CharacterBody2D) -> void:
	if body.is_in_group("CircleEnemy"):
		body.state = body.SURROUND

func _on_circle_enemy_attract_body_entered(body: CharacterBody2D) -> void:
	if body.is_in_group("CircleEnemy"):
		body.attack_timer.start()

func _on_circle_enemy_attract_body_exited(body: CharacterBody2D) -> void:
	if body.is_in_group("CircleEnemy"):
		body.attack_timer.stop()
		body.state = body.SURROUND

func set_hearts() -> void:
	if hp >= 10:
		heart_10.visible = true
	else:
		heart_10.visible = false
	if hp >= 9:
		heart_9.visible = true
	else:
		heart_9.visible = false
	if hp >= 8:
		heart_8.visible = true
	else:
		heart_8.visible = false
	if hp >= 7:
		heart_7.visible = true
	else:
		heart_7.visible = false
	if hp >= 6:
		heart_6.visible = true
	else:
		heart_6.visible = false
	if hp >= 5:
		heart_5.visible = true
	else:
		heart_5.visible = false
	if hp >= 4:
		heart_4.visible = true
	else:
		heart_4.visible = false
	if hp >= 3:
		heart_3.visible = true
	else:
		heart_3.visible = false
	if hp >= 2:
		heart_2.visible = true
	else:
		heart_2.visible = false
	if hp >= 1:
		heart_1.visible = true
	else:
		heart_1.visible = false

func set_blackhearts() -> void:
	if maxhp >= 1:
		blackheart_1.visible = true
	else:
		blackheart_1.visible = false
	if maxhp >= 2:
		blackheart_2.visible = true
	else:
		blackheart_2.visible = false
	if maxhp >= 3:
		blackheart_3.visible = true
	else:
		blackheart_3.visible = false
	if maxhp >= 4:
		blackheart_4.visible = true
	else:
		blackheart_4.visible = false
	if maxhp >= 5:
		blackheart_5.visible = true
	else:
		blackheart_5.visible = false
	if maxhp >= 6:
		blackheart_6.visible = true
	else:
		blackheart_6.visible = false
	if maxhp >= 7:
		blackheart_7.visible = true
	else:
		blackheart_7.visible = false
	if maxhp >= 8:
		blackheart_8.visible = true
	else:
		blackheart_8.visible = false
	if maxhp >= 9:
		blackheart_9.visible = true
	else:
		blackheart_9.visible = false
	if maxhp >= 10:
		blackheart_10.visible = true
	else:
		blackheart_10.visible = false
		
func set_size() -> void:
	scale = clamp(scale,min_size,max_size)
	if hp == 1:
		scale = min_size
	elif hp == 2:
		scale = Vector2(0.6,0.6)
	elif hp == 3: 
		scale = Vector2(0.7,0.7)
	elif hp == 5: 
		scale = Vector2(0.8,0.8)
	elif hp == 6:
		scale = Vector2(0.9,0.9)
	elif hp == 7:
		scale = Vector2(1.0,1.0)
	elif hp == 8:
		scale = Vector2(1.1,1.1)
	elif hp == 9:
		scale = Vector2(1.2,1.2)
	elif hp >= 10:
		scale = max_size

func _on_enemy_close_body_entered(body: CharacterBody2D) -> void:
	if not enemy_near.has(body):
		enemy_near.append(body)

func _on_enemy_close_body_exited(body: CharacterBody2D) -> void:
	if enemy_near.has(body):
		enemy_near.erase(body)
		
func get_close_target() -> Vector2:
	if enemy_near.size() > 0:
		return enemy_near.pick_random().global_position
	else:
		return Vector2.UP


func _on_sg_timer_timeout() -> void:
	sgammo += 1


func _on_button_pressed() -> void:
	snd_click.play()
	get_tree().paused = false
	var _play_scene = get_tree().change_scene_to_file("res://Scenes/World/world.tscn")


func _on_button_2_pressed() -> void:
	snd_click.play()
	get_tree().paused = false
	var _menu_scene = get_tree().change_scene_to_file("res://Scenes/Utility/start_meny.tscn")

func on_bossdead():
	#buttons.visible = true
	#lbl_death.visible = true
	#lbl_timer.visible = true
	lbl_timer.text = str("Time: ", lblTimer.text)
	if Globals.hard == true:
		lbl_death.text = str("Victory! Still too easy ...")
	elif Globals.very_hard == true:
		lbl_death.text = str("We have a Champion!")
	else:
		lbl_death.text = str("Victory! Too easy ...")
	snd_music.stop()
	if Globals.music == true:
		snd_win.play()
	deathanim.play("victory")
	get_tree().paused = true


func _on_info_timer_timeout() -> void:
	dashanim.play("fadeinfo")


func _on_pausebtn_pressed() -> void:
	pausebtn.disabled = true
	pausebtn.visible = false
	black_2.visible = false
	lbl_death.visible = false
	buttons.visible = false
	fullscreen.visible = false
	music.visible = false
	snd_music.volume_db = -5
	snd_click.play()
	get_tree().paused = false


func _on_fullscreen_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		Globals.fullscreen = true
		snd_click.play()
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		Globals.fullscreen = false


func _on_music_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		if snd_music.playing == false:
			snd_music.play()
		Globals.music = true
		snd_click.play()
	else:
		if snd_music.playing == true:
			snd_music.stop()
		Globals.music = false


func _on_signal_timer_timeout() -> void:
	on_bossdead()


func _on_veryhard_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		snd_click.play()
		hardcheck.button_pressed = false
		Globals.very_hard = true
	else:
		Globals.very_hard = false


func _on_hard_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		veryhard.button_pressed = false
		snd_click.play()
		Globals.hard = true
	else:
		Globals.hard = false
