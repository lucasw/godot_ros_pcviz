extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var mouse_wheel = -5.0
var old_mouse_pos = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_WHEEL_UP:
			mouse_wheel *= 0.95
		if event.button_index == BUTTON_WHEEL_DOWN:
			mouse_wheel *= 1.05

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var pos = get_viewport().get_mouse_position()
	$label.set_text(str(mouse_wheel))
	#print(mouse_wheel)
	$angle/offset.transform.origin = Vector3(0, 0, -mouse_wheel)

	if (Input.is_action_just_pressed('shift') or Input.is_action_just_released('shift')):
		old_mouse_pos = null

	var dpos = Vector3()
	if Input.is_action_pressed("mouse_middle"):
		if old_mouse_pos != null:
			dpos = pos - old_mouse_pos
		old_mouse_pos = pos
	if Input.is_action_just_released("mouse_middle"):
		old_mouse_pos = null

	if Input.is_action_pressed('shift'):
		# TODO(lucasw) need to get camera left/right up/down axes and shift along those,
		# this shifts only along the ground plane
		translate_object_local(Vector3(-dpos.x, 0.0, -dpos.y) * 0.001)
	else:
		rotate_object_local(Vector3.UP, -dpos.x * 0.008)
		$angle.rotate_object_local(Vector3.RIGHT, dpos.y * 0.006)
