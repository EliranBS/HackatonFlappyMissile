extends CanvasLayer

class_name UI

@onready var points_label = $MarginContainer/PointsLabel
@onready var game_over_box = $MarginContainer/GameOverBox
@onready var level_up_label = $MarginContainer/LevelUpLabel

func _ready():
	$AudioStreamPlayer2D.play()
	points_label.text = "%d" % 0
	level_up_label.text = "Level "+"%d" % 1
	
func update_points(points: int):
		points_label.text = "%d" % points

func on_game_over():
	game_over_box.visible = true


func _on_restart_button_pressed():
	get_tree().reload_current_scene()
	
func show_level_up_message(level: int):
	level_up_label.text = "Level "+"%d" % level
	level_up_label.show()
