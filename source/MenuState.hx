package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxColor;
import flixel.util.FlxSave;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.text.FlxText;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
	private var op:Int;//opciones del menu
	private var cursor:FlxSprite;//cursor del menu
	private var menuString:Array<String> = ["PROTO EX", "NEW GAME", "CONTINUE"];
	private var onTween:Bool = false;
	private var title:FlxText;
	private var text:FlxText;
	private var text1:FlxText;
	
	/**dyeteh
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		
		
		
		bgColor = FlxColor.BLACK;
		super.create();
		op = 0;
		Reg.act_level = null;
		Reg.last_level = null;
		Reg.IsLoad = false;
		
		title = new FlxText(0, 64, FlxG.width,menuString[0]);
		title.setFormat(null, 48, FlxColor.SILVER,"center");
		title.setBorderStyle(FlxText.BORDER_OUTLINE, FlxColor.RED, 4, 3);
		title.alpha = 0;
		add(title);
		
		 text = new FlxText(0, FlxG.height/2, FlxG.width, menuString[1]);
		text.setFormat(null, 32, FlxColor.RED,"center");
		text.setBorderStyle(FlxText.BORDER_SHADOW, FlxColor.CHARTREUSE, 1);
		text.alpha = 0;
		add(text);
		
		
		 text1 = new FlxText(0, FlxG.height / 2 + 64, FlxG.width, menuString[2]);
		if (Reg.IsSave){
			text1.setFormat(null, 32,FlxColor.RED, "center");
			text1.setBorderStyle(FlxText.BORDER_SHADOW, FlxColor.CHARTREUSE, 1);
		
		
		}else{
			text1.setFormat(null, 32,FlxColor.TRANSPARENT, "center");
			text1.setBorderStyle(FlxText.BORDER_SHADOW, FlxColor.WHITE, 1);
		}
		text1.alpha = 0;
		add(text1);
		
		
		cursor = new FlxSprite();
		cursor.loadGraphic("assets/images/proto_basic_item.png", false, 16, 16, true);
		cursor.animation.add("play", [2], 0, false);
		cursor.animation.play("play");
		cursor.setColorTransform(0.8, 0.2, 0.2, 1.0);
		cursor.scale.x = 2;
		cursor.scale.y = 2;
	
		cursor.alpha = 0;
		cursor.x = FlxG.width / 4;
		
		add(cursor);
		onTween = true;
		var opt = {complete: offTween}
		var tween = FlxTween.tween(title, { alpha: 1 }, 1.0);
		var tween = FlxTween.tween(text, { alpha: 1 }, 1.0);
		var tween = FlxTween.tween(text1, { alpha: 1 }, 1.0);
		var tween = FlxTween.tween(cursor, { alpha: 1 }, 1.0, opt );
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		cursor.y = cursor.height/2+FlxG.height/2+64 * op;
		super.update();
		if(onTween==false){
			if(FlxG.keys.justPressed.UP){
				if(op>0){
					op -= 1;	
				}else{
					op = 1;
				}
			
			}
		
			if (FlxG.keys.justPressed.DOWN) { 
				if(op<1){
					op +=1;	
				}else{
					op = 0;
				}
			}
			
			if(FlxG.keys.justPressed.X){
						var opt;
						opt = {complete: select_option, ease: FlxEase.quadOut};
						//var tween = FlxTween.tween(cursor, { "y": cursor.y- 8, "alpha": 0 }, 0.7, opt);
						//var tween = FlxTween.tween(cursor, { "alpha": 0 , }, 0.7, opt);
						var tween = FlxTween.tween(cursor, { alpha: 0 , color:FlxColor.RED, }, 0.5, opt);
						
						var tween1 = FlxTween.tween(title, { alpha: 0 , y: title.y - 18, }, 0.5, opt);
						
						var tween2 = FlxTween.tween(text, { alpha: 0 , }, 0.5, opt);
						
						var tween3 = FlxTween.tween(text1, { alpha: 0 , }, 0.5, opt);
						//cursor.color = FlxColor.RED;
						onTween = true;
						FlxG.sound.play("assets/sounds/jam.mp3", 0.5);
			}
		}
		//cursor.y = 64+32 * op;
	}	
	
	private function select_option(tween:FlxTween):Void {
		switch(op){
			
			case 0:
				//Reg.IsLoad = false;
				Reg.act_level = null;
				FlxG.switchState(new PlayState());
			
			case 1:
				if(Reg.IsSave){
					Reg.IsLoad = true;
				/*
				var Play:PlayState = new PlayState();
					Reg.save = new FlxSave();
					Reg.save.bind(Reg.save_name);
				Play = Reg.save.data.playstate;
				FlxG.switchState(Play);
				
				*/	
					FlxG.switchState(new PlayState());
				}
				
		}
	}
	
	public function offTween(tween:FlxTween):Void{
		onTween = false;
	}
	
}