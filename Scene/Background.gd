extends Node2D

var scroll_speed = 50.0  # Adjust speed as needed

func _process(delta):
	position.x += scroll_speed * delta  # Update offset based on delta time
