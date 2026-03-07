extends AudioStreamPlayer

const walking_music = preload("res://Audio/Walking Music GGJ - Edit.ogg")
const pong_music = preload("res://Audio/Mask Track 7.3.ogg")

func _play_music(music: AudioStream, volume = 0.0):
	if stream == music:
		return
	
	stream = music
	volume_db = volume
	play()
	
func play_music_level():
	stop_current_music()
	_play_music(walking_music)

func play_pong_music():
	stop_current_music()
	_play_music(pong_music)
	if stream == pong_music:
		return
	
func stop_current_music():
	stop()
	
