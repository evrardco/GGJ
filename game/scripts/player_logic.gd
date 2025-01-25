extends Node
class_name PlayerLogic
var rng = RandomNumberGenerator.new()

@export var player_speed : float = 10
var player_LandR_vitesse : float = 0
@export var player_LandR_posision : float = 0

var player_speed_max : float = 20
var player_speed_min : float = -10
var limite_left : float = -1.7
var limite_right : float = 1.7
@onready var bottle : Node3D = %"Bottle"
# Appelé lorsque le nœud entre dans l'arbre de la scène pour la première fois.
func _ready() -> void:
	pass

# Appelé à chaque frame. 'delta' est le temps écoulé depuis la frame précédente.
func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_SPACE) and player_speed <= player_speed_max :
		player_speed += 15 * delta
	elif !Input.is_key_pressed(KEY_SPACE) and player_speed >= player_speed_min:
		player_speed -= 10 * delta
		
	if Input.is_key_pressed(KEY_Q) and player_LandR_posision > limite_left:
		player_LandR_vitesse -= 5.0 * delta
	
	elif Input.is_key_pressed(KEY_D) and  player_LandR_posision < limite_right:
		player_LandR_vitesse += 5.0 * delta
	else:
		player_LandR_vitesse = lerp(player_LandR_vitesse, 0.0, 5.0 * delta)
	player_LandR_posision += player_LandR_vitesse * delta
	player_LandR_posision = clamp(player_LandR_posision, limite_left, limite_right)
	bottle.position.z = player_LandR_posision
	
	# Rotation de la bouteille en fonction de la vitesse latérale
	var rotation_angle = player_LandR_vitesse * 10.0  # Ajustez ce facteur pour une rotation plus prononcée
	bottle.rotation_degrees.x = lerp(bottle.rotation_degrees.x, rotation_angle, 5.0 * delta)
	
	print(rotation_angle)
	
