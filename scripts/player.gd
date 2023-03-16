extends CharacterBody2D

const GRAVITY = 200.0

var walk_speed = 200.0
@onready var sprite = $Sprite2D

func _physics_process(delta):
	velocity.y += GRAVITY * delta
	velocity.x = get_input() * walk_speed

	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y -= GRAVITY
	# "move_and_slide" already takes delta time into account.
	move_and_slide()
	
	
func get_input() -> float:
	var horizontal := 0.0
	
	if Input.is_action_pressed("ui_left"):
		#animations.play("walk")
		sprite.flip_h = true
		horizontal -= 1.0
	
	elif Input.is_action_pressed("ui_right"):
		#animations.play("walk")
		sprite.flip_h = false
		horizontal += 1.0
	else:
		pass
		#animations.play("idle")
	
	return horizontal
