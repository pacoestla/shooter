extends CanvasLayer

#Colors
var green: Color = Color("3dcc13")
var red: Color = Color("ad2813")


@onready var health_bar: TextureProgressBar = $"MarginContainer/Health Bar"
@onready var egg_label: Label = $"Egg Counter/VBoxContainer/Label"
@onready var grenade_label: Label = $"Grenade Counter/VBoxContainer/Grenade Left"
@onready var egg_icon: TextureRect = $"Egg Counter/VBoxContainer/TextureRect"
@onready var grenade_icon: TextureRect= $"Grenade Counter/VBoxContainer/TextureRect"
func _ready():
	Globals.connect("stat_change", update_stat_text)
	update_egg_text()
	update_grenade_text()
	update_health_text()
func update_egg_text():
	egg_label.text = str(Globals.egg_ammount)
	update_color(Globals.egg_ammount, egg_label, egg_icon)
func update_grenade_text():
	grenade_label.text = str(Globals.grenade_ammount)
	update_color(Globals.grenade_ammount, grenade_label, grenade_icon)


func update_stat_text():
	update_egg_text()
	update_grenade_text()
	update_health_text()

func update_health_text():
	health_bar.value = Globals.health

func update_color(ammount: int, label: Label, icon: TextureRect) -> void:
	if ammount <= 0:
		label.modulate = red
		icon.modulate = red
	else:
		label.modulate = green
		icon.modulate = green
