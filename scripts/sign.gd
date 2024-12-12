extends StaticBody2D

@export var timeline = ""
@onready var player = %Player

var is_talking = false

func _ready() -> void:
    Dialogic.timeline_ended.connect(_on_timeline_ended)

func _process(delta):
    var raycast = player.get_node("RayCast2D")
    
    if raycast.is_colliding():
        var collided_object = raycast.get_collider()
        if collided_object == self and Input.is_action_just_pressed("interact") and not is_talking:
            is_talking = true
            Dialogic.start(timeline)

func _on_timeline_ended():
    is_talking = false
