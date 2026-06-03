extends Node

@export var player: Player
@export var respawn_point: Marker3D

func _on_fallstopper_area_entered(area: Area3D) -> void:
	player.global_position = respawn_point.global_position
