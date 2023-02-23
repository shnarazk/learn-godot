extends Resource
class_name PlayerMovementData

## walking speed
@export
var SPEED         : float = 80.0
## lifting power by jumping
@export
var JUMP_VELOCITY : float = 380.0
## negative force power applied when jump button is released
@export
var AIR_BREAK     : float = 0.25
## the number of jump in air
@export
var DOUBLE_JUMP   : int   = 1
