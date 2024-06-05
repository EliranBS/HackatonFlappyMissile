extends Node

enum GameState {IDLE, RUNNING, ENDED}

var game_state

@onready var pipe_spawner = $"../PipeSpawner" as PipeSpawner
@onready var bird = get_node("../Bird") as Bird
@onready var ground = $"../Ground" as Ground
@onready var game_manager = $"."
@onready var fade = $"../Fade" as Fade
@onready var ui = $"../UI" as UI

var points = 0
var current_level = 1

func _ready():
	game_state = GameState.IDLE    
	bird.game_started.connect(on_game_started)
	pipe_spawner.bird_crashed.connect(end_game)
	ground.bird_crashed.connect(end_game)
	pipe_spawner.point_scored.connect(point_scored)

func on_game_started():
	game_state = GameState.RUNNING
	pipe_spawner.start_spawning_pipes()
	
func end_game():
	if fade != null: 
		fade.play()
	bird.kill()
	pipe_spawner.stop()
	ground.stop()
	ui.on_game_over()

func point_scored():
	points += 1
	ui.update_points(points)
	$points_sound.play()
	
	if points % 5 == 0:
		current_level += 1
		bird.gravity = bird.gravity * 1.3
		start_new_level(1000, current_level, points)

func start_new_level(new_gravity, new_level, points):
	bird.gravity = new_gravity
	points = points
	ui.update_points(points)
	ui.show_level_up_message(new_level)
	#reset_game_state()
#
#func reset_game_state():
	##get_tree().reload_current_scene()  # Reloads the current scene to reset the game state
	#get_tree()
	#game_state = GameState.IDLE
