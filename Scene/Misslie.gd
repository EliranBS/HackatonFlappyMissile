extends Node2D

class_name Misslies

signal bird_entered

var speed = 200
var misslie_lifetime = 5.0

func _ready():
	await get_tree().create_timer(misslie_lifetime).timeout
	queue_free()
	
func _process(delta):
	position.x -= speed * delta
	#print(position.x)
	if position.x < -150:
		queue_free()

#func _on_body_entered(body):
	#bird_entered.emit()


func _on_area_2d_body_entered(body):
	bird_entered.emit()
	print("entered!!!")
