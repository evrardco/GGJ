extends Node
class_name PlayerLogic
var rng = RandomNumberGenerator.new()

@export var player_speed : float = 10

# Appelé lorsque le nœud entre dans l'arbre de la scène pour la première fois.
func _ready() -> void:
	pass

# Appelé à chaque frame. 'delta' est le temps écoulé depuis la frame précédente.
func _process(delta: float) -> void:
	pass
