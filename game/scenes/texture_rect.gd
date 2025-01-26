extends TextureRect


@onready var playerLogic : PlayerLogic = self.get_parent().get_parent().get_child(0) as PlayerLogic

var textures = [
	load("res://Fond du ciel.png"),
	load("res://espace.jpg"),
]

func _ready():

	print("PlayerLogic altitude: ", playerLogic.altitude)
	update_texture()

func update_texture():
	if playerLogic.altitude < 200:
		texture = textures[0]  # Image pour basse altitude
	else:
		texture = textures[1]  # Image pour altitude moyenne

func _process(delta: float) -> void:
	update_texture()
