extends CharacterBody3D

# Exported variables
@export var walk_speed: float = 10.0
@export var sprint_speed: float = 18.0
@export var crouch_speed: float = 5.0
@export var acceleration: float = 5.0
@export var gravity: float = 9.8
@export var jump_power: float = 5.0
@export var mouse_sensitivity: float = 0.3
@export var crouch_height: float = 1.0
@export var standing_height: float = 2.0

# Onready variables
@onready var head: Node3D = $Head
@onready var camera: Camera3D = $Head/Camera3D
@onready var collision_shape: CollisionShape3D = $CollisionShape3D

# Regular variables
var camera_x_rotation: float = 0.0
var current_speed: float = walk_speed
var is_crouching: bool = false


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	standing_height = collision_shape.shape.height


func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		head.rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity))
		var x_delta = event.relative.y * mouse_sensitivity
		camera_x_rotation = clamp(camera_x_rotation + x_delta, -90.0, 90.0)
		camera.rotation_degrees.x = -camera_x_rotation


func _physics_process(delta):
	var movement_vector = Vector3.ZERO
	if Input.is_action_pressed("movement_forward"):
		movement_vector -= head.basis.z
	if Input.is_action_pressed("movement_backward"):
		movement_vector += head.basis.z
	if Input.is_action_pressed("movement_left"):
		movement_vector -= head.basis.x
	if Input.is_action_pressed("movement_right"):
		movement_vector += head.basis.x

	if Input.is_action_pressed("sprint") and not is_crouching:
		current_speed = sprint_speed
	else:
		current_speed = walk_speed

	handle_crouch()

	movement_vector = movement_vector.normalized()

	velocity.x = lerp(velocity.x, movement_vector.x * current_speed, acceleration * delta)
	velocity.z = lerp(velocity.z, movement_vector.z * current_speed, acceleration * delta)

	if not is_on_floor():
		velocity.y -= gravity * delta

	# Jumping (can't jump while crouching)
	if Input.is_action_just_pressed("jump") and is_on_floor() and not is_crouching:
		velocity.y = jump_power

	move_and_slide()


func handle_crouch():
	# Toggle crouch state
	if Input.is_action_just_pressed("crouch"):
		is_crouching = !is_crouching
	if is_crouching:
		# Lower the collision shape and camera
		collision_shape.shape.height = lerp(collision_shape.shape.height, crouch_height, 0.1)
		head.position.y = lerp(head.position.y, crouch_height / 2, 0.1)
		current_speed = crouch_speed
	else:
		# Return to standing height
		collision_shape.shape.height = lerp(collision_shape.shape.height, standing_height, 0.1)
		head.position.y = lerp(head.position.y, standing_height / 2, 0.1)
