class_name HitBox extends Area2D

signal Damaged( dagage : int)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


#承受害
func TakeDamage( dagage: int) -> void:
	print("TakeDamage" , dagage)
	Damage.emit( dagage )
