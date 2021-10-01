<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>42World - 사이월드</title>
<link rel="stylesheet" href="resources/css/diary.css">
<link rel="stylesheet" href="resources/css/main.css">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;400;500&display=swap" rel="stylesheet">
<script src="https://kit.fontawesome.com/57a2eb66e4.js"></script>
<script type="text/javascript">

function resultBookTitle() {
	var result = confirm("다이어리북 이름을 바꾸시겠습니까?");
	if(result){
		alert("다이어리 이름이 바뀌었습니다.");
		document.getElementById('diaryBookTitleUpdate').submit();
	}
}

function resultTerminate() {
	var result = confirm("다이어리북을 삭제시겠습니까?");
	if(result){
		var resultBookTitle = prompt("삭제할 다이어리북 타이틀 이름을 입력해주세요.");
		if(resultBookTitle=="${diarybookone.title}"){
			location.href = "diaryBookTerminateAction?memid=${sessionId}&bookid=${diarybookone.id}";
		}else{
			alert("삭제할 다이어리 북 이름이 맞지 않습니다.");
			resultTerminate();
		}
	}
}

//09.25 추가
//readQty()에서 가져온 개수들 html 출력
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
})
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
			<div class="menuOn">
				<a href="diaryMainView?memid=${main.memid}">다이어리</a>
			</div>
			<div class="menuOff">
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
				<font color="grey">TODAY</font>
				<font color="red">${main.mToday}</font> 
				ㅣ <font color="grey">TOTAL</font> ${main.mTotal}
			</div>
			
		<!-- 미니홈피 타이틀 -->
		<div id="mainTitle">${main.mTitle}</div>
		
		<!-- 좌측 페이지 -->
		<div id="mainLeft">
			<c:forEach var="list" items="${diarybook}">
				<a href="diaryPageView?memid=${sessionId}&bookid=${list.id}">${list.title}</a><br>
			</c:forEach>
		</div>
		
		<!-- 우측 페이지 -->
		<div id="mainRight">
			<form id="diaryBookTitleUpdate" action="diaryBookTitleUpdateAction">
			다이어리 북 타이틀:<br>
			<input id="bookTitle" type=text name="title" value="${diarybookone.title}"><br>
			<button type=button onclick="resultBookTitle()">다이어리 북 이름 설정</button>
			<input type=hidden name="mem_id" value="${sessionId}"><br>
			<input type=hidden name="book_id" value="<%=request.getParameter("bookid")%>"><br>
			</form>
			
			<button onclick="resultTerminate()">다이어리 북 삭제</button>
			<br>
			
			
		</div>
	</div>
</body>
</html>