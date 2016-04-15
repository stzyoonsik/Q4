package
{
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.FileListEvent;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.Texture;

	public class SpriteSheet extends Sprite
	{
		private var _loadSpriteSheetsButton:Image;											//애니메이션모드, 이미지모드에서 공유됨. 스프라이트시트를 로드하는 버튼
				
		private var _spr:Sprite = new Sprite();												//스프라이트시트 텍스트필드 를 담는 Sprite
		private var _spriteSheetTextField:TextField;										//현재 선택된 스프라이트시트의 이름을 나타내는 텍스트필드
		private var _spriteSheetList:Vector.<TextField> = new Vector.<TextField>;			//스프라이트시트 텍스트필드를 담는 배열
		private var _selectSpriteSheetButton:Image;											//화살표버튼
		
		
		private var _spriteSheetDic:Dictionary = new Dictionary();							//사용자가 Load SpriteSheets 버튼을 통해 스프라이트시트를 로드하면 이 딕셔너리에 추가됨
		private var _scaledSpriteSheetDic:Dictionary = new Dictionary();					//위와 같지만 이미지 크기를 1/4로 줄인 이미지가 담긴 딕셔너리
		private var _xmlDic:Dictionary = new Dictionary();
		private var _pieceImageInfo:Vector.<ImageData>;
		//public static var _pieceImageArray:Vector.<Image> = new Vector.<Image>;					//조각난 이미지들을 담는 배열
		private var _pieceImageDic:Dictionary;				 								//조각난 이미지들을 담는 딕셔너리
		private var _imageDic:Dictionary = new Dictionary();
		private var _numberOfPNG:int;
		private var _numberOfXML:int;
	
		private var _currentTextField:TextField = new TextField(240, 24, "");				//현재 선택된 스프라이트 시트를 나타내기 위한 텍스트필드
		
		private var _pieceSpr:Sprite = new Sprite();
		
		
		
		public function SpriteSheet()
		{
			addEventListener(TouchEvent.TOUCH, onAddedEvents);	
		}
		
		public function get currentTextField():TextField
		{
			return _currentTextField;
		}

		public function set currentTextField(value:TextField):void
		{
			_currentTextField = value;
		}

		public function get pieceImageDic():Dictionary
		{
			return _pieceImageDic;
		}

		public function set pieceImageDic(value:Dictionary):void
		{
			_pieceImageDic = value;
		}

		public function get imageDic():Dictionary
		{
			return _imageDic;
		}

		public function set imageDic(value:Dictionary):void
		{
			_imageDic = value;
		}

		/**
		 * 
		 * @param guiArray 로드된 이미지들
		 * 초기화 메소드
		 */
		public function init(guiArray:Vector.<Image>):void
		{
			//trace("init");
			for(var i:int = 0; i<guiArray.length; ++i)
			{
				switch(guiArray[i].name)
				{
					case "loadButton":
						_loadSpriteSheetsButton = new Image(guiArray[i].texture);
						_loadSpriteSheetsButton.pivotX = _loadSpriteSheetsButton.width / 2;
						_loadSpriteSheetsButton.pivotY = _loadSpriteSheetsButton.height / 2;
						_loadSpriteSheetsButton.x = 178;
						_loadSpriteSheetsButton.y = 532;
						addChild(_loadSpriteSheetsButton);
						break;
					
					case "selectButton":
						_selectSpriteSheetButton = new Image(guiArray[i].texture);
						_selectSpriteSheetButton.pivotX = _selectSpriteSheetButton.width / 2;
						_selectSpriteSheetButton.pivotY = _selectSpriteSheetButton.height / 2;
						_selectSpriteSheetButton.x = 300;
						_selectSpriteSheetButton.y = 612;
						_selectSpriteSheetButton.visible = false;
						addChild(_selectSpriteSheetButton);						
						break;
				}
			}
			_currentTextField.x = 50;
			_currentTextField.y = 600;
			
			//_pieceSpr.alignPivot("center", "center"); 
			_pieceSpr.x = 500;
			_pieceSpr.y = 300;
			addChild(_currentTextField);
		
		}
		
		private function onAddedEvents(event:starling.events.Event):void
		{		
			_loadSpriteSheetsButton.addEventListener(TouchEvent.TOUCH, onLoadSpriteSheetsButton);	
			_selectSpriteSheetButton.addEventListener(TouchEvent.TOUCH, onSelectSpriteSheetButton);
		}
		
		
		/**
		 * 
		 * @param event 클릭
		 * 화살표 버튼을 클릭하면 드롭다운을 보여주는 이벤트리스너
		 */
		private function onSelectSpriteSheetButton(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(_selectSpriteSheetButton, TouchPhase.ENDED);
			if(touch)
			{
				_spr.visible = true;
				
				
			}
		}
		
		/**
		 * 
		 * @param event 마우스 클릭
		 * 클릭이 발생했을 때 버튼 이미지의 크기를 신축하고, 스프라이트 시트를 가져오는 메소드
		 */
		private function onLoadSpriteSheetsButton(event:TouchEvent):void
		{
			//trace("로드스프라이트시트");
			var touch:Touch = event.getTouch(_loadSpriteSheetsButton, TouchPhase.BEGAN);
			if(touch)
			{
				
				_loadSpriteSheetsButton.scale = 0.8;
			}			
			else
			{
				_loadSpriteSheetsButton.scale = 1;
			}
			
			touch = event.getTouch(_loadSpriteSheetsButton, TouchPhase.ENDED);
			if(touch)
			{
				//trace("로드스프라이트시트버튼");
				//이미지 파일만 여는 예외처리 필요
				var file:File = File.applicationDirectory;
				file.browseForOpenMultiple("Select SpriteSheet Files");
				file.addEventListener(FileListEvent.SELECT_MULTIPLE, onFilesSelected);
			}
		}
		
		/**
		 * 
		 * @param event 선택된 파일(들) 
		 * 선택된 파일들을 로드하는 이벤트리스너
		 */
		private function onFilesSelected(event:FileListEvent):void
		{
			_numberOfXML += event.files.length;
			_numberOfPNG += event.files.length;
			
			for (var i:int = 0; i < event.files.length; ++i) 
			{
				//trace(event.files[i].nativePath);
				//PNG 로드
				var loader:Loader = new Loader();				
				loader.load(new URLRequest(event.files[i].url));				
				loader.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE, onLoaderComplete);				
				loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onLoaderFailed);
				
				
				//XML 로드
				var xmlURL:String = FunctionMgr.replaceExtensionPngToXml(event.files[i].url);
				var urlRequest:URLRequest = new URLRequest(xmlURL);
				var urlLoader:URLLoader = new URLLoader();				
				urlLoader.addEventListener(flash.events.Event.COMPLETE, onXMLLoaderComplete);
				urlLoader.load(urlRequest);
			}
		}
		
		
		/**
		 * 선택한 png와 그 이름과 동일한 xml이 모두 로드됬는지 검사하는 메소드 
		 * 모두 로드됬다면 xml을 읽어서 딕셔너리에 저장함
		 */
		private function completeAll():void
		{
			if(_numberOfPNG == _spriteSheetList.length && _numberOfXML == FunctionMgr.getDictionaryLength(_xmlDic))
			{
				readXML();
				
				
			}
		}

		/**
		 * 
		 * @param event xml 로딩이 끝나는 이벤트
		 * xml파일의 로드가 완료되면 xml을 읽어서 데이터를 저장하는 이벤트리스너
		 */
		private function onXMLLoaderComplete(event:flash.events.Event):void
		{
			
			var xml:XML = new XML(event.currentTarget.data);
			//trace(event.currentTarget.data.name);
			//trace(xml.attribute("ImagePath"));
			
			var name:String = FunctionMgr.removeExtension(xml.attribute("ImagePath"));
			
			//_xmlArray.push(xml);
			_xmlDic[name] = xml;
			
			completeAll();
		}
		
		private function readXML():void
		{
			for(var key:String in _xmlDic)
			{
				//_pieceImageInfo = new Vector.<ImageData>;		//xml에서 읽은 이미지를 조각낼 정보를 담는 배열
				_pieceImageDic = new Dictionary();
				
				for(var i:int = 0; i < _xmlDic[key].child("SubTexture").length(); ++i)
				{
					var imageData:ImageData = new ImageData();
					imageData.name = _xmlDic[key].child("SubTexture")[i].attribute("name");
					imageData.rect.x = _xmlDic[key].child("SubTexture")[i].attribute("x");
					imageData.rect.y = _xmlDic[key].child("SubTexture")[i].attribute("y");
					imageData.rect.width = _xmlDic[key].child("SubTexture")[i].attribute("width");
					imageData.rect.height = _xmlDic[key].child("SubTexture")[i].attribute("height");
					
					 //trace(key);
					//_pieceImageInfo.push(imageData);
					var pieceTexture:Texture = Texture.fromTexture(_spriteSheetDic[key].texture, imageData.rect);
					var pieceImage:Image = new Image(pieceTexture);
					
					imageData.image = pieceImage;
					//pieceImage.visible = false;
					//_pieceImageArray.push(pieceImage);
					_pieceImageDic[imageData.name] = imageData; 
					//_pieceSpr.addChild(pieceImage);
				}
				
				_imageDic[key] = _pieceImageDic;
		
			}
			
			
		}
		
		
		/**
		 * 
		 * @param event 완료
		 * 해당 파일의 로딩이 완료되면, image 로 형변환하여 배열에 저장하고, 보여주기용 배열에 스케일링하여 저장하는 이벤트 리스너
		 */
		private function onLoaderComplete(event:flash.events.Event):void
		{
			
			_selectSpriteSheetButton.visible = true;
			
			var loaderInfo:LoaderInfo = LoaderInfo(event.target);
			var bitmapData:BitmapData = new BitmapData(loaderInfo.width, loaderInfo.height);			
			bitmapData.draw(loaderInfo.loader);
			
			var texture:Texture = Texture.fromBitmapData(bitmapData);			
			var image:Image = new Image(texture);
			
			//이름 따오기
			var name:String = loaderInfo.url;
			var slash:int = name.lastIndexOf("/");
			var dot:int = name.lastIndexOf(".");
			name = name.substring(slash + 1, dot);			
			//image.name = name;			
			
			//원본 스프라이트시트 딕셔너리에 추가
			_spriteSheetDic[name] = image;
			
			//보여주기용 스프라이트시트 세팅
			image.scale = 0.25;
			var scaledSpriteSheet:Image = image;
			
			scaledSpriteSheet.pivotX = scaledSpriteSheet.width / 2;
			scaledSpriteSheet.pivotY = scaledSpriteSheet.height / 2;
			
			scaledSpriteSheet.x = 150;
			scaledSpriteSheet.y = 150;
			scaledSpriteSheet.visible = false;
			
			//딕셔너리에 추가
			_scaledSpriteSheetDic[name] = scaledSpriteSheet;
			
			
			addChild(scaledSpriteSheet);
			
			
			
			setSpriteSheetTextField(name);
			
			
			
			loaderInfo.removeEventListener(flash.events.Event.COMPLETE, onLoaderComplete);
			completeAll();
		}
		
		private function onLoaderFailed(event:flash.events.Event):void
		{
			trace("로드 실패 " + event);			
		}
		
	
		/**
		 * 
		 * @param name 이미지 파일(스프라이트시트.png)의 이름
		 * 텍스트 필드를 세팅하는 메소드
		 */
		private function setSpriteSheetTextField(name:String):void
		{
			_spriteSheetTextField = new TextField(240,24, "");
			
			_spriteSheetTextField.text = name;
			_spriteSheetTextField.name = name;
			_spriteSheetTextField.border = true;
			
			_spriteSheetList.push(_spriteSheetTextField);
			
			if(_numberOfPNG == _spriteSheetList.length)
			{
				for(var i:int = 0; i < _spriteSheetList.length; ++i)
				{					
					_spriteSheetList[i].x = 50;
					_spriteSheetList[i].y = 624 + (i * 24);
					_spr.visible = false;
					_spr.addChild(_spriteSheetList[i]);
					if(i == _spriteSheetList.length - 1)
					{
						_currentTextField.text = _spriteSheetList[i].name;
						_currentTextField.name = _spriteSheetList[i].name;
					
						_scaledSpriteSheetDic[_currentTextField.text].visible = true;
					}
				}
				
				_spr.addEventListener(TouchEvent.TOUCH, onSelectSpriteSheetList);
				addChild(_spr);
				
				
			}
		}
		

		
		/**
		 * 
		 * @param event 클릭
		 * 스프라이트시트 리스트 중 하나를 클릭했을때 발생하는 이벤트 리스너
		 */
		private function onSelectSpriteSheetList(event:TouchEvent):void
		{
			for(var i:int = 0; i<_spriteSheetList.length; ++i)
			{
				var touch:Touch = event.getTouch(_spriteSheetList[i], TouchPhase.ENDED);
				if(touch)
				{
					trace(touch.target.name);
					_currentTextField.text = touch.target.name;
					_spr.visible = false;
					
					//딕셔너리를 순회하여 모든 작은이미지들의 visible을 끄고, 선택된 이미지의 visible만 true로 함
					for(var key:String in _scaledSpriteSheetDic)
					{
						_scaledSpriteSheetDic[key].visible = false;
					}
					_scaledSpriteSheetDic[_currentTextField.text].visible = true;	
					
					dispatchEvent(new Event("selected"));
					
				}
			}			
			
		}
		
		
	}
}