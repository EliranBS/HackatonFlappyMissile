extends Node

enum GameState {IDLE, RUNNING, ENDED}

var game_state

@onready var pipe_spawner = $"../PipeSpawner" as PipeSpawner
@onready var bird = get_node("../Bird") as Bird
@onready var ground = $"../Ground" as Ground
@onready var game_manager = $"."
@onready var fade = $"../Fade" as Fade
@onready var ui = $"../UI" as UI
@onready var misslie = $"../Misslie" as Misslie

var points = 0
var misslie_timer = null
var current_level = 1

func _ready():
	game_state = GameState.IDLE    
	bird.game_started.connect(on_game_started)
	pipe_spawner.bird_crashed.connect(end_game)
	misslie.bird_crashed.connect(end_game)
	ground.bird_crashed.connect(end_game)
	pipe_spawner.point_scored.connect(point_scored)

func on_game_started():
	game_state = GameState.RUNNING
	pipe_spawner.start_spawning_pipes()
	misslie.start_misslie_spawning()
	
func end_game():
	if fade != null: 
		fade.play()
	bird.kill()
	pipe_spawner.stop()
	ground.stop()
	misslie.stop_misslie_spawning()
	ui.on_game_over()

func point_scored():
	points += 1
	ui.update_points(points)
	
	if points % 5 == 0:
		current_level += 1
		bird.gravity = bird.gravity * 1.3
		start_new_level(bird.gravity, current_level, points)


func start_new_level(new_gravity, new_level, points):
	bird.gravity = new_gravity
	points = points
	ui.update_points(points)
	ui.show_level_up_message(new_level)



#func start_misslie_spawning():
	#misslie_timer = Timer.new()
	#misslie_timer.wait_time = 2.0
	#misslie_timer.one_shot = false
	#misslie_timer.connect("timeout", Callable(self, "_spawn_misslie"))
	#add_child(misslie_timer)
	#misslie_timer.start()
#
#func stop_misslie_spawning():
	#if misslie_timer != null:
		#misslie_timer.stop()
		#remove_child(misslie_timer)
		#misslie_timer = null
		#
#func _spawn_misslie():
		#var misslie = misslie_scene.instantiate() as Misslie
		#var viewport_rect = get_viewport().get_camera_2d().get_viewport_rect()
		#var half_height = viewport_rect.size.y / 2
		#misslie.position.x = viewport_rect.end.x
		#misslie.position.y = randf_range(viewport_rect.size.y * 0.15 - half_height, viewport_rect.size.y * 0.65 - half_height)
		#add_child(misslie)


