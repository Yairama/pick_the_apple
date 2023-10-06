class_name Player
extends Area2D

signal pickup
signal hurt

@export var speed : int
var velocity = Vector2()
var screen_size = Vector2(440, 704)

func _ready():
	pass
	
func _process(delta):
	get_input()
	position += velocity * delta
	
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	$AnimatedSprite2D.play()
	if velocity.length()>0:
		$AnimatedSprite2D.animation = "run"
		$AnimatedSprite2D.flip_h = velocity.x > 0
	else :
		$AnimatedSprite2D.animation = "idle"
	

func get_input():
	velocity = Vector2()
	
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1.0
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1.0
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1.0
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1.0
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed

func start(pos: Vector2):
	set_process(true)
	position = pos
	$AnimatedSprite2D.animation = "idle"
	
func die():
	$AnimatedSprite2D.animation = "hurt"
	set_process(false)
	




func _on_area_entered(area: Area2D):
	if area.is_in_group("apples"):
		area.pickup()
	
	if area.is_in_group("enemy"):
		emit_signal("hurt")
		die()
