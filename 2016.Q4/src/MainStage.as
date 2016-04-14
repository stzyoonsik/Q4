package
{	
	import starling.display.Image;
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
		private var _loadResource:ResourceLoader;
		
		private var _imageArray:Array = new Array();
		private var _textureArray:Array = new Array();
		
		private var _playButton:Image;
		private var _pauseButton:Image;
		private var _deleteButton:Image;
		private var _loadSpriteSheetsButton:Image;		
		
		private var _animationModeOnButton:Image;
		private var _animationModeOffButton:Image;
		private var _imageModeOnButton:Image;
		private var _imageModeOffButton:Image;
		
		private var _animationModeText:TextField;
		private var _imageModeText:TextField;
		
		private var _content:Image;
	
		
		public function MainStage()
		{
			_loadResource = new ResourceLoader(onLoadingComplete);
			addEventListener(TouchEvent.TOUCH, onAddedEvents);	
			
			
			//addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		private function onInit():void
		{
			//stage.addEventListener(TouchEvent.TOUCH, onLoadSpriteSheets);			
		}
		
		private function onAddedEvents(event:Event):void
		{
			trace(event.target);
			_animationModeOnButton.addEventListener(TouchEvent.TOUCH, onTouchRadioAnimationModeOn);
			_animationModeOffButton.addEventListener(TouchEvent.TOUCH, onTouchRadioAnimationModeOff);
			
			_imageModeOnButton.addEventListener(TouchEvent.TOUCH, onTouchRadioImageModeOn);
			_imageModeOffButton.addEventListener(TouchEvent.TOUCH, onTouchRadioImageModeOff);
			
			_playButton.addEventListener(TouchEvent.TOUCH, onPlayButton);
			_pauseButton.addEventListener(TouchEvent.TOUCH, onPauseButton);
			_deleteButton.addEventListener(TouchEvent.TOUCH, onDeleteButton);
			_loadSpriteSheetsButton.addEventListener(TouchEvent.TOUCH, onLoadSpriteSheetsButton);	
			
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
				moveToTextureAndImage(_loadResource.imageDataArray);
				//addChild(image);
				init();
			}
		}
		
		/**
		 * 
		 * @param loadedImageArray ImageData 타입의 어레이
		 * @return Image 타입의 어레이
		 * ImageData의 비트맵데이터와 이름을 Image에 옮기는 메소드
		 */
		private function moveToTextureAndImage(loadedImageArray:Array):void
		{
			for(var i:int = 0; i<loadedImageArray.length; ++i)
			{				
				var texture:Texture = Texture.fromBitmapData(loadedImageArray[i].bitmapData);
				//_textureArray.push(texture);
				
				var image:Image = new Image(texture);				
				image.name = loadedImageArray[i].name;
				
				_imageArray.push(image);
				
			}			
			
		}
		
		/**
		 * 로드된 UI 객체들을 초기화 하는 메소드 
		 * 
		 */
		private function init():void
		{
			trace("init");
			for(var i:int = 0; i<_imageArray.length; ++i)
			{
				switch(_imageArray[i].name)
				{
					case "playButton":
						//trace("playButton");
						_playButton = new Image(_imageArray[i].texture);
						_playButton.pivotX = _playButton.width / 2;
						_playButton.pivotY = _playButton.height / 2;
						_playButton.x = 632;
						_playButton.y = 532;						
						addChild(_playButton);						
						break;
					case "pauseButton":
						_pauseButton = new Image(_imageArray[i].texture);
						_pauseButton.pivotX = _pauseButton.width / 2;
						_pauseButton.pivotY = _pauseButton.height / 2;
						_pauseButton.x = 732;
						_pauseButton.y = 532;
						addChild(_pauseButton);
						break;
					case "deleteButton":
						_deleteButton = new Image(_imageArray[i].texture);
						_deleteButton.pivotX = _deleteButton.width / 2;
						_deleteButton.pivotY = _deleteButton.height / 2;
						_deleteButton.x = 832;
						_deleteButton.y = 532;
						addChild(_deleteButton);
						break;
					case "loadButton":
						_loadSpriteSheetsButton = new Image(_imageArray[i].texture);
						_loadSpriteSheetsButton.pivotX = _loadSpriteSheetsButton.width / 2;
						_loadSpriteSheetsButton.pivotY = _loadSpriteSheetsButton.height / 2;
						_loadSpriteSheetsButton.x = 178;
						_loadSpriteSheetsButton.y = 532;
						addChild(_loadSpriteSheetsButton);
						break;
					case "radioButtonOff":
						_animationModeOffButton = new Image(_imageArray[i].texture);
						_animationModeOffButton.x = 350;
						_animationModeOffButton.y = 500;
						_animationModeOffButton.visible = false;
						addChild(_animationModeOffButton);
						
						_imageModeOffButton = new Image(_imageArray[i].texture);
						_imageModeOffButton.x = 350;
						_imageModeOffButton.y = 550;
						_imageModeOffButton.visible = true;
						addChild(_imageModeOffButton);						
						break;
					case "radioButtonOn":
						_animationModeOnButton = new Image(_imageArray[i].texture);
						_animationModeOnButton.x = 350;
						_animationModeOnButton.y = 500;
						_animationModeOnButton.visible = true;
						addChild(_animationModeOnButton);
						
						_imageModeOnButton = new Image(_imageArray[i].texture);
						_imageModeOnButton.x = 350;
						_imageModeOnButton.y = 550;
						_imageModeOnButton.visible = false;
						addChild(_imageModeOnButton);
						break;
					case "content":
						_content = new Image(_imageArray[i].texture);
						_content.x = 50;
						_content.y = 50;
						addChild(_content);
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
				
				_playButton.visible = true;
				_pauseButton.visible = true;
				_deleteButton.visible = true;
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
				
				_playButton.visible = true;
				_pauseButton.visible = true;
				_deleteButton.visible = true;
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
				
				_playButton.visible = false;
				_pauseButton.visible = false;
				_deleteButton.visible = false;
				
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
				
				_playButton.visible = false;
				_pauseButton.visible = false;
				_deleteButton.visible = false;
			}
		}
		
		/**
		 * 
		 * @param event 마우스 클릭 
		 * 클릭이 발생했을 때 버튼 이미지의 크기를 신축하고, 이미지를 재생하는 메소드
		 */
		private function onPlayButton(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(_playButton, TouchPhase.BEGAN);
			if(touch)
			{
				
				_playButton.scale = 0.8;
			}
			else
			{
				_playButton.scale = 1;
			}
			
			touch = event.getTouch(_playButton, TouchPhase.ENDED);
			if(touch)
			{
				trace("플레이버튼");
			}
		}
		
		/**
		 * 
		 * @param event 마우스 클릭
		 * 클릭이 발생했을 때 버튼 이미지의 크기를 신축하고, 이미지의 재생을 멈추는 메소드
		 */
		private function onPauseButton(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(_pauseButton, TouchPhase.BEGAN);
			if(touch)
			{
				
				_pauseButton.scale = 0.8;
			}
			else
			{
				_pauseButton.scale = 1;
			}
			
			touch = event.getTouch(_pauseButton, TouchPhase.ENDED);
			if(touch)
			{
				trace("퍼즈버튼");
			}
		}
		
		/**
		 * 
		 * @param event 마우스 클릭
		 * 클릭이 발생했을 때 버튼 이미지의 크기를 신축하고, 현재 이미지를 배열에서 제거하는 메소드
		 */
		private function onDeleteButton(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(_deleteButton, TouchPhase.BEGAN);
			if(touch)
			{
				
				_deleteButton.scale = 0.8;
			}
			else
			{
				_deleteButton.scale = 1;
			}
			
			touch = event.getTouch(_deleteButton, TouchPhase.ENDED);
			if(touch)
			{
				trace("삭제버튼");
			}
		}
		

		/**
		 * 
		 * @param event 마우스 클릭
		 * 클릭이 발생했을 때 버튼 이미지의 크기를 신축하고, 스프라이트 시트를 가져오는 메소드
		 */
		private function onLoadSpriteSheetsButton(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(_loadSpriteSheetsButton, TouchPhase.BEGAN);
			if(touch)
			{
				
				_loadSpriteSheetsButton.scale = 0.8;
			}			
			else
			{
				_loadSpriteSheetsButton.scale = 1;
			}
		}
	}
}