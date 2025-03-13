extends Node
class_name Store

enum GAME_STATE { PLAYING, VICTORY, LOSS }

var state: GAME_STATE = GAME_STATE.PLAYING

func set_state(new_state: GAME_STATE):
	state = new_state
