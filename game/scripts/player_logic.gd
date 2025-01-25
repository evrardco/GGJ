extends Node
class_name PlayerLogic
signal ui_refresh
@export var n_boosts : int = 3
@export var boost_accel_y : float = 15
@export var accel_y : float = 0
@export var accel_y_decr : float = 2.0  
@export var gravity : float = 0.25
@export var boost_duration : float = 5.0
@export var boost_left : float = boost_duration
@export var min_vy : float = 10
	
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
	
func update_vy(delta : float):
	
	if boost_left >= 0:
		accel_y = boost_accel_y
		boost_left -= delta
	else:
		accel_y -= accel_y_decr * delta
		
	player_vy += delta * (accel_y - gravity)
	if player_vy < min_vy:
		player_vy = min_vy
# Appelé à chaque frame. 'delta' est le temps écoulé depuis la frame précédente.
func consume_boost():
	if n_boosts == 0:
		return
	else:
		boost_left += boost_duration
		n_boosts -= 1
	ui_refresh.emit()
	
func _process(delta: float) -> void:
	update_vy(delta)
	if Input.is_action_just_pressed("boost"):
		consume_boost()
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
	
