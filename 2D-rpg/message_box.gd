extends Panel

@onready
var message = $message

var active: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

var yuhina_and_god = [
	"[b][color=blue]神様[/color][/b] やあよく来たね、yuhina!",
	"[b][color=red]yuhina[/color][/b] あ! あなたは神様！？",
	"[b][color=blue]神様[/color][/b] ほほほほ、驚いたか",
	"[b][color=blue]神様[/color][/b] ちなみにこんな長いセリフだって長さを気にせず一気に喋れるのはScratchには無理な芸当だろう。どうだ！",
	"[b][color=blue]神様[/color][/b] 、、、まあ、限界はあるがな。それにボタンを押さなくても勝手に進むがな。😀"
]

var yuhina_and_god2 = [
	"[b][color=blue]神様[/color][/b] もうお前に喋ることはないな",
	"[b][color=blue]神様[/color][/b] イベントをクリアしてからまた来るがよい。"
]

func _on_god_yuhina_in():
	start_conversation(yuhina_and_god)
#	visible = true
#	message.text = "やあよく来たね、yuhina!"
#	$Timer.start()
#	await $Timer.timeout
#	message.text = "あ! あなたは神様！？"
#	$Timer.start()
#	await $Timer.timeout
#	message.text = "ほほほほ、驚いたか"
#	$Timer.start()
#	await $Timer.timeout
#	visible = false

func start_conversation(lines):
	visible = true
	for l in lines:
		message.text = l
		$Timer.start()
		await $Timer.timeout
	visible = false


func _on_timer_timeout():
	pass # Replace with function body.
