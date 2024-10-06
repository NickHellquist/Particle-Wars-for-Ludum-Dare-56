extends Area2D

var hp: int = 999
var damage: float = 1.0
var attack_size: float = 1.0

@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var sprite: Sprite2D = $Sprite2D
@onready var snd_explosion: AudioStreamPlayer2D = $snd_explosion




@onready var gpu = $GPUParticles2D

@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("player")

signal remove_from_array(object)

func _ready() -> void:
	attack_size *= player.attack_size
	var tween:Tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1,1) * attack_size,0.6).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT).from(Vector2(0,0))
	tween.play()

func play_snd() -> void:
	snd_explosion.play()
func gpu_emit() -> void:
	gpu.emitting = true

func enemy_hit(charge: int = 1):
	hp -= charge

func collision_deactive() -> void:
	collision.call_deferred("set","disabled", true)

func qfree() -> void:
	emit_signal("remove_from_array", self)
	queue_free()
