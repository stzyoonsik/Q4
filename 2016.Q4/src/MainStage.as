package
{	

	import flash.filesystem.FileStream;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.Texture;

	public class MainStage extends Sprite
	{
		private var _animationMode:AnimationMode = new AnimationMode();
		private var _imageMode:ImageMode = new ImageMode();
		private var _spriteSheet:SpriteSheet = new SpriteSheet();
		private var _loadResource:GUILoader;
		
		private var _guiArray:Array = new Array();									//gui 리소스가 담긴 배열
		
		private var _fileStream:FileStream;
		
		
		
		private var _animationModeOnButton:Image;
		private var _animationModeOffButton:Image;
		private var _imageModeOnButton:Image;
		private var _imageModeOffButton:Image;
		
		private var _animationModeText:TextField;
		private var _imageModeText:TextField;
		
		public function MainStage()
		{
			_loadResource = new GUILoader(onLoadingComplete);
			addEventListener(TouchEvent.TOUCH, onAddedEvents);				
		}
		
		/**
		 * 모든 터치 이벤트를 관장하는 이벤트 리스너 
		 * @param event
		 * 
		 */
		private function onAddedEvents(event:starling.events.Event):void
		{
			//trace(event.target);
			_animationModeOnButton.addEventListener(TouchEvent.TOUCH, onTouchRadioAnimationModeOn);
			_animationModeOffButton.addEventListener(TouchEvent.TOUCH, onTouchRadioAnimationModeOff);
			
			_imageModeOnButton.addEventListener(TouchEvent.TOUCH, onTouchRadioImageModeOn);
			_imageModeOffButton.addEventListener(TouchEvent.TOUCH, onTouchRadioImageModeOff);
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
				moveToImage(_loadResource.imageDataArray);
				init();
				
				_animationMode.init(_guiArray);
				var animationModeSprite:Sprite = _animationMode;				
				addChild(animationModeSprite);
				
				_spriteSheet.init(_guiArray);
				var spriteSheetSprite:Sprite = _spriteSheet;
				addChild(spriteSheetSprite);
			}
		}
		
		/**
		 * 
		 * @param loadedImageArray ImageData 타입의 어레이
		 * @return Image 타입의 어레이
		 * ImageData의 비트맵데이터와 이름을 Image에 옮기는 메소드
		 */
		private function moveToImage(loadedImageArray:Array):void
		{
			for(var i:int = 0; i<loadedImageArray.length; ++i)
			{				
				var texture:Texture = Texture.fromBitmapData(loadedImageArray[i].bitmapData);
				//_textureArray.push(texture);
				
				var image:Image = new Image(texture);				
				image.name = loadedImageArray[i].name;
				
				_guiArray.push(image);
				
			}			
			
		}
		
		/**
		 * 로드된 UI 객체들을 초기화 하는 메소드 
		 * 
		 */
		private function init():void
		{
			//trace("init");
			for(var i:int = 0; i<_guiArray.length; ++i)
			{
				switch(_guiArray[i].name)
				{
					case "radioButtonOff":
						_animationModeOffButton = new Image(_guiArray[i].texture);
						_animationModeOffButton.x = 350;
						_animationModeOffButton.y = 500;
						_animationModeOffButton.visible = false;
						addChild(_animationModeOffButton);
						
						_imageModeOffButton = new Image(_guiArray[i].texture);
						_imageModeOffButton.x = 350;
						_imageModeOffButton.y = 550;
						_imageModeOffButton.visible = true;
						addChild(_imageModeOffButton);						
						break;
					case "radioButtonOn":
						_animationModeOnButton = new Image(_guiArray[i].texture);
						_animationModeOnButton.x = 350;
						_animationModeOnButton.y = 500;
						_animationModeOnButton.visible = true;
						addChild(_animationModeOnButton);
						
						_imageModeOnButton = new Image(_guiArray[i].texture);
						_imageModeOnButton.x = 350;
						_imageModeOnButton.y = 550;
						_imageModeOnButton.visible = false;
						addChild(_imageModeOnButton);
						break;
			
				}
			}
			
			_animationModeText = new TextField(150, 32, "Animation Mode");
			_animationModeText.x = 400;
			_animationModeText.y = 500;
			_animationModeText.border = true;
			addChild(_animationModeText);
			
			_imageModeText = new TextField(150, 32, "Image Mode");
			_imageModeText.x = 400;
			_imageModeText.y = 550;
			_imageModeText.border = true;
			addChild(_imageModeText);
			
		}
		
		/**
		 * 
		 * @param event 마우스가 버튼위에 올라오는 이벤트
		 * 터치 (클릭)이 발생하면, 라디오 버튼의 이미지를 바꿔주는 콜백 메소드 (아래 4개 동일)
		 */		
		private function onTouchRadioAnimationModeOn(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(_animationModeOnButton, TouchPhase.ENDED);
			if(touch)
			{
				//trace("라디오 터치");
				_animationModeOnButton.visible = true;
				_animationModeOffButton.visible = false;
				
				_imageModeOnButton.visible = false;
				_imageModeOffButton.visible = true;
				
				_animationMode.visible = true;
			}
		}
		
		private function onTouchRadioAnimationModeOff(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(_animationModeOffButton, TouchPhase.ENDED);
			if(touch)
			{
				_animationModeOnButton.visible = true;
				_animationModeOffButton.visible = false;
				
				_imageModeOnButton.visible = false;
				_imageModeOffButton.visible = true;
				
				_animationMode.visible = true;
			}
		}
		

		private function onTouchRadioImageModeOn(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(_imageModeOnButton, TouchPhase.ENDED);
			if(touch)
			{
				_animationModeOnButton.visible = false;
				_animationModeOffButton.visible = true;
				
				_imageModeOnButton.visible = true;
				_imageModeOffButton.visible = false;
				
				_animationMode.visible = false;
				
			}
		}
		
		
		private function onTouchRadioImageModeOff(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(_imageModeOffButton, TouchPhase.ENDED);
			if(touch)
			{
				_animationModeOnButton.visible = false;
				_animationModeOffButton.visible = true;
				
				_imageModeOnButton.visible = true;
				_imageModeOffButton.visible = false;
				
				_animationMode.visible = false;
			}
		}
	}
}