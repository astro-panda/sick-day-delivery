extends CharacterBody2D

signal on_enemy_ded

@export var acceleration := 20.0
@export var speed := 100
@export var rotation_speed := 250.0

var step_count = randi() % 150
var dying = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play()
	rotation = randf_range(0, 2 * PI)
	GlobalState.report_enemy_created()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	step_count -= 1
	if step_count == 0:
		rotation = randf_range(0, 2 * PI)
		step_count = randi() % 100
	var input_vector := Vector2(0, 1)
	
#	global_position += input_vector.rotated(rotation) * speed * delta
		
	var collision = move_and_collide(input_vector.rotated(rotation) * speed * delta)
	
	if collision:
		var body_name = collision.get_collider().name
		if body_name == "PlayerCell":
			queue_free()

func _on_body_entered(_body):
	destroy_bacteria()

func _on_death_timer_timeout():
	queue_free()
	
func destroy_bacteria():
	self.set_collision_layer_value(1, false)
	await $MobAudioController.act(randi() % 4)
	emit_signal("on_enemy_ded")
	$DeathTimer.start()

	if !dying:
		await GlobalState.report_enemy_destroyed()
		dying = true
	
