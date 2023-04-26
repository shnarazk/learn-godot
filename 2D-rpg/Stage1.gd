extends Node2D

signal change_stage(next)
signal start_conversation(lines, item)

var controller: Node = null
@export
var yuhina: Node = null:
	set(value):
		$God.yuhina = value
var selecting: bool = false

const yuhina_start_at: Vector2 = Vector2(160, 180)

var yuhina_and_god = [
	"[b][color=blue]神様[/color][/b] やあよく来たな、yuhina!",
	"[b][color=red]yuhina[/color][/b] あ！その声は3年前に死んだはずの神様では‼️",
	"[b][color=blue]神様[/color][/b] ほほほほ、驚いたか👻",
	"[b][color=blue]神様[/color][/b] ちなみにこんな長いセリフだって長さを気にせず一気に喋れるのはScratchには無理な芸当だろう。どうだ！",
	"[b][color=blue]神様[/color][/b] 、、、まあ、限界はあるがな。それにボタンを押さなくても勝手に進むがな😀",
	"[b][color=red]yuhina[/color][/b] で、こんなところで何をしているのですか！？",
	"[b][color=blue]神様[/color][/b] お前にやってもらいたいことがある[color=red]以下省略[/color]",
]

# 2回目以降のセリフ
var yuhina_and_god2 = [
	"[b][color=blue]神様[/color][/b] もうお前に喋ることはないな",
	"[b][color=blue]神様[/color][/b] イベントをクリアしてからまた来るがよい。"
]

var warp = [
	"🐱 ワープなのニャー（運賃は自動引き落としなので残高に気をつけてください）！",
	"[b][color=red]yuhina[/color][/b] ね、ねこの分際で！"
]

func _on_god_yuhina_in(first):
	if first:
		start_conversation.emit(yuhina_and_god, false)
	else:
		start_conversation.emit(yuhina_and_god2, false)


func _on_kitty_kitty_meets_yuhina():
	start_conversation.emit(warp, false)
	change_stage.emit(2)

func _on_bed_coming_to_bed():
	if not selecting:
		selecting = true
		var x = await controller.select_from('寝る', '徹夜する')
		selecting = false
