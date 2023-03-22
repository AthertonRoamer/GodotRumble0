extends Node2D

var safe_image = preload("res://filler_art/filler_safe_tile.png")
var hole_image = preload("res://filler_art/filler_hole_tile.png")

@onready var animatedSprite

var timer_end

@onready var timer

var texture
var sprite 

var state = Data.SAFE
var map_pos : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite = get_node("Sprite2D")
	sprite.texture = texture

func timer_wait():
	
	pass

#func animation_transiton():
#	var last_state = state
#	match last_state:
#		Data.SAFE:
#			animatedSprite.play("Green_Safe_Flashing")
#
#		Data.DANGER:
#			animatedSprite.play("Red_Danger_Flashing")
#		_:
#			pass

func new_tile(new_state):
	state = new_state
	match state:
		Data.SAFE:
			animatedSprite.play("Green_Safe_Static")
		Data.DANGER:
			animatedSprite.play("Red_Danger_Static")
		_:
			pass
	

func set_state(new_state):
	#timer = $Timer
	animatedSprite = $AnimatedSprite2D
	#timer.start(3.25)

#	while timer_end != #1:

#	while timer_end != 1:

#		animation_transiton()
	new_tile(new_state)


func random_state():
	randomize()
	set_state(randi() % Data.state_count)
	

func start_effect():
	if state == 1:
		Data.player.die("You have tragically perished")
		Data.kill()
	
func end_effect():
	pass
	
func end_effect_of_state(s):
	pass


func _on_timer_timeout():
	timer_end = 1
