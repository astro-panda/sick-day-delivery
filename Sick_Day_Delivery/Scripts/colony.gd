extends Node2D

signal enemy_spawn

@export var bacteria_count := 1
@export_range(0, 20, 2) var spawn_rate: int
@export_range(0, 1, .025) var spawn_chance: float
@export var bacteriumScene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func createBacterium():
	var bacterium = bacteriumScene.instantiate()
	bacterium.position = Vector2.ZERO
	add_child(bacterium)


func _on_colony_timer_timeout():
	print_debug("spawn bacterium")
	createBacterium()
