package;

import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.tile.FlxTilemap;
import flixel.util.FlxPoint;
import flixel.util.FlxSave;
import flixel.FlxG;
import flixel.util.FlxColor;
import haxe.ds.Vector;
/**
 * ...
 * @author wd
 */
class Save_terminal extends FlxSprite
{
	
private static var contact:Bool = false; 
private static var IS_save:Bool = false;
	
	
	public function new(X:Float,Y:Float) 
	{
		super(X, Y);
		//makeGraphic(32, 32, FlxColor.RED, true);
		loadGraphic("assets/images/terminal.png", false, 32, 32);
		animation.add("active",[1],0,false);
		animation.add("inactive",[0],0,false);
		velocity.y = 100;
		animation.play("inactive");
	}
	
	override public function update(){
		super.update();
		contact = false;
		if(contact==false && IS_save){
			IS_save = false;
		}
		
		
	}
	
	public function collition_player():Void{
		if(contact==false){
			contact = true;
			IS_save = true;
		}
	}
	
	public function GetContact():Bool { return contact; }
	//public function Save(Enemys:FlxGroup,Atacks:FlxGroup ,Level:FlxTilemap, Platforms:FlxGroup, Items:FlxGroup,Traps:FlxGroup,Doors:FlxGroup):Void {
		public function Save(player:Player):Void {
				
			animation.play("active");
			Reg.IsSave = true;
			
			Reg.save = new FlxSave();
			//elimina data anterrior
			//Reg.save.bind(Reg.save_name);
			//Reg.save.erase();
			//carga nueva data
			Reg.save.bind(Reg.save_name);
			Reg.save.data.level_name = new String("                                         ");
			Reg.save.data.level_name = Reg.act_level;
			
			Reg.save.data.level_title = new String("                                        ");
			Reg.save.data.level_title = Reg.level_title;
			/*
			Reg.save.data.enemys_pos = new Vector<FlxPoint>();
			Reg.save.data.enemys_life = new Vector<Int>();
			Reg.save.data.enemys_tipe = new Vector<Int>();
			
			for (i in 0...Enemys.length ) {
				var e:Enemy = Enemys[i];	
				Reg.save.data.enemys_pos[i = new FlxPoint(e.x, e.y);
				Reg.save.data.enemys_life[i] = e.GetLife()
				Reg.save.data.enemys_tipe[i] = e.GetTipe();
			}
			
			*/
			Reg.save.data.playerPos = new FlxPoint(x, y);
			
			Reg.save.data.playerlife = player.GetMaxLife();
			
			//Reg.save.data.playstate = FlxG.state;
		//	FlxG.log.add("px: " + Reg.save.data.playerPos.x + " py: " + Reg.save.data.playerPos.y);
			Reg.save.flush();
	}
}