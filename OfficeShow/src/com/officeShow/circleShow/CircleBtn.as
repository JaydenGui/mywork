package com.officeShow.circleShow
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class CircleBtn extends Sprite
	{
		private var radius:Number = 77;
		private var innerRadius:Number = 68;
		private var bg:Bitmap ;
		private var hitSp:Sprite;
		public function CircleBtn()
		{
			super();
			
//			this.graphics.beginFill(0x61696C,0.9);
//			this.graphics.lineStyle(0.5,0x9FA3A6);
//			this.graphics.drawCircle(0,0,radius);
//			this.graphics.endFill();
			
			var t:TextField = new TextField();
			var tf:TextFormat = new TextFormat("微软雅黑",14,0xffffff);
			t.defaultTextFormat = tf;
			t.text = "品牌";
			t.x = 26-82;
			t.y = 55-82;
			t.mouseEnabled = false;
			this.addChild(t);
			t = new TextField;
			t.defaultTextFormat = tf;
			t.text = "好评";
			t.x = 105-82;
			t.y = 53-82;
			t.mouseEnabled = false;
			this.addChild(t);
			t = new TextField;
			t.defaultTextFormat = tf;
			t.text = "覆盖";
			t.x = 69-82;
			t.y = 117-82;
			t.mouseEnabled = false;
			this.addChild(t);
			
			this.buttonMode = true;
			this.useHandCursor = true;			
		}
		
		public function setBg(bmpData:BitmapData):void
		{
			if(bg && bg.parent)
			{
				bg.parent.removeChild(bg);
			}
			
			if(!bmpData)
				return;
			
			bg = new Bitmap(bmpData);
			bg.x = -bmpData.width/2;
			bg.y = -bmpData.height/2;
			this.addChildAt(bg,0);
			
			if(hitSp && hitSp.parent)
			{
				hitSp.parent.removeChild(hitSp);
			}
			hitSp = new Sprite();
			hitSp.graphics.beginFill(0x0,0);
			hitSp.graphics.drawCircle(0,0,bmpData.width/2);
			hitSp.graphics.endFill();
			hitSp.mouseEnabled = false;
			this.addChild(hitSp);
			this.hitArea = hitSp;
		}
	}
}