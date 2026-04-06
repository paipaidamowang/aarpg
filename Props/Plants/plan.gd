class_name Plant extends Node2D



func _ready() -> void:
	$HitBox.Damaged.connect( TakeDamage )
	pass


func TakeDamage( _damage: int ) -> void:
	queue_free()
