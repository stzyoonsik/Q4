package
{	

	import flash.filesystem.FileStream;
	import flash.utils.Dictionary;
	
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
		
		private var _guiArray:Vector.<Image> = new Vector.<Image>;									//gui 리소스가 담긴 배열
		
		private var _fileStream:FileStream;
		
		private var _content:Image;
		
		private var _animationModeOnButton:Image;
		private var _animationModeOffButton:Image;
		private var _imageModeOnButton:Image;
		private var _imageModeOffButton:Image;
		
		private var _animationModeText:TextField;
		private var _imageModeText:TextField;
		
		private var _spriteVector:Vector.<TextField> = new Vector.<TextField>;
		
		private var _listSpr:Vector.<Sprite> = new Vector.<Sprite>;
		
		//private var 
		
		//private var _showSpr:Sprite = new Sprite();
		
		
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
				
				_spriteSheet.init(_guiArray);
				_spriteSheet.addEventListener("selected", onSelectedSpriteSheet);
				addChild(_spriteSheet);
				trace(_spriteSheet.bounds);
				
				_animationMode.init(_guiArray);	
				trace(_animationMode.bounds);
				addChild(_animationMode);
				
				//이미지 모드의 sprite 크기를 줄여야함
				_imageMode.init(_guiArray);
				_imageMode.visible = false;
				_imageMode.addEventListener("arrowUp", onArrowUp);
				_imageMode.addEventListener("arrowDown", onArrowDown);
				addChild(_imageMode);
				trace(_imageMode.bounds);
				
				
				
				
			}
		}
		
		/**
		 * 
		 * @param loadedImageArray ImageData 타입의 어레이
		 * @return Image 타입의 어레이
		 * ImageData의 비트맵데이터와 이름을 Image에 옮기는 메소드
		 */
		private function moveToImage(loadedImageArray:Vector.<ImageData>):void
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
					case "content":
						_content = new Image(_guiArray[i].texture);
						_content.pivotX = _content.width / 2;
						_content.pivotY = _content.height / 2;
						_content.x = 450;
						_content.y = 250;
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
				
				_animationMode.visible = true;
				_imageMode.visible = false;
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
				_imageMode.visible = false;
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
				_imageMode.visible = true;
				
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
				_imageMode.visible = true;
			}
		}
		
		private function onSelectedSpriteSheet():void
		{
			//_imageMode.setList();
			var dic:Dictionary = _spriteSheet.imageDic;
			var pieceDic:Dictionary = dic[_spriteSheet.currentTextField.text];
			
//			var tempSpr:Sprite = new Sprite();
//			tempSpr.width = 400;
//			tempSpr.height = 400;
//			tempSpr.alignPivot("center", "center");
//			
//			tempSpr.x = 600;
//			tempSpr.y = 150;
			
			trace(pieceDic);
			var temp:int;
			var count:int;
			for(var key:String in pieceDic)
			{
				count++;
				//tempSpr.addChild(pieceDic[key].image);
				trace(pieceDic[key].name);
				
				var textField:TextField = new TextField(200,24, pieceDic[key].name); 
				textField.y = temp;
				
				textField.border = true;
				textField.name = pieceDic[key].name;
				_spriteVector.push(textField);
				
				_imageMode.listSpr.addChild(textField);
				
				if(count < 5)
				{
					temp += 24;
					//마지막에 5장 미만의 갯수가 남아있을때를 처리해줘야함
				}
				else
				{
					_listSpr.push(_imageMode.listSpr);
					_imageMode.listSpr.dispose();
					count = 0;
					temp = 0;
					//_imageMode.listSpr.r
					
				}
				
				
					
					
			}
			_imageMode.listSpr.addEventListener(TouchEvent.TOUCH, onSelectSpriteList);
			//_spriteSheet.addChild(tempSpr);
			
			//trace(_imageMode.pieceImage);
			_imageMode.spriteSheetList.push();
			
		}
		
		private function onSelectSpriteList(event:TouchEvent):void
		{
			for(var i:int = 0; i<_spriteVector.length; ++i)
			{
				var touch:Touch = event.getTouch(_spriteVector[i], TouchPhase.ENDED);
				if(touch)
				{
					
					trace(touch.target.name);
					_imageMode.pieceImage.texture = _spriteSheet.pieceImageDic[touch.target.name].image.texture;
					_imageMode.pieceImage.width = _spriteSheet.pieceImageDic[touch.target.name].rect.width;
					_imageMode.pieceImage.height = _spriteSheet.pieceImageDic[touch.target.name].rect.height;
					//_imageMode.pieceImage.pivotX = _imageMode.pieceImage.width / 2;
					//_imageMode.pieceImage.pivotY = _imageMode.pieceImage.height / 2;
					_imageMode.pieceImage.alignPivot("center", "center");
					_imageMode.pieceImage.x = 600;
					_imageMode.pieceImage.y = 250;
					//trace(_spriteSheet.pieceImageDic[touch.target.name].image);
					//_imageMode.pieceImage.visible = true;
					
					_imageMode.listSpr.visible = false;
					
					trace(_animationMode.bounds);
					trace(_imageMode.bounds);
					trace(_spriteSheet.bounds);
				}
			}
		}
		
		private function onArrowUp():void
		{
			trace("UP");
			trace(_imageMode.currentPage);
			for(var i:int = 0; i<_listSpr.length; ++i)
			{
				_listSpr[i].visible = false;
				if(_imageMode.currentPage == i)
				{
					_listSpr[i].visible = true;
				}
			}
		}
		
		private function onArrowDown():void
		{
			trace("DOWN");
			trace(_imageMode.currentPage);
			for(var i:int = 0; i<_listSpr.length; ++i)
			{
				_listSpr[i].visible = false;
				if(_imageMode.currentPage == i)
				{
					_listSpr[i].visible = true;
				}
			}
		}
	}
}