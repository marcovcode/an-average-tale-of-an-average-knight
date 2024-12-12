extends Area2D

@export var timeline = ""
@onready var player = %Player

var is_talking = false

func _ready() -> void:
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	Dialogic.signal_event.connect(_on_dialogic_signal)

func _process(delta):
	if player.get_node("RayCast2D").is_colliding() and Input.is_action_just_pressed("interact") and not is_talking:
		is_talking = true
		Dialogic.start(timeline)

func _on_dialogic_signal(argument):
	if argument == "dialogue_ended":
		is_talking = false

func _on_timeline_ended():
	is_talking = false