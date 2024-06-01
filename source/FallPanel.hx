package;
import flixel.addons.display.FlxExtendedSprite.MouseCallback;
import flixel.util.FlxColor;
import flixel.FlxG;
/**
 * ...
 * @author Santiago Arrieta
 * Plataforma que cae momentos despues de que haga contacto con el jugador
 * regresa a su pocion origina moementos despues
 */
class FallPanel extends Platform
{
	private var coulddown:Float;
	
	private var respaw:Bool=false;
	private var contact:Bool=false;
	private var origin_x:Float;
	private var origin_y:Float;
	
	private static var time_to_Fall:Float = 0.4;
	
	public function new(X:Float, Y:Float,Image:Int) 
	{
		super(X, Y);
		ID = 1;
		
		var img:Int = 6 + Image * 8;
	
		origin_x = X;
		origin_y = Y;
		velocity.x = 0;
		velocity.y = 0;
		loadGraphic("assets/images/tileset.png" , false, 32, 32, true);
		
		animation.add("Play", [img], 0, false);
				animation.play("Play");
		//makeGraphic(64, 16, FlxColor.ROYAL_BLUE, true);
		//immovable = true;
	}
	
	override public function update():Void 
	{
		super.update();
		// cae despues de hacer contacto con el jugador
		if (respaw) {
			
			velocity.y = 200;	
			if (coulddown <= 0 ) {
				x = origin_x;
				y = origin_y;	
				respaw = false;
				velocity.x = 0;
				velocity.y = 0;
				
				contact = false;//se restable la variable para repetir la accion
				alpha = 1;
				check = true;
				//FlxG.log.add("Respan complete");
			}
			else {
				
				alpha -= FlxG.elapsed;
				coulddown -= FlxG.elapsed;
			}
		}
		else if (contact) {	
			if (coulddown<=0){
				respaw = true;
				coulddown = 2.0;
				y += 1;//
				
				check = false;
				
				//color = FlxColor.GREEN;
				
			}else{
				coulddown -= FlxG.elapsed;
			}
		}
		// retorna a la posicion original
		
		
	}
	
	override public function ContacPlayer():Void{
		if(contact==false && respaw==false ){
			contact = true;
			
			coulddown = time_to_Fall;
			//color = FlxColor.RED;
		}
	}
}