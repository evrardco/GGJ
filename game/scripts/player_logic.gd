extends Node
class_name PlayerLogic
signal ui_refresh
signal ui_game_over
@export var n_boosts : int = 3
@export var boost_accel_y : float = 10  
@export var accel_y : float = 0
@export var accel_y_decr : float = 2.0  
@export var gravity : float = 0.25
@export var boost_duration : float = 2.0
@export var boost_left : float = 0.5#boost_duration
@export var min_vy : float = -50
@export var max_vy : float = 30
@export var altitude : float = 100
@export var bottle_speed : float = 0
@export var obstacle_penalty : float = 10
@export var player_max_vz : float = 50
var game_over_timer : float = 0
@export var game_over_max_time : float = 2.0
var rng = RandomNumberGenerator.new()

@export var player_speed : float = 10
var player_vz : float = 0
@export var player_z : float = 0
var player_vy : float = 0
var player_speed_max : float = 20
var player_speed_min : float = -10
var limite_left : float = -1.7
var limite_right : float = 1.7
var target_angle : float = -90
var target_vz : float = 0.0
var prev_target_angle : float = 0.0
var prev_target_vz : float = 0.0
@onready var bottle : Node3D = %"Bottle"
# Appelé lorsque le nœud entre dans l'arbre de la scène pour la première fois.
func _ready() -> void:
	pass
	
func game_over() -> void:
	self.bottle_speed = player_vy
	self.player_vy = 0
	self.accel_y = 0
	self.gravity = 0
	self.boost_left = 0
	self.n_boosts = 0
	self.accel_y_decr = 0
	ui_game_over.emit()
	
func update_vy(delta : float):
	
	if boost_left > 0:
		accel_y = boost_accel_y
		boost_left -= delta
	else:
		accel_y -= accel_y_decr * delta
	player_vy += delta * (accel_y - gravity)
	if player_vy < min_vy:
		player_vy = min_vy
	if player_vy > max_vy:
		player_vy = max_vy
# Appelé à chaque frame. 'delta' est le temps écoulé depuis la frame précédente.
func consume_boost():
	if n_boosts == 0:
		return
	else:
		boost_left += boost_duration
		n_boosts -= 1
	ui_refresh.emit()
func add_boost():
	n_boosts += 1
	ui_refresh.emit()
	
func handle_kb(delta: float):
	if Input.is_action_just_pressed("boost"):
		consume_boost()
		
	if Input.is_action_pressed("Left") and player_z > limite_left:
		player_vz -= 5.0 * delta
		if target_angle != 135:
			prev_target_angle = target_angle
		target_angle = 135
		if target_vz != -player_max_vz:
			prev_target_vz = target_vz
		target_vz = -player_max_vz


	elif Input.is_action_pressed("Right") and  player_z < limite_right:
		if target_angle != -135:
			prev_target_angle = target_angle
		target_angle = -135
		if target_vz != player_max_vz:
			prev_target_vz = target_vz
		target_vz = player_max_vz
		player_vz += 5.0 * delta

	else:
		if target_angle != 180:
			prev_target_angle = target_angle
		target_angle = 180
		if target_vz != 0:
			prev_target_vz = target_vz
		target_vz = 0 
		player_vz = lerp(player_vz, 0.0, 5.0 * delta)

	player_vz = clamp(player_vz, -player_max_vz, player_max_vz)
	var progress = abs(target_vz - player_vz) / (abs(target_vz - prev_target_vz) + 0.1)
	print("num", abs(target_vz - player_vz))
	print("dem", abs(target_vz - prev_target_vz))
	print("progress:",progress)

	player_z += player_vz * delta
	player_z = clamp(player_z, limite_left, limite_right)
	bottle.position.z = player_z
	
	# Rotation de la bouteille en fonction de la vitesse latérale
	#var rotation_angle = player_vz * 10.0  # Ajustez ce facteur pour une rotation plus prononcée
	#ddddbottle.rotation_degrees.x = - 1 * (PI / 4) + lerp(bottle.rotation_degrees.x, rotation_angle, 1.0 * delta)

func check_game_over(delta: float):
	if player_vy <= min_vy:
		game_over_timer += delta
		if game_over_timer >= game_over_max_time:
			game_over()
	else:
		game_over_timer = 0
		
func _process(delta: float) -> void:
	update_vy(delta)
	handle_kb(delta)
	self.altitude += delta * player_vy
	self.bottle.position.y += delta * bottle_speed
	check_game_over(delta)

func obstacle_collide(area : Area3D):
	self.player_vy -= obstacle_penalty
	area.get_parent().get_parent().queue_free()
	

func _on_bottle_hit_box_area_entered(area: Area3D) -> void:
	if area.name != "BoostHitBox" :
		obstacle_collide(area)
