package;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxG;
/**
 * ...
 * @author Santiago Arrieta
 * Puerta a otro nivel
 * 
 */
class Door extends FlxSprite
{

	private var next:String;
	
	public function new(X:Float=0, Y:Float=0,Next_level:String) 
	{
		super(X, Y);
		makeGraphic(32, 32, FlxColor.AZURE, true);
		loadGraphic("assets/images/pasillo_2.png", true, 32, 32,true);
		
		width = 24;
		offset.x = 4;
		next = Next_level;
		
	}
	
	public function level_string(SetTitle:Bool=true):String {
		if (SetTitle) {
		// nesesario para que el tren al principio de cada nivel muestre el nombre del mosmo(LevelTitle en playstate)
		Reg.level_title = next;
		
		}
		var level = Reg.directory_level + next + ".tmx";
		//FlxG.log.add(level);
		return level;
	}
}