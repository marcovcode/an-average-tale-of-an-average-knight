extends Node2D

func _ready() -> void:
    Dialogic.signal_event.connect(_on_dialogic_signal)
    Dialogic.start("intro")

func _on_dialogic_signal(argument: String) -> void:
    match argument:
        "disable_user_input":
            Dialogic.Inputs.block_input(9999)
        "go_to_town":
            Transition.transition()
            await Transition.on_transition_finished
            get_tree().change_scene_to_file("res://scenes/town.tscn")