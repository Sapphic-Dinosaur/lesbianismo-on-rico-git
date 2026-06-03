extends Area3D
class_name Interaction_box

@export var display:Interaction_object

func confirm_action():
	display.interaction_confirmed()
