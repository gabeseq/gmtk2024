extends Polygon2D

@onready var hitbox: CollisionPolygon2D = $Area2D/CollisionPolygon2D
@onready var tile: Polygon2D = $"."


var dragging = false
var click_radius = 150 # Size of the sprite.


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hitbox.polygon = tile.polygon
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if (event.position - tile.position).length() < click_radius:
			# Start dragging if the click is on the sprite.
			if not dragging and event.pressed:
				dragging = true
			# Stop dragging if the button is released.
			if dragging and not event.pressed:
				dragging = false

	if event is InputEventMouseMotion and dragging:
		# While dragging, move the sprite with the mouse.
		tile.position = event.position
