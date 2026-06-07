extends Node

@export var player: Player
@export var respawn_point: Marker3D
@export var animation: AnimationPlayer

func _ready():
	animation.play("moving platform")

func _on_fallstopper_area_entered(area: Area3D) -> void:
	player.global_position = respawn_point.global_position
