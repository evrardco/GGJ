extends Node
class_name PlayerLogic
var rng = RandomNumberGenerator.new()

@export var player_speed : float = 10
@export var player_LandR : float = 0
var player_speed_max : float = 20
var player_speed_min : float = -10
var limite_left : float = -7
var limite_right : float = 7
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
		
	if Input.is_key_pressed(KEY_Q) and player_LandR > limite_left:
		bottle.position.z += -1 * delta
		player_LandR -= 5 * delta
	
	if Input.is_key_pressed(KEY_D) and  player_LandR < limite_right:
		bottle.position.z += 1* delta
		player_LandR += 5 * delta
	
	
