extends Polygon2D

@onready var hitbox: CollisionPolygon2D = $Area2D/CollisionPolygon2D
@onready var tile: Polygon2D = $"."

var dragging = false
var hovering = false
var tile_offset = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hitbox.polygon = tile.polygon

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:	
		if (hovering):
			# Start dragging if the click is inside the polygon.
			if not dragging and event.pressed:
				dragging = true
				tile_offset = tile.global_position - event.global_position
			# Stop dragging if the button is released.
			if dragging and not event.pressed:
				dragging = false

	if event is InputEventMouseMotion and dragging:
		# While dragging, move the tile with the mouse.
		tile.global_position = event.global_position + tile_offset

func _on_area_2d_mouse_entered() -> void:
	hovering = true


func _on_area_2d_mouse_exited() -> void:
	hovering = false # Replace with function body.
