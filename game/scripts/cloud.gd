extends Sprite3D
@onready var playerLogic : PlayerLogic  = self.get_parent().get_parent().get_child(0) as PlayerLogic
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	self.position.y -= playerLogic.player_speed * delta
