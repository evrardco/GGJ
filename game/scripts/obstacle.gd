extends Node3D

class_name Obstacle
var vz : float = 1 
var vy : float = -0.5
@export var life_time : float = 30
var playerLogic : PlayerLogic = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.position.z += delta * vz
	self.position.y += delta * vy
	life_time -= delta
	if life_time <= 0:
		queue_free()
