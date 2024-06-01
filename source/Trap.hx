package;

import flixel.FlxSprite;
import flixel.FlxG;
/**
 * ...
 * @author 
 * Tranpas que causan daño al jugador por contacto
 * needle//agujas Muerte subita
 * fire trap// torrente de fuego con intervalos donde no causa daño
 */
class Trap extends FlxSprite
{
	
	private var id:Int;
	private var dmg:Int;
	private var inAction:Bool;
	private var coulddown:Float;
	
	public function new(X:Float = 0, Y:Float = 0, ID:Int,  ?Rotate:Int ) 
	{
		
		
		super(X,Y);
		
		id = ID;
		loadGraphic("assets/images/traps.png", true, 32, 32, false);
			
		switch (id) {
			//agujas
			case 0:
			
			
			
			animation.add("active", [3], 0, false);
			
			dmg = 200;//para muerte subita
			//lansallamas
		case 1:
			animation.add("active", [1,2], 15, true);
			animation.add("inactive", [0], 0, false);
			width = 8;
			offset.x = 12;
			x += 12;
			dmg = 10;
			inAction = false;
			coulddown = 0;
		}
		
		animation.play("active");
	}
	
	override public function update():Void{
		super.update();
		if(id==1){//solo para fire trap abre y cierra el torrente de fuego
			if(coulddown<=0){
				if(inAction){
					animation.play("inactive");
					inAction = false;
					coulddown = 1;
				}
				else{
					animation.play("active");
					inAction = true;
					coulddown = 1;
				}
			}
			else{
				coulddown-=FlxG.elapsed;
			}
		}
	}
	
	public function GetDmg():Int{
		return dmg;
	}
	
	public function InAction():Bool{
		return inAction;
	}
	
	public function GetID():Int{
		return id;
	}
	
	
	
}