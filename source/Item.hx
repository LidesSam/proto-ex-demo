package;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;
import openfl.geom.ColorTransform;
import flixel.util.FlxColor;
/**
 * ...
 * @author ...
 * Items del juego
 * pueden desaparecer despues de un timpo
 * otorgan un venficio al jugador segun su id
 * id=0: health/recupera vida
 * id=1: power //Activa buff causa mas daño
 * id=2: shield /Activa Buff menos daño recivid0
 * */
class Item extends FlxSprite
{
	private var id:Int;
	
	private var time:Bool;
	private var coulddown:Float;
	private var contact:Bool;
	public function new(X:Float,Y:Float,ID:Int,Time:Bool=false) 
	{
		super(X, Y);
		id = ID;
		time = Time;
		if(time){
			coulddown = 2;
		}
		loadGraphic("assets/images/proto_basic_item.png", true, 16, 16, false);
		animation.add("item", [id], 0,false);
		animation.play("item");
		velocity.y = 300;
		contact = false;
	}
	
	override public function update():Void 
	{
		super.update();
	
		//color = FlxColor.RED;
		if (contact){
		//colorTransform = new ColorTransform(0.3, 1.0, 0.5);
			//solo si esta en contacto con el suelo inicia el contador
			//color= FlxColor.MEDIUM_BLUE;
			if (coulddown<=0){
				kill();
			}
			else{
				coulddown -= FlxG.elapsed;
			}
				
		}
		
	}
	
	
	public function LevelCollition():Void{
		//activa el contadod para desaparesca(llama metodo kill()) el item
		//solo si se coloco time como verdadero
		if (time){
			contact = true;
		}
	}
	
	public function get_id():Int{
		return id;
	}
	
}