extends Panel

signal showItem

@onready
var message = $message

var active: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false

var yuhina_and_god = [
	"[b][color=blue]神様[/color][/b] やあよく来たな、yuhina!",
	"[b][color=red]yuhina[/color][/b] あ！その声は3年前に死んだはずの神様では‼️",
	"[b][color=blue]神様[/color][/b] ほほほほ、驚いたか👻",
	"[b][color=blue]神様[/color][/b] ちなみにこんな長いセリフだって長さを気にせず一気に喋れるのはScratchには無理な芸当だろう。どうだ！",
	"[b][color=blue]神様[/color][/b] 、、、まあ、限界はあるがな。それにボタンを押さなくても勝手に進むがな😀",
	"[b][color=red]yuhina[/color][/b] で、こんなところで何をしているのですか！？",
	"[b][color=blue]神様[/color][/b] お前に伝説のアイテムを渡すためじゃ、それ！🎁",
]

var yuhina_and_god2 = [
	"[b][color=blue]神様[/color][/b] もうお前に喋ることはないな",
	"[b][color=blue]神様[/color][/b] イベントをクリアしてからまた来るがよい。"
]

func _on_god_yuhina_in(first):
	if first:
		start_conversation(yuhina_and_god, true)
	else:
		start_conversation(yuhina_and_god2, false)

func start_conversation(lines, show_item):
	visible = true
	for l in lines:
		message.text = l
		$Timer.start()
		await $Timer.timeout
	visible = false
	if show_item:
		showItem.emit()
