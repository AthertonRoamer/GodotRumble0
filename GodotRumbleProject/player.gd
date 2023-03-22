extends RigidBody2D

@onready var animationPlayer = $AnimationPlayer
@onready var animationTree = $AnimationTree
@onready var animationState = animationTree.get("parameters/playback")

var speed = 100
var current_tile
var on_map = false
var old_state = -1
var carrots = 0

var start_pos : Vector2

func _ready():
	animationTree.active = true
	Data.player = self
	start_pos = position
# Called every frame. 'delta' is the elapsed time since the previous frame.
var i = 0





func _process(delta):
	if on_map == true:
		close_door()
	i += 1
	var new_tile = Data.map.get_tile(position)
	on_map = true
	if new_tile == null:
		#print("off map " + str(i))
		on_map = false
		old_state = -1
	elif new_tile != current_tile:
		old_state = new_tile.state
		new_tile.start_effect()
		if current_tile != null:
			current_tile.end_effect()
		current_tile = new_tile
	elif current_tile.state != old_state:
		current_tile.end_effect_of_state(old_state)
		current_tile.start_effect()
		old_state = current_tile.state
	
	var input_vector = Vector2.ZERO
	input_vector.x = (Input.get_action_strength("d") - Input.get_action_strength("a"))
	input_vector.y = (Input.get_action_strength("s") - Input.get_action_strength("w"))
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", input_vector)
		#animationTree.set("parameters/Run/blend_position", input_vector)
		animationState.travel("Idle")

func _integrate_forces(s):
	var lv = Vector2.ZERO
	
	var right = Input.is_action_pressed("d")
	var left = Input.is_action_pressed("a")
	var up = Input.is_action_pressed("w")
	var down = Input.is_action_pressed("s")
	
	if right:
		lv.x += 1
	if left:
		lv.x -= 1
	if up:
		lv.y -= 1 
	if down:
		lv.y += 1
		
	lv = lv.normalized()
	lv *= speed
	
	if Data.active == false:
		lv = Vector2.ZERO
	s.set_linear_velocity(lv)
	
func carrot(car):
	car.on_gathered()
	carrots += 1
	Data.carrot_counter.set_num(carrots)
	print("carrot!")
	Data.advance_phase()
	
	
func die(message):
	print("dead")
	Data.label.text = message
	$ClearTimer.wait_time = 3 
	$ClearTimer.start()
	
func close_door():
	Data.door.process_mode = Node.PROCESS_MODE_ALWAYS
	
func open_door():
	Data.door.process_mode = Node.PROCESS_MODE_DISABLED


func _on_clear_timer_timeout():
	Data.label.text = ""
