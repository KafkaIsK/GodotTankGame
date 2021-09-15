extends Area2D


enum Items {health, ammo}


var icon_textures = [preload("res://assets/effects/wrench_white.png"), preload("res://assets/effects/ammo_machinegun.png")]


export (Items) var type = Items.health
export (Vector2) var amount = Vector2(10, 25)


func _ready() -> void:
	$Icon.texture = icon_textures[type]


func _on_Pickup_body_entered(body: Node) -> void:
	match type:
		Items.health:
			if body.has_method('heal'):
				body.heal(int(rand_range(amount.x, amount.y)))
		Items.ammo:
			body.ammo += int(rand_range(amount.x, amount.y))
	queue_free()
