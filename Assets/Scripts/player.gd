extends Area2D
signal hit


@export var speed: int = 200
var screen_size


func _ready():
	screen_size = get_viewport_rect().size
	hide()


func _process(delta):
	var velocity: Vector2 = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		get_node("AnimatedSprite2D").play() # i prefer a more explicit notation
	else:
		get_node("AnimatedSprite2D").stop() # instead of '$'
	
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

	if velocity.x != 0:
		get_node("AnimatedSprite2D").animation = "walk"
		get_node("AnimatedSprite2D").flip_h = velocity.x < 0
	elif velocity.y != 0:
		get_node("AnimatedSprite2D").animation = "up"
		get_node("AnimatedSprite2D").flip_v = velocity.y > 0


func _on_body_entered(body):
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)


func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
