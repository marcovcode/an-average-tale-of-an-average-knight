extends Node2D

func _ready() -> void:
    Dialogic.signal_event.connect(_on_dialogic_signal)
    Dialogic.start("intro")

func _on_dialogic_signal(argument: String) -> void:
    if argument == "disable_user_input":
        Dialogic.Inputs.block_input(9999)