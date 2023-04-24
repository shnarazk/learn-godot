extends Node2D

signal change_stage(next)
signal start_conversation(lines, item)

@export
var yuhina: Node = null:
	set(value):
		$God.yuhina = value

const yuhina_start_at: Vector2 = Vector2(20, 80)

var yuhina_and_god = [
	"[b][color=blue]神様[/color][/b] また会ったな",
	"[b][color=red]yuhina[/color][/b] あ‼️",
	"[b][color=blue]神様[/color][/b] 今のお前には無理じゃな👻",
	"[b][color=red]yuhina[/color][/b] ではどうしたら！？",
	"[b][color=blue]神様[/color][/b] お前に伝説のアイテムを渡そう、それ！🎁",
]

var yuhina_and_god2 = [
	"[b][color=blue]神様[/color][/b] もうお前に喋ることはないな",
	"[b][color=blue]神様[/color][/b] イベントをクリアしてからまた来るがよい。"
]

func _on_god_yuhina_in(first):
	if first:
		start_conversation.emit(yuhina_and_god, true)
	else:
		start_conversation.emit(yuhina_and_god2, null)

func _on_kitty_kitty_meets_yuhina():
	start_conversation.emit(['ウチに戻るニャー'], false)
	change_stage.emit(1)
