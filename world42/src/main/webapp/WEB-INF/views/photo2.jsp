<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>42World - 사이월드</title>
<link rel="stylesheet" href="resources/css/main.css">
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;400;500&display=swap"
	rel="stylesheet">
	<script src="https://kit.fontawesome.com/57a2eb66e4.js"></script>
<script type="text/javascript" src="resources/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
function showQty(qty){
	$('#bgmQ').html(qty.bgmSize)
	$('#acornQ').html(qty.macorn)
	$('#m1chonQ').html(qty.m1chonSize)
}
//09.25 추가
//bgm개수, 일촌수, 도토리 개수 가져오는 함수
function readQty(){
	$.ajax({
		url : "main.readQty",
		type : "GET",
		data : {
			memid : '${sessionId}'
		},
		error : function(){
			console.log('우상단 불러오지 못함')
		},
		success : function(qty){
			showQty(qty)
		}
	})
}
$(function() {
	// 09.25 추가
	// 우상단 bgm개수, 도토리수, 일촌수 가져오기
	readQty()
	
	$('#files_send').click(function() {
		picmepicmeuppick()
		
	})
	
})

function picmepicmeuppick(){
	var form = $('#ajaxform')[0]
	var formData = new FormData(form)
	formData.append('memid', '${sessionId}')
	$.ajax({
		url : "photo3.do",
		type : "POST",
		enctype : "multipart/form-data",
		data : formData,
		processData : false,
		contentType : false,
		error : function(){
			console.log('이미지 업로드 실패')
		},
		success : function(){
			location.href='list.do?memid=${sessionId}'
			//console.log('이미지 업로드 성공')
		}
	})
}

</script>

</head>
<body id="body">
<!-- 우측 상단 div (bgm/도토리/검색) -->
	<div id="mainTop">
	
		<!-- bgm 관련 -->
		<!-- 화이팅 -->
		<div id="bgmDiv">
			<MARQUEE id="mp3Info" style="padding-top: 10px;">1.Y (Please Tell Me Why) - 프리스타일</MARQUEE>
			<audio id="mp3" style="width:250px; height:60px;" autoplay="autoplay" controls="controls" src="resources/mp3/1.mp3"></audio>
		</div>

		<!-- 09.25 수정 -->
		<!-- BGM / 도토리 / 일촌 수 테이블 -->
		<div id="qtyDiv">
			<table id="qtyTable">
				<tr>
					<td><i class="fas fa-music"></i>&nbsp;BGM</td>
					<td id="bgmQ"></td>
					<td><button class="qtyBtn">구매</button></td>
				</tr>
				<tr>
					<td><i class="fas fa-coins"></i>&nbsp;도토리</td>
					<td id="acornQ"></td>
					<td><button class="qtyBtn">충전</button></td>
				</tr>
				<tr>
					<td><i class="fas fa-user-friends"></i>&nbsp;일촌</td>
					<td id="m1chonQ"></td>
				</tr>
			</table>
		</div>

		<!-- 검색창 -->
		<div id="searchDiv">
			<i class="fas fa-search" style="position: absolute; left: 15px; bottom: 17px;"></i> 
			<input id="searchInput" placeholder="이름으로 친구 찾기" autocomplete="off"> 
		</div>
		<div id="searchResult" class="hide">검색 결과가 없습니다.</div>
	</div>
	<!-- 우측 상단 div 끝 -->




	<!-- 우측 버튼들 -->
	<div id="topButtons">
		<a href="main.home?memid=${sessionId}"><button id="topBtn1">내
				미니홈피로</button></a><br>
		<a href="ucor.on?memid=${sessionId}"><button id="topBtn2">회원정보 수정</button></a>
		<a href="main.logout"><button id="topBtn3">로그아웃</button></a>
	</div>
	<div id="frame">
		<!-- 우측 메뉴바 -->
		<div id="mainMenu">
			<div class="menuOff">
				<a href="main.home?memid=${main.memid}">홈</a>
			</div>
			<div class="menuOff">
				<a href="diaryMainView?memid=${main.memid}">다이어리</a>
			</div>
			<div class="menuOn">
				<a href="main.photo?memid=${main.memid}">사진첩</a>
			</div>
			<div class="menuOff">
				<a href="ug.re?memid=${main.memid}">방명록</a>
			</div>
			<div class="menuOff">
				<a href="main.shop?memid=${sessionId}">쇼핑</a>
			</div>
		</div>

		<!-- today / total 카운트 -->
		<div id="visitCount">
			<font color="grey">TODAY</font> <font color="red">${main.mToday}</font>
			<font color="grey">TOTAL</font> ${main.mTotal}
		</div>

		<!-- 미니홈피 타이틀 -->
		<div id="mainTitle">${main.mTitle}</div>

		<!-- 좌측 페이지 -->
		<div id="mainLeft">
			<table>
				<tr>
					<td><a href="list.do?memid=${sessionId}"><button>전체 사진보기</button></a></td>
				</tr>
			</table>
		</div>

		<!-- 우측 페이지 -->
		<div id="mainRight" align="center">
			
			<form id="ajaxform" enctype = "multipart/form-data">
				<input type="file" name="file" accept=".gif, .jpg, .png">
		
				<br> 
				<span> 
				<input id="phtitle" name="phtitle" type="text" style="width: 540px" placeholder="제목"><br> <br> 
				 <textarea id="phcontent" name="phcontent" rows="27" cols="70" placeholder="내용"></textarea><br>

				</span>
				<input type="button" value="작성하기" id="files_send">
				
			</form> 

		</div>
	</div>

</body>
</html>