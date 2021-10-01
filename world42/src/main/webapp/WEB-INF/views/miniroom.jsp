<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- css -->
<link rel="stylesheet" href="resources/css/main.css">
<!-- 폰트 외부 링크 -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
<!-- jquery 라이브러리 -->
<script type="text/javascript" src="resources/js/jquery-3.6.0.js"></script>
<!-- 카카오맵 api -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=900622db6a1b86328452062916477a82"></script>
<style type="text/css">
#mapSwitch {
	padding-top: 5px;
}

#mapEditOn {
	width: 100%;
	height: 30px;
	border: 1px solid grey;
	border-radius: 5px;
	background: white;
	color: grey;
	font-size: 15px;
	font-weight: 700;
}

#mapEdit table {
	width: 100%;
	border-collapse: collapse;
}

#mapEdit td {
	vertical-align: middle;
	padding-top: 5px;
	padding-bottom: 5px;
}

#roomTable td {
	border-bottom: 1px solid #babec0;
}

#roomTable img {
	vertical-align: middle;
}

#roomTable td:first-child {
	width: 150px;
	font-weight: 700;
	font-size: 13px;
}

#mapEdit table td:nth-child(2){
	font-size: 13px;
}

#mapEdit table td:nth-child(3) {
	width: 70px;
	text-align: right;
}

#Bubble {
	width: 100%;
	font-size: 15px;
	border: 1px solid #babec0;
	border-radius: 5px;
	padding: 5px;
}

.btn {
	border: 1px solid grey;
	border-radius: 5px;
	background: white;
	color: grey;
	font-size: 15px;
	font-weight: 700;
}

.btn2 {
	border: none;
	background: white;
	color: grey;
	font-size: 15px;
	font-weight: 700;
}

.btn3 {
	color: white;
	background: #FF8B2D;
	border: none;
	border-radius: 5px;
	padding: 5px 10px 5px 10px;
	font-size: 13px;
	font-weight: 700;
}

</style>
<script type="text/javascript">
var map, marker, imageSrc, imageSize, imageOption, markerImage, infoWindow, con1, con2;

// 미니미, 미니룸 이미지(소스)명
var src = {
	'roomImg' : ['room1.png', 'room2.png', 'room3.png', 'room4.png', 'room5.png'],
	'miniImg' : ['minimi1.png', 'minimi2.png', 'minimi3.png', 'minimi4.png']
}

// 미니룸 저장하는 ajax (미니룸 편집 후 저장하면 호출)
function saveRoom(){
	if (confirm('미니룸 변경사항을 저장하시겠습니까?')){
		$.ajax({
			url : "mini.update",
			type : "POST",
			data : {
				mIdx : '${main.mIdx}',
				roomOpt : $('#roomOpt').val(),
				miniOpt : $('#miniOpt').val(),
				minimiX : $('#x').val(),
				minimiY : $('#y').val(),
				ifBubble : $('#ifBubble').val(),
				bubble : $('#Bubble').val()
			},
			error : function(){
				console.log('미니룸 저장하지 못함')
			},
			success : function(){
				editOff();
			}
		})
	}
}

// 미니룸 불러오는 ajax (페이지 로딩시, 미니룸 편집 후 저장하면 호출)
function readRoom(){
	$.ajax({
		url : "mini.read",
		type : "GET",
		data : {
			mIdx : '${main.mIdx}'
		},
		error : function(){
			console.log('미니룸 불러오지 못함')
		},
		success : function(roomData){
			console.log('미니룸 불러오기 성공')
			showRoom(roomData)
		}
	})
}

// 미니룸 편집 버튼 누르면 호출되는 함수
// 편집창의 'hide' 클래스가 사라지고, 마커가 드래그 가능해진다.
function editOn(){
	$('#mapEdit').removeClass('hide')
	$('#mapEditOff').removeClass('hide')
	$('#mapEditSave').removeClass('hide')
	$('#mapEditOn').addClass('hide')
	marker.setDraggable(true);
}

// 미니룸 편집창에서 취소 버튼을 누르면 호출되는 함수
// 편집창에 'hide' 클래스가 추가되고, 마커가 드래그 불가능해진다.
function editOff(){
	$('#mapEdit').addClass('hide')
	$('#mapEditOff').addClass('hide')
	$('#mapEditSave').addClass('hide')
	$('#mapEditOn').removeClass('hide')
	marker.setDraggable(false);
	readRoom()
}

