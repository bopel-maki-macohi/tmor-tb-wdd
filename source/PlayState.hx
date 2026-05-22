package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	var player:FlxSprite;
	var playerScreenOffset:Float = 0;

	var bullets:FlxSpriteGroup;

	var opponent:FlxSprite;

	override public function create()
	{
		super.create();

		bullets = new FlxSpriteGroup();
		add(bullets);

		opponent = new FlxSprite().makeGraphic(64, 64, FlxColor.YELLOW);
		add(opponent);

		player = new FlxSprite().makeGraphic(128, 128, FlxColor.RED);
		add(player);

		player.screenCenter(X);

		player.y = FlxG.height - player.height;

		playerScreenOffset = player.width * .25;
	}

	var time:Float = 0;

	var timeSinceLastMoved:Float = 0;

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		time += elapsed;
		timeSinceLastMoved += elapsed;

		opponent.x = (256 * 2) + Math.sin(time * 2.5) * 360;
		opponent.y = (256 * 1) + Math.cos(time * 2.5) * 90;

		if (FlxG.keys.anyPressed([A, LEFT]))
		{
			player.x -= player.width * .1;
			timeSinceLastMoved = 0;
		}
		if (FlxG.keys.anyPressed([D, RIGHT]))
		{
			player.x += player.width * .1;
			timeSinceLastMoved = 0;
		}

		if (player.x < playerScreenOffset)
			player.x = playerScreenOffset;
		if (player.x > FlxG.width - player.width - playerScreenOffset)
			player.x = FlxG.width - player.width - playerScreenOffset;

		if (FlxG.keys.justPressed.SPACE)
		{
			var bullet = new FlxSprite().makeGraphic(8, 16, FlxColor.YELLOW);
			bullet.setPosition(player.getGraphicMidpoint().x, player.getGraphicMidpoint().y);
			bullets.add(bullet);
		}

		for (bullet in bullets)
		{
			bullet.y -= bullet.height * .5;

			if (bullet.y < -bullet.height)
			{
				bullets.remove(bullet);
				bullet.destroy();
			}
		}
	}
}
