extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("bounce")
	Data.clear_car.connect(on_clear )


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for a in get_overlapping_bodies():
		if a.is_in_group("player"):
			a.carrot(self)
			
func on_gathered():
	queue_free()
	
func on_clear():
	queue_free()
	
	
