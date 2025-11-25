extends RigidBody2D

@export var fall_speed: float = 50.0
@export var is_metal: bool = true

func _ready() -> void:
	gravity_scale = 0.1  # Very slow fall
	linear_velocity.y = fall_speed

func _physics_process(delta: float) -> void:
	pass  # Items fall naturally with gravity