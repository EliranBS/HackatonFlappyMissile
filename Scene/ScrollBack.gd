extends Node2D

var scroll_speed = 10.0  # Adjust speed as needed
var background_sprite: Sprite2D = null  # Reference to the Sprite2D child

func _ready():
	background_sprite = get_node("ScrollBack/Gaza")  # Replace with actual path

func _process(delta):
	if background_sprite != null:
		# Update offset.x for scrolling the background
		background_sprite.offset.x += scroll_speed * delta

# Optional: Reset background position if it goes off-screen (endless scrolling)
func _on_background_sprite_reached_edge(position_x):
	if position_x < -background_sprite.texture.get_width():
		background_sprite.offset.x = get_viewport().size.x  # Reset to right side

# Connect a signal to the above function when needed
# background_sprite.connect("some_signal", self, "_on_background_sprite_reached_edge")
