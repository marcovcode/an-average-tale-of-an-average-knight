extends Node2D

func _ready() -> void:
    Dialogic.timeline_started.connect(_on_timeline_started)
    Dialogic.timeline_ended.connect(_on_timeline_ended)

    Dialogic.start("intro")

func _on_timeline_started():
    Dialogic.Inputs.set_block_signals(true)

func _on_timeline_ended():
    Dialogic.Inputs.set_block_signals(false)

    # go to town
    Transition.transition()
    await Transition.on_transition_finished
    get_tree().change_scene_to_file("res://scenes/town.tscn")
