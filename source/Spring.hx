package;
import flixel.util.FlxColor;
import flixel.FlxG;
/**
 * ...
 * @author Santiago Arrieta
 * resorte
	coliciona con el jugador 
	permite alcansar lugares altos
	
 */
class Spring extends Platform
{
	
	private var fxEffect:String = "assets/sounds/SpringJoint.wav";
		
	public function new(X:Float, Y:Float) 
	{
		super(X, Y);
		makeGraphic(32, 16, FlxColor.CORAL);
		immovable = false;
		//velocity.y = 100;
		ID = 2;
		loadGraphic("assets/images/spring.png", true, 32, 16, false);
		animation.add("contraido", [1], 0, false);
		animation.add("expancion", [0,1,0,1,0,0], 5,false);
		animation.play("contraido");
		check = true;
	}
	
	override public function update():Void 
	{
		super.update();
		if (animation.finished)
		{
			animation.play("contraido");
		}
	}
	
	override public function ContacPlayer():Void {
		FlxG.sound.play(fxEffect,0.4);
		animation.play("expancion");
	}
	
}