package SpaceInvaders
{

	import flash.display.*;
	import flash.events.*;

	public class Bullet extends Sprite
	{
		private var sh:Shape = new Shape;
		private var speed:Number = 5;
		
		public function Bullet()
		{
			sh.graphics.lineStyle(0, 0xFFFF00, 1);			
			sh.graphics.beginFill(0xFFCC00, 1);
			sh.graphics.drawRect(0, 0, 3, 3);
			sh.graphics.endFill();
			this.addEventListener(Event.ENTER_FRAME, goUp);
			this.addChild(sh);		
		}
		
		private function goUp(e:Event):void
		{
			this.y -= speed;
			if(this.y < -25)
			{
				removeBullet();
			}
		}
		
		public function removeBullet():void
		{
			this.removeEventListener(Event.ENTER_FRAME, goUp);
			this.removeChild(sh);
			this.parent.removeChild(this);
		}
		
	}
	
}