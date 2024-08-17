extends Polygon2D

@onready var hitbox: CollisionPolygon2D = $Area2D/CollisionPolygon2D
@onready var tile: Polygon2D = $"."
@onready var area2d: Area2D = $Area2D


var dragging = false
var click_radius = 150 # Size of the sprite.
var clicked_on = false
var hovering = false
var tile_offset


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
				tile_offset = tile.position - event.position
			# Stop dragging if the button is released.
			if dragging and not event.pressed:
				dragging = false

	if event is InputEventMouseMotion and dragging:
		# While dragging, move the tile with the mouse.
		tile.position = event.position + tile_offset

func _on_area_2d_mouse_entered() -> void:
	hovering = true
