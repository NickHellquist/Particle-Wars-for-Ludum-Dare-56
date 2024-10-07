extends ColorRect


@onready var sprite: Sprite2D = $Sprite2D
@onready var sprite2: Sprite2D = $Sprite2D2
@onready var boxcheck: HBoxContainer = $HBoxContainer
@onready var boxlabels: HBoxContainer = $HBoxContainer2
@onready var hard: CheckBox = $HBoxContainer/hard
@onready var veryhard: CheckBox = $HBoxContainer/veryhard
@onready var quitbtn: Button = $quitbtn
@onready var fullscreen: CheckBox = $fullscreen
@onready var label_2: Label = $Label2


@onready var anim1: AnimationPlayer = $AnimationPlayer
@onready var anim2: AnimationPlayer = $AnimationPlayer2
@onready var anim3: AnimationPlayer = $AnimationPlayer3
@onready var anim4: AnimationPlayer = $AnimationPlayer4
@onready var button: Button = $Button
@onready var snd_click: AudioStreamPlayer = $snd_click
@onready var music: CheckBox = $music


func _ready() -> void:
	label_2.visible = false
	if Globals.fullscreen == true:
		fullscreen.button_pressed = true
	else:
		fullscreen.button_pressed = false
	if Globals.music == true:
		music.button_pressed = true
	else:
		music.button_pressed = false
	check()
	music.visible = false
	fullscreen.visible = false
	quitbtn.visible = false
	boxcheck.visible = false
	boxlabels.visible = false
	get_tree().paused = true
	sprite.visible = false
	sprite2.visible = false
	button.visible = false

func anim2_play_pos() -> void:
	anim2.stop()
	anim2.play("textpos")
	anim4.play("spritevisible")

func btn_grab_focus() -> void:
	button.grab_focus()


func _on_button_pressed() -> void:
	snd_click.play()
	get_tree().paused = false
	var _play_scene = get_tree().change_scene_to_file("res://Scenes/World/world.tscn")


func _on_hard_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		veryhard.button_pressed = false
		snd_click.play()
		Globals.hard = true
	else:
		Globals.hard = false

func check() -> void:
	if Globals.hard == true:
		hard.button_pressed = true
	elif Globals.very_hard == true:
		veryhard.button_pressed = true
	else:
		veryhard.button_pressed = false
		hard.button_pressed = false

func _on_veryhard_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		snd_click.play()
		hard.button_pressed = false
		Globals.very_hard = true
	else:
		Globals.very_hard = false


func _on_quitbtn_pressed() -> void:
	get_tree().quit()


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
		Globals.music = true
		snd_click.play()
	else:
		Globals.music = false
