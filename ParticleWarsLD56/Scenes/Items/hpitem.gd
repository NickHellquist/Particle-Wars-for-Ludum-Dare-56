extends Area2D

@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("player")
@onready var collision: CollisionShape2D = $CollisionShape2D

var hptext: Texture = preload("res://Graphics/LD56Heart.png")
var maxhptext: Texture = preload("res://Graphics/LD56Blackheart.png")
@onready var sprite: Sprite2D = $Sprite2D


var target = null
var speed: float = -0.5

func _ready() -> void:
	if player.hp < player.maxhp:
		sprite.texture = hptext
	elif player.maxhp >= player.maxhp_cap:
		sprite.texture = maxhptext
	else:
		queue_free()

func _physics_process(delta):
	if target != null:
		global_position = global_position.move_toward(target.global_position, speed)
		speed += 2 * delta

func _on_body_entered(body: CharacterBody2D) -> void:
	if body.is_in_group("player") and sprite.texture == hptext:
		if player.hp < player.maxhp:
			collision.call_deferred("set","disabled", true)
			player.attract_area.shape.radius *= 0.90
			player.hp += 1
			player.set_hearts()
			player.current_scale = player.scale
			var tween:Tween = player.create_tween()
			tween.tween_property(player, "scale", player.current_scale * player.size_increase,0.5).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT).from(player.current_scale)
			tween.play()
			queue_free()
	elif body.is_in_group("player") and sprite.texture == maxhptext:
		if player.maxhp < player.maxhp_cap:
			collision.call_deferred("set","disabled", true)
			player.maxhp += 1
			player.set_blackhearts()
			queue_free()
	else:
		queue_free()
