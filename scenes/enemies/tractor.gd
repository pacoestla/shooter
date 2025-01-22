extends PathFollow2D

var player_near:bool = false

func fire():
	Globals.health -= 20


@onready var line1:Line2D = $Turret/RayCast2D/Line2D
@onready var line2:Line2D = $Turret/RayCast2D2/Line2D
func _ready():
	$Turret/RayCast2D/Line2D.width = 0
	$Turret/RayCast2D2/Line2D.width = 0
	$Turret/fire1.visible = false
	$Turret/fire2.visible = false
	line2.add_point($Turret/RayCast2D2.target_position)

func _process(delta):
	progress_ratio += 0.02 * delta
	if player_near:
		$Turret.look_at(Globals.player_pos)


func _on_notice_area_body_entered(_body: Node2D) -> void:
	player_near = true
	$AnimationPlayer.play("bullet_load")

func _on_notice_area_body_exited(_body: Node2D) -> void:
	player_near = false
	$AnimationPlayer.stop()