// 미니룸 띄우는 함수
function showRoom(roomData){
	var node = document.getElementById('map');
	
	// ajax로 받은 미니룸 데이터 각 변수에 대입
	var roomOpt = roomData.roomOpt
	var miniOpt = roomData.miniOpt
	var minimiX = roomData.minimiX
	var minimiY = roomData.minimiY
	var ifBubble = roomData.ifBubble
	var bubble = roomData.bubble
	
	//지도 이미지 소스
	var plan = function() {
		return 'resources/img/miniroom/' + src['roomImg'][roomOpt];
	};
	
	//지도 이미지 크기
	kakao.maps.Tileset.add('PLAN', new kakao.maps.Tileset(730, 300, plan, '', false, 0, 2));
	
	//지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
	map = new kakao.maps.Map(node, {
		projectionId : null,
		mapTypeId : kakao.maps.MapTypeId.PLAN,
		$scale : false,
		draggable : false,
		// 지도 중앙 좌표
		center : new kakao.maps.Coords(1500, 600),
		disableDoubleClickZoom : true,
		tileAnimation : false,
		level : 2
	});
	
	// 지도의 마우스 휠, 모바일 터치를 이용한 확대, 축소 기능을 막는다.
	map.setZoomable(false);
	
	// 마커이미지의 주소입니다  
	imageSrc = 'resources/img/miniroom/' + src['miniImg'][miniOpt]
	// 마커이미지의 크기입니다
	imageSize = new kakao.maps.Size(40, 90),
	// 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
	imageOption = {
		offset : new kakao.maps.Point(27, 69)
	};
	
	// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
	markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption)
	
	// 마커를 생성합니다
	marker = new kakao.maps.Marker({
		// 마커 좌표
		position : new kakao.maps.Coords(minimiX, minimiY),
		// 클릭 금지
		clickable : false,
		// 마커 이미지 설정
		image : markerImage
	});
	
	// 마커가 지도 위에 표시되도록 설정합니다
	marker.setMap(map);
	
	// 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
	con1 = '<div style="padding: 10px; width: 130px; text-align: center; user-select:none">'
	con2 = '</div>'
	var iwContent = con1 + bubble + con2;
	// 인포윈도우를 생성합니다
	infowindow = new kakao.maps.InfoWindow({
		content : iwContent
	});
	
	// 말풍선 띄우기
	showBubble(ifBubble);
	
	// 마커에 dragend 이벤트를 등록합니다
	kakao.maps.event.addListener(marker, 'dragend', function() {
		whereMarker();
		var miniX = marker.getPosition().toCoords().getX()
		var miniY = marker.getPosition().toCoords().getY()
		infowindow.setPosition(new kakao.maps.Coords(miniX - 30, miniY + 300));
		showBubble();
	});
	
	// 마커 좌표 찾아오는 함수
	function whereMarker() {
		// x좌표 : 마커.위치.좌표로 반환.x좌표만.스트링형변환.'.'으로 split[0번째 요소]
		var axisX = marker.getPosition().toCoords().getX().toString().split('.')[0];
		var axisY = marker.getPosition().toCoords().getY().toString().split('.')[0];
		$('#x').val(axisX);
		$('#y').val(axisY);
	}
	
	// 마커가 원래 자리로 이동하는 함수
	$('#miniBack').click(function(){
		marker.setPosition(new kakao.maps.Coords(minimiX, minimiY));
		marker.setMap(map);
		var miniX = marker.getPosition().toCoords().getX()
		var miniY = marker.getPosition().toCoords().getY()
		infowindow.setPosition(new kakao.maps.Coords(miniX - 30, miniY + 300));
		showBubble();
		whereMarker();
	})
		
	// 미니룸 변경 후 저장 버튼 클릭시 ajax로 전송할 값 input에 넣어놓기
	$('#roomOpt').val(roomOpt)
	$('#miniOpt').val(miniOpt)
	$('#x').val(minimiX)
	$('#y').val(minimiY)
	$('#ifBubble').val(ifBubble)
	if (ifBubble == 1) {
		$('#addBubble').addClass('hide')
	} else {
		$('#rmvBubble').addClass('hide')
	}
	$('#Bubble').val(bubble)
	
	// 미니룸, 미니미 미리보기 사진 경로
	$('#roomI').attr("src", 'resources/img/miniroom/' + src['roomImg'][roomOpt])
	$('#miniI').attr("src", 'resources/img/miniroom/' + src['miniImg'][miniOpt])
}

function changeRoom(n){
	$('#roomI').attr("src", 'resources/img/miniroom/' + src['roomImg'][n])
	plan = function() {return 'resources/img/miniroom/' + src['roomImg'][n]};
	kakao.maps.Tileset.add('PLAN', new kakao.maps.Tileset(730, 300, plan, '', false, 0, 2));
	map.setMapTypeId(kakao.maps.MapTypeId.PLAN);
}

function changeMini(n){
	$('#miniI').attr("src", 'resources/img/miniroom/' + src['miniImg'][n])
	// 마커이미지의 주소입니다
	imageSrc = 'resources/img/miniroom/' + src['miniImg'][n]
	// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
	markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption)
	marker.setImage(markerImage);
	marker.setMap(map);
}

// ifBubble 변수가 1이면 말풍선이 생기고, ifBubble이 0이면 말풍선이 사라진다
function showBubble(n) {
	if (n == 1) {
		var miniX = marker.getPosition().toCoords().getX()
		var miniY = marker.getPosition().toCoords().getY()
		infowindow.setPosition(new kakao.maps.Coords(miniX - 30, miniY + 300));
		// 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
		infowindow.open(map);
	}
}

