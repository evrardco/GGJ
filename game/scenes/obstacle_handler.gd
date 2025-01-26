extends Node3D

@export var z_spawn_offset : float = 5
@export var z_spawn_offset_min : float = 3

@export var y_spawn_offset : float = 1.5
@onready var playerLogic : PlayerLogic = %"PlayerLogic"
@export var obstacle_max_vz : float = 2
var rng = RandomNumberGenerator.new()
static var obstacles : Array 
# Called when the node enters the scene tree for the first time.
static func _static_init() -> void:
	obstacles.append(load("res://game/scenes/asteroidcollision.tscn"))
	obstacles.append(load("res://game/scenes/hothairballooncollision.tscn"))
func spawn_obstacle():
	var n_elems = obstacles.size()
	var scene_idx = 0
	if rng.randf_range(0.0, 1.0) < 0.2:
		scene_idx = 1
	else: 
		scene_idx = 0
	var scene = obstacles[scene_idx]
	var instance : Obstacle = scene.instantiate()
	instance.playerLogic = playerLogic
	self.add_child(instance)
	var left = rng.randi() % 2 == 0
	var mul = 0
	if left:
		mul = 1
	else:
		mul = -1
	var z_offset = z_spawn_offset_min +  \
		rng.randf_range(0, 1) * (z_spawn_offset - z_spawn_offset_min)
	var z = self.position.z + mul * z_offset
	var y = self.position.y + rng.randf_range(-1, 1) * y_spawn_offset 
	instance.position.z = z
	instance.position.y = y
	instance.vz = -mul * randf_range(1, obstacle_max_vz)
	
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	if rng.randf() < 0.5:
		return
	spawn_obstacle()
