package com.officeShow.mountainShow
{
	import flash.display.GraphicsPathCommand;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class MountainLabel extends Sprite
	{
		private var textView:TextField;
		public function MountainLabel()
		{
			super();
			this.mouseChildren = false;
			this.mouseEnabled = false;
		}
		
		public function set text(value:String):void
		{
			if(!textView)
			{
				textView = new TextField();
				textView.defaultTextFormat = new TextFormat("微软雅黑",12,0xffffff,null,null,null,null,null,TextFormatAlign.CENTER);
				textView.width = 64;
				textView.height = 32;
//				textView.autoSize = TextFieldAutoSize.CENTER;
				textView.x = -32;
				textView.y = -25;
				this.addChild(textView);
				
			}
			
			textView.text = value;
		}
		
		public function drawBackgroud(color:uint):void
		{
			var commands:Vector.<int> = new Vector.<int>;
			commands.push(GraphicsPathCommand.MOVE_TO);
			commands.push(GraphicsPathCommand.LINE_TO);
			commands.push(GraphicsPathCommand.LINE_TO);
			commands.push(GraphicsPathCommand.LINE_TO);
			commands.push(GraphicsPathCommand.LINE_TO);
			commands.push(GraphicsPathCommand.LINE_TO);
			commands.push(GraphicsPathCommand.LINE_TO);
			commands.push(GraphicsPathCommand.LINE_TO);
			var data:Vector.<Number> = new Vector.<Number>;
			data.push(0,0);
			data.push(2,-2);
			data.push(32,-2);
			data.push(32,-32);
			data.push(-32,-32);
			data.push(-32,-2);
			data.push(-2,-2);
			data.push(0,0);
			
			this.graphics.clear();
			
			this.graphics.beginFill(color);
			this.graphics.drawPath(commands,data);
			this.graphics.endFill();
		}
	}
}