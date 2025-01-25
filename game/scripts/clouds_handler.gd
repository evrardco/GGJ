extends MeshInstance3D
var spawnCloud = load("res://game/scenes/cloud.tscn")
var time_counter: float = 0
@onready var area : BoxMesh = self.mesh
@export var spawn_period : float = 1

# Limites de position pour les nuages
@export var min_x : float = 0
@export var max_x : float = 100
@export var min_y : float = 10
@export var max_y : float = 50
@export var min_z : float = -50
@export var max_z : float = 50

@export var max_abs_x_offset : float = 10
@export var max_abs_y_offset : float = 5
@export var max_abs_z_offset : float = 20

var rng = RandomNumberGenerator.new()
# Appelé lorsque le nœud entre dans l'arbre de la scène pour la première fois.
func _ready() -> void:
	ggj_spawn_cloud()

# Fonction pour générer des nuages de manière aléatoire
func ggj_spawn_cloud():
	
	var spawnCloud_instance = spawnCloud.instantiate()
	var x = self.position.x + rng.randf() * max_abs_x_offset - 2 * rng.randf() * max_abs_x_offset
	var y = 10 + self.position.y + rng.randf() * max_abs_y_offset - rng.randf() * max_abs_y_offset
	var z = self.position.z + rng.randf() * max_abs_z_offset - rng.randf() * max_abs_z_offset
	spawnCloud_instance.position.x = x
	spawnCloud_instance.position.y = y
	spawnCloud_instance.position.z = z
	

	add_child(spawnCloud_instance)

# Appelé à chaque frame. 'delta' est le temps écoulé depuis la frame précédente.
func _process(delta: float) -> void:
	time_counter += delta
	if time_counter >= spawn_period:
		ggj_spawn_cloud()
		time_counter = 0
	
	
