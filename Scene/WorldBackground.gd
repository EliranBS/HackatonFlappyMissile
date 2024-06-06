
extends Node2D

var backgroundSpeed = 100
@onready var sprite1 = $Background
@onready var sprite2 = $Background2

# Called when the node enters the scene tree for the first time.
func _ready():
	#sprite2.global_position.x = sprite1.global_position.x + sprite1.texture.get_width()
	sprite2.visible = true
func _process(delta):
	sprite1.global_position.x -= backgroundSpeed * delta
	sprite2.global_position.x -= backgroundSpeed * delta
	
	# If Sprite1 has completely left the screen, move it to the right of Sprite2
	if sprite1.global_position.x < -sprite1.texture.get_width():
		sprite1.global_position.x = sprite2.global_position.x + sprite1.texture.get_width()
		sprite2.visible = true
		#sprite1.visible = false



	# If Sprite2 has completely left the screen, move it to the right of Sprite1
	if sprite2.global_position.x < -sprite2.texture.get_width():
		sprite2.global_position.x = sprite1.global_position.x + sprite2.texture.get_width()
		sprite1.visible = true
		#sprite2.visible = false
