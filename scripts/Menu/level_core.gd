extends Node

var lvl1_completed = false
var lvl2_completed = false
var lvl3_completed = false

var current_level: String = "lvl1"
var level_times = {
	"lvl1": {"minutes": 0, "seconds": 30},
	"lvl2": {"minutes": 0, "seconds": 45},
	"lvl3": {"minutes": 1, "seconds": 0}
}
