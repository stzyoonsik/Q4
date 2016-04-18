# Q4 구조 및 클래스 설명
![](http://i.imgur.com/zdGoaTA.jpg)

+ SpriteSheet : Load SpriteSheet 버튼을 통해 한장 또는 여러장의 스프라이트시트를 로드하며, 자동으로 같은 이름의 xml파일을 읽어 시트 안에 담긴 이미지들을 조각내어 Dictionary에 담는 클래스
+ AnimationMode : 애니메이션모드에 필요한 버튼들을 가지고 있으며, 선택된 스프라이트시트의 이미지들을 순차적으로 재생, 일시정지, 메모리에서 제거 기능을 가진 클래스
+ ImageMode : 이미지모드에 필요한 버튼들을 가지고 있으며, 선택된 스프라이트시트의 이미지를 각각 드롭다운을 통해 한장 한장 볼 수 있고, 저장할 수 있는 기능을 가진 클래스
+ MainStage : 위 3개의 클래스들의 부모클래스로, 각종 이벤트를 담당하는 클래스
+ Main : 최상위 클래스. 스탈링  
+ 나머지 클래스들 
 + FunctionMgr : 자주 쓰이는 기능들을 한데 담은 클래스
 + GUILoader : 프로그램 최초 실행 시 필요한 UI들의 이미지를 로드하는 클래스
 + ImageData : Image, BitmapData, name, Rectangle을 저장하는 클래스
 + PNGEncoder : 이미지모드에서 현재 선택된 이미지만 따로 저장하기 위한 인코딩 클래스
