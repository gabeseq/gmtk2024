extends ShapeCast2D

@onready var mouse_cursor: ShapeCast2D = $"."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	mouse_cursor.position = get_viewport().get_mouse_position()
	pass
