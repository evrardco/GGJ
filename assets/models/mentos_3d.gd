extends Node3D

@onready var playerLogic : PlayerLogic = self.get_parent().get_parent().get_parent().get_child(0) as PlayerLogic
@export var life_time : float = 30.0
var rng = RandomNumberGenerator.new()


func _ready() -> void:
	pass

func _process(delta: float) -> void:
	self.position.y -= playerLogic.player_speed * delta
	life_time -= delta
	if life_time <= 0:
		self.queue_free()


func _on_boost_hit_box_area_entered(area: Area3D) -> void:
	if area.name == "BottleHitBox":
		pass
