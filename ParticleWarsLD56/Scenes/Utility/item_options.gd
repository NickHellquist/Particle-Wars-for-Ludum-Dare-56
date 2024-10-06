extends ColorRect

@onready var lblName: Label = $lbl_name
@onready var lblDescription: Label = $lbl_description
@onready var lblRarity: Label = $lbl_rarity
@onready var lblLvl: Label = %lbl_lvl
@onready var highlight: ColorRect = $highlight
@onready var sprite: Sprite2D = $Sprite2D


var item = null
@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("player")
@onready var button: TextureButton = %Button

signal selected_upgrade(upgrade)

func _ready() -> void:
	sprite.visible = false
	highlight.visible = false
	lblLvl.visible = false
	var VeryRare = Color(1,0.8,0.4,0.8)
	var Rare = Color(0.5,0.8,0.9,0.8)
	assert(selected_upgrade.connect(player.upgrade_character) == OK)
	assert(button.pressed.connect(click) == OK)
	if UpgradeDb.UPGRADES[item]["rarity"] == "R10":
		color = VeryRare
	elif UpgradeDb.UPGRADES[item]["rarity"] == "R25":
		color = Rare
	button.grab_focus()
	upgrade()

func upgrade():
	if item == null:
		item = "health"
	lblName.text = UpgradeDb.UPGRADES[item]["displayname"]
	lblDescription.text = UpgradeDb.UPGRADES[item]["details"]
	if UpgradeDb.UPGRADES[item]["type"] == "defensive_modifier":
		lblRarity.text = str("Modifier")
		lblLvl.visible = true
		lblLvl.text = UpgradeDb.UPGRADES[item]["level"]
	elif UpgradeDb.UPGRADES[item]["type"] == "offensive_modifier":
		lblRarity.text = str("Modifier")
		lblLvl.visible = true
		lblLvl.text = UpgradeDb.UPGRADES[item]["level"]
	else:
		lblRarity.text = UpgradeDb.UPGRADES[item]["Raretext"]


func click() -> void:
	selected_upgrade.emit(item)
	#player.audio.volume_db = -5
	#player.audio.stream = player.audiolvlclick
	#player.audio.play()
	pass


func _on_button_mouse_entered() -> void:
	highlight.visible = true
	sprite.visible = true


func _on_button_mouse_exited() -> void:
	highlight.visible = false
	sprite.visible = false

func _on_button_focus_entered() -> void:
	highlight.visible = true
	sprite.visible = true

func _on_button_focus_exited() -> void:
	highlight.visible = false
	sprite.visible = false
