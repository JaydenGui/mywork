package com.officeShow.circleShow
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.BevelFilter;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.filters.ShaderFilter;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class CircleView extends Sprite
	{
		private var bottom:Sprite;
		private var fanCtner:Sprite;
		private var fans:Vector.<FanView>;
		private var fanShadow:Sprite;
		private var labels:Vector.<TextField>;
		private var texts:Array = ["品牌","好评","覆盖"];
		private var loader:Loader;
		private var hitSprite:Sprite;
		private var colors:Array = ["0xE3DA57","0xA0992E","0xC0BA6C",
			"0x6051F4","0x554F8D","0x8277F1",
			"0x76A281","0x3C6B47","0x639C71",
			"0x587DB1","0x385275","0x839BBD",
			"0xED5B5B","0xAA2A29","0xE54142",
			"0xC3C3C3","0x6B6565","0xA99FA0",
			"0xA98549","0x6C5B3F","0x9D8A6C"];
		public function CircleView()
		{
			super();
			this.mouseChildren = false;
			this.buttonMode = true;
			this.useHandCursor = true;
		}
		
		private function logoLoadComplete(e:Event):void
		{
			loader.x = -loader.width/2;
			loader.y = -loader.height/2;
		}
		
		public function init(logoUrl:String,radius:Number,data1:Number,data2:Number,data3:Number,colorIndex:int):void
		{
			var total:Number = data1+data2+data3;
			
			if(!fans)
			{
				bottom = new Sprite();
				this.addChild(bottom);
				
				fanShadow = new Sprite();
				this.addChild(fanShadow);
				
				fanCtner = new Sprite();
				this.addChild(fanCtner);
				
				fans = new Vector.<FanView>();
				fans.push(new FanView());
				fans.push(new FanView());
				fans.push(new FanView());
				fanCtner.addChild(fans[0]);
				fanCtner.addChild(fans[1]);
				fanCtner.addChild(fans[2]);
				
				labels = new Vector.<TextField>();
//				labels.push(new TextField());
//				labels.push(new TextField());
//				labels.push(new TextField());
				
				var textf:TextFormat = new TextFormat("微软雅黑",12,0xffffff);
				for(var labelIndex:int = 0; labelIndex < 3; ++labelIndex)
				{
					var txt:TextField = new TextField();
					txt.defaultTextFormat = textf;
					txt.text = texts[labelIndex];
					labels.push(txt);
				}
				
				this.addChild(labels[0]);
				this.addChild(labels[1]);
				this.addChild(labels[2]);
				
				loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE,logoLoadComplete);
				this.addChild(loader);
				
				hitSprite = new Sprite();
				hitSprite.mouseEnabled = false;
				this.addChild(hitSprite);
				this.hitArea = hitSprite;
			}
			
			hitSprite.graphics.clear();
			hitSprite.graphics.beginFill(0x0,0);
			hitSprite.graphics.drawCircle(0,0,radius+10);
			hitSprite.graphics.endFill();
			
			loader.load(new URLRequest(logoUrl));
			bottom.graphics.clear();
			bottom.graphics.beginFill(0x616469,1);
			bottom.graphics.drawCircle(0,0,radius+10);
			bottom.graphics.endFill();
			bottom.filters = [new BevelFilter(0.5,60,16777215,0.5,0x615459,1,1,1,8),new DropShadowFilter(4,45,0,0.5,10,10)];
			
			fanShadow.graphics.clear();
			fanShadow.graphics.beginFill(0x0,1);
			fanShadow.graphics.drawCircle(0,0,radius);
			fanShadow.graphics.endFill();
			fanShadow.filters = [new DropShadowFilter(2,45,0,0.5,4,4)];
			
			if(colorIndex<0||colorIndex>=colors.length/3)
			{
				colorIndex = 0;
			}
			
			var midRadius:int = 40;
			var start:Number = -90;
			fans[0].drawSector(0,0,radius,data1/total*360,start,colors[colorIndex*3]);
//			fans[0].filters = [new BevelFilter(2,90,16777215,0.5,0,0.8)];
//			fans[0].filters = [new DropShadowFilter(2,45,0,0.6)];
			
			var textDegreeList:Array = [];
			var textDegree:Number = (start+data1/total*360/2)*Math.PI/180;
			textDegreeList.push(textDegree);
			
			
			start += data1/total*360;
			fans[1].drawSector(0,0,radius,data2/total*360,start,colors[colorIndex*3+1]);
			fans[1].filters = [new DropShadowFilter(4,45,0,0.3,2,2,1,1,true)];
			
			textDegree = (start+data2/total*360/2)*Math.PI/180;
			textDegreeList.push(textDegree);
			
			start += data2/total*360;
			fans[2].drawSector(0,0,radius,data3/total*360,start,colors[colorIndex*3+2]);
//			fans[2].filters = [new BevelFilter(2,45,16777215,0.5,0,0.8)];
			fans[2].filters = [new DropShadowFilter(4,45,0,0.6)];
			
			textDegree = (start+data3/total*360/2)*Math.PI/180;
			textDegreeList.push(textDegree);
			
			for(var i:int = 0;i < 3; ++i)
			{
				labels[i].x = Math.cos(textDegreeList[i])*midRadius-(labels[i].textWidth+5)/2;
				labels[i].y = Math.sin(textDegreeList[i])*midRadius-labels[i].textHeight/2;
			}
			
			
		}
	}
}