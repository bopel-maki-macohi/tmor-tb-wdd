package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	var player:FlxSprite;
	var playerScreenOffset:Float = 0;

	override public function create()
	{
		super.create();

		player = new FlxSprite().makeGraphic(128, 128, FlxColor.RED);
		add(player);

		player.screenCenter(X);

		player.y = FlxG.height - player.height;

		playerScreenOffset = player.width * .25;
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.anyPressed([A, LEFT]))
			player.x -= player.width * .1;
		if (FlxG.keys.anyPressed([D, RIGHT]))
			player.x += player.width * .1;

		if (player.x < playerScreenOffset)
			player.x = playerScreenOffset;
		if (player.x > FlxG.width - player.width - playerScreenOffset)
			player.x = FlxG.width - player.width - playerScreenOffset;
	}
}
