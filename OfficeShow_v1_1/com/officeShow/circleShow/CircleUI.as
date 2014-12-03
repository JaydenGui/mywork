package com.officeShow.circleShow
{
	import com.greensock.TweenLite;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Dictionary;
	
	public class CircleUI extends Sprite
	{
//		[Embed(source="/../res/1.png")]
//		private var img1:Class;
//		[Embed(source="/../res/2.png")]
//		private var img2:Class;
//		[Embed(source="/../res/3.png")]
//		private var img3:Class;
//		[Embed(source="/../res/4.png")]
//		private var img4:Class;
//		[Embed(source="/../res/5.png")]
//		private var img5:Class;
		
		private var _bgMap:Dictionary;
//		private var _btnList:Vector.<CircleBtn>;
		
		private var _btnList:Vector.<CircleView>;
		private var _width:uint;
		private var _height:uint;
		
		public static const PADDING:uint = 30;
		public static const SPACE:uint = 50;
		public static const LINE_1:uint = 0x676479;
		public static const LINE_2:uint = 0x676479;
		
		public function getValidRect():Rectangle
		{
			return new Rectangle(PADDING+SPACE/2,PADDING+SPACE/2,_width-PADDING*2-SPACE,_height-PADDING*2-SPACE);
		}
		public function CircleUI(width:uint,height:uint)
		{
			super();
			_bgMap = new Dictionary(true);
			
//			_bgMap["1"] = new img1().bitmapData;
//			_bgMap["2"] = new img2().bitmapData;
//			_bgMap["3"] = new img3().bitmapData;
//			_bgMap["4"] = new img4().bitmapData;
//			_bgMap["5"] = new img5().bitmapData;
			
			_width = width;
			_height = height;
			_btnList = new Vector.<CircleView>();
			this.addEventListener(MouseEvent.CLICK,clickHandler);
			
			var left:uint = PADDING;
			var right:uint = _width - PADDING;
			var top:uint = PADDING;
			var bottom:uint = _height - PADDING;
			
			var middleXLeft:uint =(_width-SPACE)/2;
			var middleXRight:uint = _width-(_width-SPACE)/2;
			var middleYTop:uint = (_height-SPACE)/2;
			var middleYBottom:uint = _height-(_height-SPACE)/2;
			with(this.graphics)
			{
				lineStyle(0.5,LINE_1,0.5);
				moveTo(left,middleYTop);
				lineTo(left,top);
				lineTo(middleXLeft,top);
				
				moveTo(right,middleYTop);
				lineTo(right,top);
				lineTo(middleXRight,top);
				
				moveTo(left,middleYBottom);
				lineTo(left,bottom);
				lineTo(middleXLeft,bottom);
				
				moveTo(right,middleYBottom);
				lineTo(right,bottom);
				lineTo(middleXRight,bottom);
				
				lineStyle(1,LINE_1);
				moveTo(left + SPACE/2,_height/2);
				lineTo(right - SPACE/2,_height/2);
				
				moveTo(_width/2,top+SPACE/2);
				lineTo(_width/2,bottom-SPACE/2);
				
				lineStyle();
				beginFill(LINE_1);
				var pointRadius:Number = 3;
				drawCircle(left+SPACE/2,_height/2,3);
				drawCircle(right-SPACE/2,_height/2,3);
				drawCircle(_width/2+0.5,top+SPACE/2,3);
				drawCircle(_width/2+0.5,bottom-SPACE/2,3);
				endFill();
			}
			
			var names:Array = ["体验","服务","情感","价格"];
			var pos:Array = [10,_height/2-11,_width/2-13,20,_width-35,_height/2-11,_width/2-13,_height-40];
			
			for(var i:uint = 0; i < names.length; ++i)
			{
				var t:TextField = new TextField();
				t.defaultTextFormat = new TextFormat("微软雅黑",14,0x676479);
				t.text = names[i];
				t.x = pos[i*2];
				t.y = pos[i*2+1];
				t.mouseEnabled = false;
				this.addChild(t);
			}
			
		}
		
		private function clickHandler(e:MouseEvent):void
		{
			if( e.target is CircleView)
			{
				var btn:CircleView = CircleView(e.target);
				btn.alpha = 0.5;
				this.addChild(btn);
				TweenLite.to(btn,0.5,{alpha:1});
			}
		}
		
		public function clear():void
		{
			for each(var btn:CircleBtn in _btnList)
			{
				if(btn.parent)
				{
					btn.parent.removeChild(btn);
				}
			}
			
			_btnList = new Vector.<CircleView>();
		}
		
		public function addBtn(bgType:String,iconUrl:String,posX:Number,posY:Number,data1:Number,data2:Number,data3:Number,color:Number,radius:Number = 70):void
		{
//			var btn:CircleBtn = new CircleBtn();
			
//			btn.setBg(_bgMap[bgType]);
			
			var btn:CircleView = new CircleView();
			btn.init(iconUrl,radius,data1,data2,data3,color);
			btn.x = _width/2;
			btn.y = _height/2;
			_btnList.push(btn);
			this.addChild(btn);
			
			TweenLite.to(btn,1.5,{x:posX,y:posY});
		}
	}
}