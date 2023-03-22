extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	text = "0"
	Data.carrot_counter = self
	
func set_num(num):
	text = str(num)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
