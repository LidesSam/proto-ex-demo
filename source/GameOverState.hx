
package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.plugin.TweenManager;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.util.FlxPoint;
/**
 * ...
 * @author 
 * Pantalla de gameover
 * muestra mensaje de victoria o derrota segun se cumplan las condiciones
 */
class GameOverState extends FlxState
{

	private var win_lose:String;
	private var border_color:Int;
	private var text_color:Int;
	private var onTween:Bool;
	var GameOverText:FlxText;
	var PressText:FlxText;
	
	override public function create():Void
	{
		onTween = true;
		super.create();
		
		var char_size:Float = 32;
		if(Reg.win){
			win_lose = "You Win!!";
			bgColor = FlxColor.ROYAL_BLUE;
			border_color = FlxColor.BLACK;
			text_color = FlxColor.WHITE;
			char_size = 48;
		}else {
			win_lose = "Game Over...";
			bgColor = FlxColor.BLACK;
			border_color = FlxColor.RED;
			text_color = FlxColor.PURPLE;
		}
		
		GameOverText = new FlxText(0, FlxG.height/3, FlxG.width, win_lose);
		GameOverText.setFormat(null,char_size,text_color, "center");
		GameOverText.setBorderStyle(FlxText.BORDER_SHADOW, border_color, 4);
		add(GameOverText);
		
		var pathx = GameOverText.x;
		var pathy = GameOverText.y;
		
		var path:Array<FlxPoint> = [new FlxPoint(pathx, 0), new FlxPoint(pathx, pathy + 128), new FlxPoint(pathx, pathy)];
		
		
		PressText = new FlxText(0,FlxG.height/3+96, FlxG.width, "Press (X)");
		PressText.setFormat(null, 16,text_color, "center");
		PressText.setBorderStyle(FlxText.BORDER_SHADOW, border_color, 1);
		add(PressText);
		PressText.alpha = 0;
		var opt = { complete:setOnTween };
		
		var tween = FlxTween.linearPath(GameOverText, path, 1.0);
		var tween = FlxTween.tween(PressText, { alpha: 1 }, 1.0, opt );
		
	}
	
	public function setOnTween(tween:FlxTween) { onTween = false; }
	
	override public function update() {
		
		if (FlxG.keys.pressed.X && onTween == false){
			
			FlxG.sound.play("assets/sounds/jam.mp3", 0.5);
			FlxG.switchState(new MenuState());
		}
	}
	
	
}