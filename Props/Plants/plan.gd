class_name Plant extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HitBox.Damage.connect( TakeDamege )
	pass # Replace with function body.


func TakeDamege( _damege: int ) -> void:
	queue_free()
	
