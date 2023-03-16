extends Sprite2D

@export var snap_size_x = 8
@export var snap_size_y = 8

var mouse_pos = Vector2.ZERO

func _physics_process(delta):
	update_position_snaped()
	
func update_position_snaped():
	mouse_pos = Vector2(int(get_global_mouse_position().x / snap_size_x),
						int(get_global_mouse_position().y / snap_size_y))
	global_position = mouse_pos * snap_size_x
