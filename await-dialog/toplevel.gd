extends Node2D


func _ready():
	var loop = true
	await $StoryDialog.print_lines([
			"最後に食事らしい食事をとってから何日が経つだろう。",
			"定期的にやってくるスコールのおかげで喉が渇かないことには感謝するが、空腹は全く解消できてない。",
			"早くなんとかしないと食べられる方になってしまいそうだ。",
			"フラフラと足元だけを見ながら歩いていて、これまでとは何かが違うことに気づいた。"
		])
	while loop:
		loop = false
		await $StoryDialog.print_lines([
			"「これは道だ！」",
			"石や草が見当たらない砂利の帯が同じ幅で続いているのは人の手が入ったものとしか考えられなかった。",
			"空腹や疑問の底なし沼からけ出せそうな期待から自然と足が速くなった。"
		])
		var res = await $SelectDialog.open("分かれ道です", "👈左に行く", "右に行く👉")
		if res == 1:
			await $StoryDialog.print_lines([
				"ますます深く暗い森の奥に延びているがどうもこちらの方がよく使われているようだ。",
				"少し広く、そして湿っぽくなってきた。赤い砂が撒かれた道を早足で進む。"
			])
			res = await $SelectDialog.open("暗い道の先から色々な音や匂いがしてきました", "そのまま進む", "様子を伺う")
		else:
			await $StoryDialog.print_lines([
				"自分の勘を信じて、あえて狭い右の坂道を選んで進む。谷に降りて行くらしい。山を下れば人間と出会えるだろう。",
				"しかし、しばらく歩くと崖崩れで道が終わっていた。いや。それは血にまみれた何かの塊だ。"
			])
			res = await $SelectDialog.open("[color=#faa]その塊はまるで呼吸しているように上下しています[/color]", "引き返す", "様子を伺う")
			print(res)
			loop = res == 1
	await $StoryDialog.print_lines([
		"話は佳境に入ってきましたが、ちょうどお時間となりました。続きはまたの機会にいたします。"
	])
	get_tree().quit()
