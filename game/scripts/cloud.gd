extends Sprite3D
#todo c'est moche faut changer
@onready var playerLogic : PlayerLogic = self.get_parent().get_parent().get_parent().get_child(0) as PlayerLogic
var rng = RandomNumberGenerator.new()
static var loaded_textures: Array[CompressedTexture2D]
static func _static_init() -> void:
	var textures = ["res://assets/images/nuage01.png","res://assets/images/nuage02.png","res://assets/images/nuage03.png"]
	for tex_str in textures:
		loaded_textures.append(
			load(tex_str)
		)
# Appelé lorsque le nœud entre dans l'arbre de la scène pour la première fois.
func _ready() -> void:
	var tex_idx : int = rng.randi_range(0, 2)
	print("assigning texture #", tex_idx)
	self.texture = loaded_textures[tex_idx]
	self.flip_h = rng.randi() % 2 == 0
	
	
# Appelé à chaque frame. 'delta' est le temps écoulé depuis la frame précédente.
func _process(delta: float) -> void:
	self.position.y -= playerLogic.player_speed * delta
