extends Polygon2D

@onready var hitbox: CollisionPolygon2D = $Area2D/CollisionPolygon2D
@onready var tile: Polygon2D = $"."

const DEFAULT_SCALE = Vector2(1,1)
const MIN_SCALE = 0.5
const MAX_SCALE = 1.75

var dragging = false
var hovering = false
var tile_offset = 0
var scale_factor = 1.0

var update_scale = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hitbox.polygon = tile.polygon
	tile.scale = DEFAULT_SCALE

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event):
	if hovering and Input.is_action_pressed("ScrollUp"):
		if scale_factor == MAX_SCALE:
			pass
		get_bigger()
		tile.scale = DEFAULT_SCALE * scale_factor
		tile.global_position = event.global_position
	if hovering and Input.is_action_pressed("ScrollDown"):
		if scale_factor == MIN_SCALE:
			pass
		get_smaller()
		tile.scale = DEFAULT_SCALE * scale_factor
		tile.global_position = event.global_position
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:	
		if (hovering):
			# Start dragging if the click is inside the polygon.
			if not dragging and event.pressed:
				dragging = true
				tile_offset = tile.global_position - event.global_position
			# Stop dragging if the button is released.
			if dragging and not event.pressed:
				dragging = false
		else:
			dragging = false

	if event is InputEventMouseMotion and dragging:
		# While dragging, move the tile with the mouse.
		tile.global_position = event.global_position + tile_offset

func _on_area_2d_mouse_entered() -> void:
	hovering = true

func _on_area_2d_mouse_exited() -> void:
	hovering = false # Replace with function body.

func get_smaller() -> void:
	scale_factor -= 0.05
	if scale_factor < MIN_SCALE:
		scale_factor = MIN_SCALE
	
func get_bigger() -> void:
	scale_factor += 0.05
	if scale_factor > MAX_SCALE:
		scale_factor = MAX_SCALE
