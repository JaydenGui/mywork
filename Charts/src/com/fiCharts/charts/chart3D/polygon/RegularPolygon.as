package com.fiCharts.charts.chart3D.polygon
{
	
	import alternativa.engine3d.core.VertexAttributes;
	import alternativa.engine3d.objects.Mesh;
	import alternativa.engine3d.resources.Geometry;
	
	import flash.display3D.Context3D;
	import flash.geom.Vector3D;
	
	public class RegularPolygon extends Mesh
	{
		//cached for temporary use
		private var _position:Vector.<Number>;
		
		private var _radius:Number;
		
		public function get radius():Number
		{
			return _radius;
		}
		
		public function RegularPolygon(num:uint,radius:Number)
		{
			super();
			
			_radius = radius;
			var attributes:Array = new Array();
			attributes[0] = VertexAttributes.POSITION;
			attributes[1] = VertexAttributes.POSITION;
			attributes[2] = VertexAttributes.POSITION;
			attributes[3] = VertexAttributes.TEXCOORDS[0];
			attributes[4] = VertexAttributes.TEXCOORDS[0];
			
			var every:Number = 2*Math.PI/num;
			var vertices:Vector.<Number> = new Vector.<Number>();
			var texcoords:Vector.<Number> = new Vector.<Number>();
			var indices:Vector.<uint> = new Vector.<uint>();
			vertices.push(0,0,0);
			texcoords.push(0.5,0.5);
			var i:int;
			for(i = 0; i < num; ++i)
			{
				var x:Number = radius*Math.cos(every*i);
				var y:Number = radius*Math.sin(every*i);
				vertices.push(x,y,0);
				texcoords.push((radius+x)/(2*radius),(radius-y)/(2*radius));
				
				if(i == num - 1)
				{
					indices.push(0,1,i+1);
					indices.push(0,i+1,1);
				}
				else
				{
					indices.push(0,i+2,i+1);
					indices.push(0,i+1,i+2);
				}
				
				//notice i*3
				addSurface(null,i*2*3,2);
//				addSurface(null,i*2*3,1);
			}
			
			geometry = new Geometry();
			geometry.addVertexStream(attributes);
			geometry.numVertices = num+1;
			geometry.setAttributeValues(VertexAttributes.POSITION, vertices);
			geometry.setAttributeValues(VertexAttributes.TEXCOORDS[0], texcoords);
			geometry.indices = indices;
		}
		
		public function cachePosition():void
		{
			_position = geometry.getAttributeValues(VertexAttributes.POSITION);
		}
		
		/**
		 * must call cachePosition() first
		 */
		public function updatePos(context3D:Context3D):void
		{
			geometry.setAttributeValues(VertexAttributes.POSITION,_position);
			geometry.upload(context3D);
		}
		
		/**
		 * must call cachePosition() first
		 */
		public  function getVertexPos(index:uint):Vector3D
		{
			if(index*3+2 > _position.length - 1)
				return null;
			
			return new Vector3D(_position[index*3],_position[index*3+1],_position[index*3+2]);
		}
		
		/**
		 * must call cachePosition() first
		 */
		public function setVertexPos(index:uint,newValue:Vector3D):void
		{
			_position[index*3] = newValue.x;
			_position[index*3+1] = newValue.y;
			_position[index*3+2] = newValue.z;
		}
	}
}