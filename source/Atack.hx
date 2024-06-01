package;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.tile.FlxTilemap;
import flixel.FlxG;
import flixel.system.FlxSound;
import flixel.FlxState;
import flixel.FlxObject;
import openfl.geom.ColorTransform;
/**
 * ...
 * @author Santiago Arrieta
 * Ataque base
 * Un simple hitbox
 */
class Atack extends FlxSprite
{

	private var damage:Int;
	private var coulddown:Float;
	public var rebote:Bool;
	public var id:Int;
	private var level:FlxTilemap =null;
	//private var burst_sfx:FlxSound;
	private var inDie:Bool;
	private var PlayDeadSound:Bool;
	private var TIME:Float;//tiempo hasta time over
	private var fxDestroy:String = "assets/sounds/DestroyBullet.wav";
	
	public function new(X:Float,Y:Float) 
	{
		super(X, Y);	
	}
	
	public function reset_atk(X:Float, Y:Float,size_x:Int,size_y:Int,time:Float=0,Damage:Int=10):Void 
	{
		super.reset(X, Y);
		TIME = time;
		inDie = false;
		rebote = false;
		PlayDeadSound = true;
		//visible = false;
		//burst_sfx = FlxG.sound.load("assets/sounds/Dash.wav",1,false);
		if(size_x!= 0 && size_y!= 0 ){
			makeGraphic(size_x, size_y, FlxColor.RED,true);
		}
		damage = Damage;
		coulddown = time;
		level = Reg.level;
		//setLevel(cstate.GetLevel());
	}

	public function set_id(ID:Int){
		id=ID;
	}
	public function getDie():Bool{
		return inDie;
	}
	override public function update():Void
	{
		
		super.update();
		coulddown -= FlxG.elapsed;
		
		 
		if (coulddown <= 0 &&TIME>0) {	
		//	burst_sfx.play();
			inDie = true;
			time_over();
		}
		
		/*
		
		if (level!=null){
			if (level.getTile(Std.int(x/32), Std.int(y/32))!=0){
				this.kill();
			}
		}*/
	}
	

	override public function kill():Void {
			
			
			// vuelve las balas aumentadas a su tamaño base para evitar un error en el resiclado
			if (scale.x != 1) { scale.x = 1; }
			
			if (scale.y != 1) { scale.y = 1; }
			if (PlayDeadSound){
			FlxG.sound.play(fxDestroy, 1);
			}
			super.kill();
	}

	
	public function collition():Int{
		return damage;
	}
	
	
	public function rebote_dir(): Void {
		velocity.x *= 1.5;
		velocity.y *= -1.5;
		
		TIME = 1.0;
	}
	
	public function set_img(img:Int) { }
	
	public function setLevel(LEVEL:FlxTilemap) { level = LEVEL; }
	
	public function NoPlayDeadSound():Void{
			PlayDeadSound = false;
	}
	
	public function time_over():Void//ejecuta la accion al terminarse el tiempo kill por default
	{		
		NoPlayDeadSound();
		kill();
		
	}
}