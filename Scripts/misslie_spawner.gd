extends Node

class_name Misslie

var misslie_scene = preload("res://Scene/Misslie.tscn")

signal bird_crashed

@export var misslie_timer = Timer.new()

func start_misslie_spawning():
	misslie_timer.wait_time = 2.0
	misslie_timer.one_shot = false
	misslie_timer.connect("timeout", Callable(self, "_spawn_misslie"))
	add_child(misslie_timer)
	misslie_timer.start()

func stop_misslie_spawning():
	if misslie_timer != null:
		misslie_timer.stop()
		remove_child(misslie_timer)
		misslie_timer = null
		
#func stop():
	#misslie_timer.stop()
	#for pipe in get_children().filter(func (child): return child is PipePair):
		#(pipe as PipePair).speed = 0
		
func _spawn_misslie():
		var misslie = misslie_scene.instantiate() as Misslies
		add_child(misslie)
		
		var viewport_rect = get_viewport().get_camera_2d().get_viewport_rect()
		var half_height = viewport_rect.size.y / 2
		misslie.position.x = viewport_rect.end.x
		misslie.position.y = randf_range(viewport_rect.size.y * 0.15 - half_height, viewport_rect.size.y * 0.65 - half_height)
		
		#misslie.bird_entered.connect(on_area_2d_body_entered)

func _body_entered(body):
	bird_crashed.emit()
	(body as Bird).stop()
	

