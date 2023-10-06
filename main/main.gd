extends Node

@export var play_time: int

var level
var score
var time_left
var screen_size
var playing = false
var player: Player
var apple_scene = preload("res://apples/apple.tscn")


func _ready():
	player = $Player
	randomize()
	screen_size = get_viewport().get_visible_rect().size
	
	player.screen_size = screen_size
	player.hide()
	new_game()
	
func new_game():
	playing = true
	level = 1
	score = 0
	time_left = play_time
	player.start($PlayerStart.position)
	player.show()
	$GameTimer.start()
	apple_spawn()
	
func apple_spawn():
	for i in 3 + level:
		var apple = apple_scene.instantiate()
		$AppleContainer.add_child(apple)
		apple.screen_size = Vector2(randf_range(0.0, screen_size.x), randf_range(0.0, screen_size.y))
		apple.position = Vector2(
			randf_range(0, screen_size.x),
			randf_range(0, screen_size.y)
		)

func _process(delta):
	if playing == true:
		if $AppleContainer.get_child_count() == 0:
			level += 1
			time_left += 6
			apple_spawn()
