extends CharacterBody3D
class_name Player

@onready var yaw: Marker3D = $Yaw
@onready var pitch: Marker3D = $Yaw/Pitch

@export var interactText: Label
@export var cam_sense: float = 1.0

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	# Handle jump.
	if Input.is_action_just_pressed("play_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	_movement()
	move_and_slide()

func _movement():
	var dir_input: Vector2 = Input.get_vector("play_left", "play_right", "play_forward", "play_back")
	var direction: Vector3 = (yaw.transform.basis * Vector3(dir_input.x, 0, dir_input.y))
	direction.x = abs(direction.x) * direction.x
	direction.z = abs(direction.z) * direction.z
	if direction: velocity = Vector3(direction.x * SPEED, velocity.y, direction.z * SPEED)
	else: velocity = Vector3(0, velocity.y, 0)

func _unhandled_input(event: InputEvent):
	if event is InputEventMouseMotion:
		pitch.rotate_x(-event.relative.y * cam_sense * 0.001)
		yaw.rotate_y(-event.relative.x * cam_sense * 0.001)
		pitch.rotation.x = clamp(pitch.rotation.x, deg_to_rad(-90), deg_to_rad(90))

func _capture_mouse(pause: bool):
	if !pause: Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	else: Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func _on_interaction_box_area_entered(area: Area3D) -> void:
	print("Now you can interact")
	interactText.visible = true


func _on_interaction_box_area_exited(area: Area3D) -> void:
	print("Now you can NOT interact")
	interactText.visible = false
