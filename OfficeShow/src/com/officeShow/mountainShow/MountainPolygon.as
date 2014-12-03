package com.officeShow.mountainShow
{
	import com.officeShow.ColorUtils;
	
	import flash.display.BitmapData;
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Vector3D;
	
	import alternativa.engine3d.core.VertexAttributes;
	import alternativa.engine3d.materials.TextureMaterial;
	import alternativa.engine3d.objects.Mesh;
	import alternativa.engine3d.resources.BitmapTextureResource;
	import alternativa.engine3d.resources.Geometry;
	
	public class MountainPolygon extends Mesh
	{
		public static const MAX_HEIGHT:Number = 100;
		
		private var highestIndex:int = -1;
		public function MountainPolygon(posList:Array,heightList:Array,color:uint)
		{
			super();
			setData(posList,heightList);
			setColor(color);
		}
		
		public function getHighestVertex():Vector3D
		{
			if(highestIndex != -1)
			{
				var data:Vector.<Number> = this.geometry.getAttributeValues(VertexAttributes.POSITION);
				
				if(data)
				{
					return new Vector3D(data[highestIndex*3],data[highestIndex*3+1],data[highestIndex*3+2]);
				}
			}
			
			return null;
		}
		
		public function setData(posList:Array,heightList:Array):void
		{
			if(posList.length != heightList.length)
				throw new ArgumentError("error");
			
			
			var attributes:Array = new Array();
			attributes[0] = VertexAttributes.POSITION;
			attributes[1] = VertexAttributes.POSITION;
			attributes[2] = VertexAttributes.POSITION;
			attributes[3] = VertexAttributes.TEXCOORDS[0];
			attributes[4] = VertexAttributes.TEXCOORDS[0];
			
			var vertices:Vector.<Number> = new Vector.<Number>();
			var texcoords:Vector.<Number> = new Vector.<Number>();
			var indices:Vector.<uint> = new Vector.<uint>();
			
			var vertexNum:uint = 0;
			var max:Number = 0;
			for(var i:uint = 0; i < posList.length; ++i)
			{
				var pos:Number = posList[i] as Number;
				var h:Number = heightList[i] as Number;
				
				if(h == 0)
				{
					if(vertices.length>0)
					{
						if(vertices[vertices.length-1]!=0)
						{
							indices.push(vertexNum-2,vertexNum-1,vertexNum);
							indices.push(vertexNum-2,vertexNum,vertexNum-1);
						}
					}
					vertices.push(pos,0,0);
					texcoords.push(i/posList.length,1);
					++vertexNum;
				}
				else
				{ 
					if(vertices.length>0)
					{
						if(vertices[vertices.length-1]!=0)
						{
							indices.push(vertexNum-2,vertexNum-1,vertexNum);
							indices.push(vertexNum-2,vertexNum,vertexNum-1);
						}	
						
						indices.push(vertexNum,vertexNum-1,vertexNum+1);
						indices.push(vertexNum,vertexNum+1,vertexNum-1);
					}
					vertices.push(pos,0,0,pos,0,h);
					texcoords.push(i/posList.length,1,i/posList.length,1-h/MAX_HEIGHT);
					vertexNum+=2;
					
					if(h>max)
					{
						max = h;
						highestIndex = vertexNum - 1;
					}
				}
			}
			
			addSurface(null,0,indices.length/3);
			
			geometry = new Geometry();
			geometry.addVertexStream(attributes);
			geometry.numVertices = vertexNum;
			geometry.setAttributeValues(VertexAttributes.POSITION, vertices);
			geometry.setAttributeValues(VertexAttributes.TEXCOORDS[0], texcoords);
			geometry.indices = indices;
		}
		
		/**
		 * 0x000000
		 */
		public function setColor(color:uint):void
		{
			var weakColor:uint = 0;
			var multiple:Number = 0.6;
			
			weakColor = ColorUtils.getMultipleColor(color,multiple);

			var tmpSprite:Sprite = new Sprite();
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(64,64,Math.PI/2);
			tmpSprite.graphics.beginGradientFill(GradientType.LINEAR,[color,weakColor],[1,1],[100,255],matrix);
			tmpSprite.graphics.drawRect(0,0,64,64);
			tmpSprite.graphics.endFill();
			var bmpdata:BitmapData = new BitmapData(64,64,true,0x00000000);
			bmpdata.draw(tmpSprite);
			
			var bmpTexture:BitmapTextureResource = new BitmapTextureResource(bmpdata);
			var texture:TextureMaterial = new TextureMaterial(bmpTexture);
			this.setMaterialToAllSurfaces(texture);
		}
	}
}