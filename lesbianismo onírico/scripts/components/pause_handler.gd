extends Node

@export var player: Player

func _process(delta: float):
	if Input.is_action_just_pressed("play_pause") and !player.player_interacting: _pause()

func _pause():
	if !get_tree().paused:
		get_tree().paused = true
		player._capture_mouse(true)
	else:
		get_tree().paused = false
		player._capture_mouse(false)
