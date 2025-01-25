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
@export var player_vy : float = 10
@export var player_LandR : float = 0
var player_vy_max : float = 80
var player_speed_min : float = -10
var limite_left : float = -7
var limite_right : float = 7
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

	
	
