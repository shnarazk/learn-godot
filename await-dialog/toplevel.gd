extends Node2D


func _ready():
	var loop = true
	while loop:
		loop = false
		var res = await $SelectorDialog.open("分かれ道です", "👈左に行く", "右に行く👉")
		if res == 1:
			res = await $SelectorDialog.open("賑やかな場所に近づいてきました", "左町に入る", "左町の入口で一休みする")
		else:
			res = await $SelectorDialog.open("[color=red]怪しい雰囲気の場所に出ました[/color]", "引き返す", "様子を伺う")
			print(res)
			loop = res == 1
