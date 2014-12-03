package com.officeShow
{
	import alternativa.engine3d.core.Object3D;
	import alternativa.engine3d.materials.Material;
	import alternativa.engine3d.materials.TextureMaterial;
	import alternativa.engine3d.objects.Mesh;
	import alternativa.engine3d.objects.Sprite3D;
	import alternativa.engine3d.resources.BitmapTextureResource;
	
	import flash.display.BitmapData;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	// 效果不好，字不清晰
	public class TextSprite extends Sprite3D
	{
//		private var _text:String;
		public function TextSprite(text:String)
		{
			var tf:TextField = new TextField();
			tf.defaultTextFormat = new TextFormat("黑体",16,0xffff00);
			tf.text = text;
			var width:uint = caculatePower(tf.textWidth+6);
			var height:uint = caculatePower(tf.textHeight+6);
			
			var bmp:BitmapData = new BitmapData(width,height,true,0x00000000);
			bmp.draw(tf,null,null,null,null,false);
			
			var texture:BitmapTextureResource = new BitmapTextureResource(bmp,true);
			var textMateral:TextureMaterial = new TextureMaterial(texture,null,1);
			textMateral.opaquePass = false;
			textMateral.alphaThreshold = 1;
			super(width, height, textMateral);
		}
		
		private function caculatePower(width:uint):uint
		{
			var i:uint = 0;
			var value:uint = 0;
			while(width > value)
			{
				++i;
				value = Math.pow(2,i);
			}
			return value;
		}
		
//		public function set text(value:String):void
//		{
//			if(_text != value)
//			{
//				_text = value;
//				
//				this.material = textMateral;
//			}
//		}
//		
//		public function get text():String
//		{
//			return _text;
//		}
	}
}