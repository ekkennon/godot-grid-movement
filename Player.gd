extends KinematicBody2D


var speed = 64
var velocity = Vector2.ZERO


func _process(delta):
	var direction = Vector2.ZERO
	
	if Input.is_action_just_released("ui_right"):
		velocity += Vector2.RIGHT * speed
		direction.x += 1
	if Input.is_action_just_released("ui_left"):
		velocity += Vector2.LEFT * speed
		direction.x -= 1
	if Input.is_action_just_released("ui_down"):
		velocity += Vector2.DOWN * speed
		direction.y += 1
	if Input.is_action_just_released("ui_up"):
		velocity += Vector2.UP * speed
		direction.y -= 1
	
	print(direction)
	
	position = velocity
