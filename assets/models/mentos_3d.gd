extends Node3D

@onready var playerLogic : PlayerLogic = self.get_parent().get_parent().get_parent().get_child(0) as PlayerLogic
@export var life_time : float = 30.0
var rng = RandomNumberGenerator.new()
static var loaded_textures: Array[CompressedTexture2D] = []

static func _static_init() -> void:
	var textures = ["res://assets/models/Mentos3D_0.png", "res://assets/models/Mentos3D_1.png", "res://assets/models/Mentos3D_2.png"]
	for tex_str in textures:
		loaded_textures.append(load(tex_str))

func _ready() -> void:
	_static_init()  # Appel de la méthode pour initialiser les textures
	var tex_idx : int = rng.randi_range(0, loaded_textures.size() - 1)
	self.material_override.albedo_texture = loaded_textures[tex_idx]
	self.flip_h = rng.randi() % 2 == 0

func _process(delta: float) -> void:
	self.position.y -= playerLogic.player_speed * delta
	life_time -= delta
	if life_time <= 0:
		self.queue_free()
