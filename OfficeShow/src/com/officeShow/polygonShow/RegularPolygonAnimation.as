package com.officeShow.polygonShow
{
	import com.greensock.TweenLite;
	
	import flash.geom.Vector3D;
	

	public class RegularPolygonAnimation
	{
		public static const MAX:Number = 200;
		public static const PLUS:Number = 0.5;
		private var _data:Array = [1000,800,600,600,100,100,100,100,600];
		private var zAnimation:TweenLite;
		public function RegularPolygonAnimation(polygon:RegularPolygon,data:Array = null)
		{
				if(data != null && data.length == _data.length)
					_data = data;
				
				var sortResult:Array = _data.concat();
				sortResult.sort(Array.NUMERIC|Array.DESCENDING);
				
				var maxValue:Number = sortResult[0];
				
				
				polygon.cachePosition();
				for(var i:int = 0; i < _data.length; ++i)
				{
					var index:int = i*2+1;
					var h:Number = _data[i]/maxValue*MAX;
					var pos:Vector3D = polygon.getVertexPos(index);
					pos.z = h;
					polygon.setVertexPos(index,pos);
					
					if(index == 1)
					{
						var prePos:Vector3D = polygon.getVertexPos(_data.length*2 - 1);
						prePos.z = h*PLUS;
						polygon.setVertexPos(_data.length*2 - 1,prePos);
					}
					
					var nextPos:Vector3D = polygon.getVertexPos(index+1);
					if(nextPos)
					{
						nextPos.z = h*PLUS;
						polygon.setVertexPos(index+1,nextPos);
					}
				}
				
		}
		
		
	}
}