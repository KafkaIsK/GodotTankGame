extends Line2D


var point


func _ready() -> void:
	set_as_toplevel(true)


func _physics_process(delta: float) -> void:
	point = get_parent().global_position
	add_point(point)
	if points.size() > 40:
		remove_point(0)
