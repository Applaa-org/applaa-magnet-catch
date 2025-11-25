extends Node2D

@export var spawn_interval: float = 2.0
@export var item_scene: PackedScene
@export var magnet_scene: PackedScene

var score: int = 0
var spawn_timer: float = 0.0
var magnet: CharacterBody2D

@onready var score_label: Label = $ScoreLabel
@onready var magnet_area: Area2D = $MagnetArea

func _ready() -> void:
	# Instantiate magnet
	magnet = magnet_scene.instantiate()
	add_child(magnet)
	magnet.position = Vector2(get_viewport_rect().size.x / 2, get_viewport_rect().size.y - 50)
	
	# Connect magnet area signal
	magnet_area.connect("body_entered", Callable(self, "_on_magnet_area_body_entered"))
	magnet_area.position = magnet.position

func _process(delta: float) -> void:
	spawn_timer += delta
	if spawn_timer >= spawn_interval:
		spawn_item()
		spawn_timer = 0.0
	
	# Update magnet area position
	magnet_area.position = magnet.position

func spawn_item() -> void:
	var item = item_scene.instantiate()
	add_child(item)
	item.position = Vector2(randf_range(50, get_viewport_rect().size.x - 50), -50)
	# Randomly set if metal or not
	item.is_metal = randi() % 2 == 0

func _on_magnet_area_body_entered(body: Node2D) -> void:
	if body is RigidBody2D and body.is_in_group("item"):
		if body.is_metal:
			score += 1
		else:
			score -= 1
		score_label.text = "Score: " + str(score)
		body.queue_free()