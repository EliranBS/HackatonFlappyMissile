extends Sprite2D

# Speed of the missile
var speed = 200

func _ready():
	# Ensure there is a CollisionShape2D node
	if $"../CollisionShape2D":
		$"../CollisionShape2D".connect("body_entered", Callable(self, "_on_body_entered"))
		print("Missile ready")
	else:
		print("CollisionShape2D not found")

func _process(delta):
	var viewport_rect = get_viewport().get_camera_2d().get_viewport_rect()
	var half_height = viewport_rect.size.y / 2
	position.x = viewport_rect.end.x
	position.y = randf_range(viewport_rect.size.y * 0.15 - half_height, viewport_rect.size.y * 0.65 - half_height)
	# Move the missile to the left
	#position.x -= speed * delta
	
	# If the missile is off screen, queue free it
	if position.x < -texture.get_size().x:
		queue_free()



# Function called when the missile collides with another body
# Function called when the missile collides with another body
func _on_body_entered(body):
	if body.name == "Bird":
		# Emit signal or handle the game over logic here
		get_tree().paused = true
		print("Game Over!")
