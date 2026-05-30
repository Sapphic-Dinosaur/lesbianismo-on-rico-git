extends CharacterBody3D

@onready var yaw: Marker3D = $Yaw
@onready var pitch: Marker3D = $Yaw/Pitch

@export var cam_sense: float = 1.0

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	move_and_slide()

func _unhandled_input(event: InputEvent):
	if event is InputEventMouseMotion:
		pitch.rotate_x(-event.relative.y * cam_sense)
		yaw.rotate_y(-event.relative.x * cam_sense)
		pitch.rotation.x = clamp(pitch.rotation.x, deg_to_rad(-90), deg_to_rad(90))
