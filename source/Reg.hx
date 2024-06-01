package;

import flixel.util.FlxSave;
import flixel.tile.FlxTilemap;
/**
 * Handy, pre-built Registry class that can be used to store 
 * references to objects and other things for quick-access. Feel
 * free to simply ignore it or change it in any way you like.
 */
class Reg
{
	/**
	 * Generic levels Array that can be used for cross-state stuff.
	 * Example usage: Storing the levels of a platformer.
	 */
	public static var directory_level:String = "assets/data/Levels/";
	public static var levels:Array<Dynamic> = [];
	public static var act_level:String = null;
	public static var last_level:String = null;
	public static var level_title:String = null;
	
	//save slot
	
	public static var save_slot:Bool;
	public static var save_name:String = "CheckPoint";
	
	public static var key:Array<Bool> = [false,false];
	/**
	 * Generic level variable that can be used for cross-state stuff.
	 * Example usage: Storing the current level number.
	 */
	public static var level:FlxTilemap;
	/**
	 * Generic scores Array that can be used for cross-state stuff.
	 * Example usage: Storing the scores for level.
	 */
	public static var scores:Array<Dynamic> = [];
	/**
	 * Generic score variable that can be used for cross-state stuff.
	 * Example usage: Storing the current score.
	 */
	public static var score:Int = 0;
	/**
	 * Generic bucket for storing different FlxSaves.
	 * Especially useful for setting up multiple save slots.
	 */
	public static var saves:Array<FlxSave> = [];
	
	
	//datos para cambiar nivel
	public static var save:FlxSave;
	public static var IsLoad:Bool = false;
	public static var IsSave:Bool = false;
	public static var life:Int = 0;
	public static var win:Bool = true;
	public static var weapon:Int = 0;
	public static var player_reg:Player = null;
	public static var buff:Array<Bool> = [false,false];
	public static var buff_time:Array<Float> = [0.0, 0.0];
	//
	public static var boss_defeat:Bool = false;
}