$(function(){
	readRoom()
	
	// 미니룸 변경 - 왼쪽 버튼 클릭시
	$('#roomL').click(function(){
		// roomOpt(roomImg 배열의 인덱스) 임시값
		var tempOpt = parseInt($('#roomOpt').val()) - 1
		tempOpt = (tempOpt < 0) ? 4 : tempOpt;
		$('#roomOpt').val(tempOpt)
		changeRoom(tempOpt);
		marker.setMap(map);
	})
	
	// 미니룸 변경 - 오른쪽 버튼 클릭시
	$('#roomR').click(function(){
		// roomOpt(roomImg 배열의 인덱스) 임시값
		var tempOpt = parseInt($('#roomOpt').val()) + 1
		tempOpt = (tempOpt > 4) ? 0 : tempOpt;
		$('#roomOpt').val(tempOpt)
		changeRoom(tempOpt);
		marker.setMap(map);
	})

	// 미니미 변경 - 왼쪽 버튼 클릭시
	$('#miniL').click(function(){
		// miniOpt(miniImg 배열의 인덱스) 임시값
		var tempOpt = parseInt($('#miniOpt').val()) - 1
		tempOpt = (tempOpt < 0) ? 3 : tempOpt;
		$('#miniOpt').val(tempOpt);
		changeMini(tempOpt);
	})
	
	// 미니미 변경 - 오른쪽 버튼 클릭시
	$('#miniR').click(function(){
		// miniOpt(miniImg 배열의 인덱스) 임시값
		var tempOpt = parseInt($('#miniOpt').val()) + 1
		tempOpt = (tempOpt > 3) ? 0 : tempOpt;
		$('#miniOpt').val(tempOpt);
		changeMini(tempOpt);
	})

	// 말풍선 추가 버튼을 누르면 값을 1로 바꾼 후 showBubble() 함수 호출
	$('#addBubble').click(function(){
		$('#ifBubble').val('1')
		$('#addBubble').addClass('hide')
		$('#rmvBubble').removeClass('hide')
		showBubble(1);
	})
	
	// 말풍선 제거 버튼을 누르면 값을 0으로 바꾼 후 말풍선 닫기 함수 호출
	$('#rmvBubble').click(function(){
		$('#ifBubble').val('0')
		$('#rmvBubble').addClass('hide')
		$('#addBubble').removeClass('hide')
		infowindow.close();
	})
	
	// 말풍선 input에 입력 하면 실시간으로 infowindow의 content를 바꾼 후 말풍선 호출
	$('#Bubble').on("keyup", function(){
		bubbleCon = $('#Bubble').val()
		infowindow.setContent(con1 + bubbleCon + con2);
		showBubble();
	})
})

</script>
</head>
<body>
<!-- jstl에 사용할 변수 선언 -->
<c:set var="memid" value="${main.memid}"/>
<c:set var="sessionId" value="${sessionId}"/>

<div class="cmntTitle">Miniroom</div>

<!-- 지도를 표시할 div 입니다 -->
<div id="map" style="width: 710px; height: 300px;"></div>

<!-- 미니룸 편집창 여닫기 버튼 -->
<c:if test="${memid eq sessionId}">
	<div id="mapSwitch">
		<button id="mapEditOn" onclick="editOn()"><i class="fas fa-cog"></i> 미니룸 꾸미기</button>
	</div>
</c:if>

<!-- 미니룸 편집창 -->
<div id="mapEdit" class="hide">
<div class="cmntTitle">
	<table>
		<tr>
			<td>Miniroom 꾸미기</td>
			<td style="text-align: right;">
				<button id="mapEditOff" class="hide btn2" onclick="editOff()"><i class="fas fa-undo-alt"></i></button>
				<button id="mapEditSave" class="hide btn3" onclick="saveRoom()">변경사항 저장</button>
			</td>
		</tr>
	</table>
</div>
<table id="roomTable">
	<tr>
		<td>미니미 위치 변경</td>
		<td>미니미를 원하는 위치로 드래그해주세요.</td>
		<td><button id="miniBack" class="btn">원위치로</button></td>
	</tr>
	<tr>
		<td>미니룸 선택</td>
		<td colspan=2>
			<button id="roomL" class="btn2">◀</button>
			<img id="roomI" style="height: 100px">
			<button id="roomR"class="btn2">▶</button>
		</td>
	</tr>
	<tr>
		<td>미니미 선택</td>
		<td colspan=2>
			<button id="miniL"class="btn2">◀</button>
			<img id ="miniI" style="height: 60px">
			<button id="miniR"class="btn2">▶</button>
		</td>
	</tr>
	<tr>
		<td>말풍선</td>
		<td><input id="Bubble"></td>
		<td>		
			<button id="addBubble" class="btn">보이기</button> 
			<button id="rmvBubble" class="btn">숨기기</button>
		</td>
	</tr>
</table>
<p style="color: red; text-align: right; font-size: 13px; line-height: 0">
	※ 주의 : 저장 버튼을 누르지 않으면 새로운 변경사항이 미니룸에 반영되지 않습니다.
</p>
<input id="x" type="hidden">
<input id="y" type="hidden">
<input id="roomOpt" type="hidden">
<input id="miniOpt" type="hidden">
<input id="ifBubble" type="hidden"> 
</div>
</body>
</html>