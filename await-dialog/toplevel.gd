extends Node2D


func _ready():
	await $StoryDialog.print_lines([
			"今から博多手一本の特訓をします。",
			"掛け声に合わせて正しい合いの手を入れてください。"
		])
	while true:
		var res1 = await $SelectDialog.open("よーお", "パパパン", "パンパン")
		var res2 = await $SelectDialog.open("もひとつ", "パンパン", "パンパンパン")
		var res3 = await $SelectDialog.open("いおうてさんど", "パンパンパン", "パパンパン")
		if res1 == 2 and res2 == 1 and res3 == 2:
			await $StoryDialog.print_lines(["やればできるたい", "わすれたらばちかぶるぞ", "もうかえってよか"])
			break
		else:
			await $StoryDialog.print_lines(["きさんふざけとっとか", "もいっぺんやりなおし"])
	get_tree().quit()
