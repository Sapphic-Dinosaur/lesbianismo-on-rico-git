extends Area3D
class_name Interaction_box

@export var display:Interaction_object

var puzzle_finished:bool = false

func confirm_action():
	display.interaction_confirmed()

func completed_action():
	monitorable = false
	monitoring = false
