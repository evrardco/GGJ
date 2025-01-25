extends Sprite3D
#todo c'est moche faut changer
@onready var playerLogic : PlayerLogic = self.get_parent().get_parent().get_parent().get_child(0) as PlayerLogic

var rng = RandomNumberGenerator.new()
var textures = ["res://assets/images/nuage01.png","res://assets/images/nuage02.png","res://assets/images/nuage03.png"]
# Appelé lorsque le nœud entre dans l'arbre de la scène pour la première fois.
func _ready() -> void:
	print("PlayerLogic initialisé : ", playerLogic)
	
# Appelé à chaque frame. 'delta' est le temps écoulé depuis la frame précédente.
func _process(delta: float) -> void:
	if playerLogic != null:
		self.position.y -= playerLogic.player_speed * delta
	#else:
		#print("Erreur : playerLogic n'est pas initialisé")
