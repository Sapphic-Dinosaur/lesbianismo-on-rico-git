extends CharacterBody3D
class_name Player

@onready var yaw: Marker3D = $Yaw
@onready var pitch: Marker3D = $Yaw/Pitch

@export_category("Objects")
@export var interact_text: Label
@export var interact_cooldown: Timer
@export_category("Variables")
@export var cam_sense: float = 1.0

var possible_interaction: Interaction_box = null
var player_interacting: bool
var _should_interact: bool = true #Manages a cooldown so you can't interact twice in the same frame

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	player_interacting = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y = clamp(velocity.y + get_gravity().y * delta, -100, 100)
	# Handle jump.
	if Input.is_action_just_pressed("play_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	#Movement. Player can only move if they're not in the midle of an interaction.
	if !player_interacting: _movement()
	#Interactions
	_interaction()
	#THE MIGHTY ONE
	move_and_slide()

func _movement():
	var dir_input: Vector2 = Input.get_vector("play_left", "play_right", "play_forward", "play_back")
	var direction: Vector3 = (yaw.transform.basis * Vector3(dir_input.x, 0, dir_input.y))
	direction.x = abs(direction.x) * direction.x
	direction.z = abs(direction.z) * direction.z
	if direction: velocity = Vector3(direction.x * SPEED, velocity.y, direction.z * SPEED)
	else: velocity = Vector3(0, velocity.y, 0)

func _interaction(): #This handles interactions
	if Input.is_action_just_pressed("play_interact") and possible_interaction and !player_interacting and _should_interact:
		possible_interaction.display.visible = true
		player_interacting = true
		interact_text.visible = false
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	elif Input.is_action_just_pressed("play_confirm") and player_interacting:
		possible_interaction.display.interaction_confirmed()
		exit_interaction()

func exit_interaction():
	_should_interact = false
	interact_cooldown.start()
	possible_interaction.display.visible = false
	player_interacting = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if (!possible_interaction.puzzle_finished): interact_text.visible = true
	else: possible_interaction.completed_action()

func _unhandled_input(event: InputEvent):
	if event is InputEventMouseMotion:
		pitch.rotate_x(-event.relative.y * cam_sense * 0.001)
		yaw.rotate_y(-event.relative.x * cam_sense * 0.001)
		pitch.rotation.x = clamp(pitch.rotation.x, deg_to_rad(-90), deg_to_rad(90))

func _capture_mouse(pause: bool):
	if !pause: Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	else: Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_interaction_box_area_entered(area: Interaction_box) -> void:
	interact_text.visible = true
	possible_interaction = area

func _on_interaction_box_area_exited(area: Interaction_box) -> void:
	interact_text.visible = false
	possible_interaction = null

func _on_interact_cooldown_timeout() -> void:
	_should_interact = true
