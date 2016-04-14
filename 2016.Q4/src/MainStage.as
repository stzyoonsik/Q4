package
{
	
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.TouchEvent;
	import starling.textures.Texture;

	public class MainStage extends Sprite
	{
		private var _loadResource:ResourceLoader;
		//private var _loadedImageArray:Array = new Array();
		private var _imageArray:Array;
		
		public function MainStage()
		{
			_loadResource = new ResourceLoader(onLoadingComplete);
			
			//addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		private function onInit():void
		{
			//stage.addEventListener(TouchEvent.TOUCH, onLoadSpriteSheets);			
		}
		
		/**
		 * 모든 리소스의 로딩이 끝났는지를 검사하는 메소드
		 * 다 끝났다면 새 배열로 복사함
		 * 
		 */
		private function onLoadingComplete():void
		{	
			
			//얼마나 로딩됬는지를 나타냄
			if(_loadResource.imageDataArray.length / _loadResource.fileCount != 1)
				trace((_loadResource.imageDataArray.length / _loadResource.fileCount * 100).toFixed(1));
			else if(_loadResource.imageDataArray.length / _loadResource.fileCount == 1)
				trace("이미지 로딩 완료");
			else
				trace("이미지 로딩 실패");
			
			//모두 로딩이 됬다면
			if(_loadResource.imageDataArray.length == _loadResource.fileCount)
			{	
				//var loadedImageArray:Array = _loadResource.imageDataArray;
				
				_imageArray = moveToImage(_loadResource.imageDataArray);
				//addChild(image);
			}
		}
		
		/**
		 * 
		 * @param loadedImageArray ImageData 타입의 어레이
		 * @return Image 타입의 어레이
		 * ImageData의 비트맵데이터와 이름을 Image에 옮기는 메소드
		 */
		private function moveToImage(loadedImageArray:Array):Array
		{
			var imageArray:Array = new Array();;
			
			for(var i:int = 0; i<loadedImageArray.length; ++i)
			{				
				var image:Image = new Image(Texture.fromBitmapData(loadedImageArray[i].bitmapData));
				
				image.name = loadedImageArray[i].name;				
				
				imageArray.push(image);
				addChild(image);
			}			
			
			return imageArray;
		}
		
		private function initPlace():void
		{
			
		}
		
		private function onLoadSpriteSheets(event:TouchEvent):void
		{
			
		}
	}
}