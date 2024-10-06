extends Node2D

@onready var gpu: GPUParticles2D = $GPUParticles2D


func _ready() -> void:
	gpu.emitting = true

func _on_timer_timeout() -> void:
	queue_free()
