extends Control
@onready var n_boosts_txt : Label = %"NBoosts"
@onready var player_logic : PlayerLogic = %"PlayerLogic"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_player_logic_ui_refresh() -> void:
	n_boosts_txt.text = str(player_logic.n_boosts)
