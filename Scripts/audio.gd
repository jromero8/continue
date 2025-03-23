class_name AudioClass
extends Node

enum AUDIO_CODE{
	LEVEL_1
}

const LEVEL_1 = preload("res://Audio/level_1.mp3")

func _ready() -> void:
	process_mode = PROCESS_MODE_ALWAYS

func play_sound(audio_code : AUDIO_CODE):
	var sp = get_available_stream_player()
	match audio_code:
		AUDIO_CODE.LEVEL_1:
			sp.set_meta("AUDIO_CODE", AUDIO_CODE.LEVEL_1)
			sp.stream = LEVEL_1
			sp.volume_db = -30
			sp.play()

func get_available_stream_player() -> AudioStreamPlayer:
	for sp in get_children():
		if sp is AudioStreamPlayer:
			if not sp.playing:
				sp.volume_db = -10
				return sp
	var sp = AudioStreamPlayer.new()
	sp.volume_db = -10
	add_child(sp)
	return sp

func stop_sound(audio_code : AUDIO_CODE):
	for sp in get_children():
			if sp is AudioStreamPlayer:
				if sp.playing and sp.get_meta("AUDIO_CODE") == audio_code:
					print("STOP")
					sp.volume_db = -10
					sp.stop()
