extends Control
@onready var n_boosts_txt : Label = %"NBoosts"
@onready var altimetre_txt : Label = %"Altimetre"

@onready var player_logic : PlayerLogic = %"PlayerLogic"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_player_logic_ui_refresh() -> void:
	n_boosts_txt.text = str(player_logic.n_boosts)


func _on_refresh_altimetre_timeout() -> void:
	altimetre_txt.text = str(int(player_logic.altitude))


func _on_player_logic_ui_game_over() -> void:
	(%"HUD" as Control).visible = false
	(%"Score" as Label).text = str(int(player_logic.altitude))
	(%"GameOverOverlay" as Control).visible = true
