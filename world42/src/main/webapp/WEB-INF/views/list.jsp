<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
		listpreply();
	})

	function btn2() {
		phcomment = $("#com").val()
		memid = $("#memid").val()
		phid = $("#phid").val()

		$.ajax({
			url : "pinsert.do",
			type : "POST",
			data : {
				memid : memid,
				phcomment : phcomment,
				phid : phid
			},
			success : function() {
				console.log('불러옴')
				listpreply();
				$("#com").val('')
			},
			error : function() {
				console.log('안불러옴')
			}
		})
		
	}
	
	function listpreply() {
		$.ajax({
			url : "plist.do",
			type : "GET",
			data : {
				phid : $('#phid').val()

			},
			success : function(list) {
				$('#preplylist').html(list)
			},
			error : function() {
				console.log('안불러옴')
			}
		})
	}
	
</script>

<style>
#im {
	width: 60%;
}
</style>

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
					<td><a href="list.do?memid=${sessionId}"><button>전체
								사진보기</button></a></td>
				</tr>
				<tr>
					<td><a href="photo2.do?memid=${sessionId}"><button>사진
								올리기</button></a> <br></td>
				</tr>
			</table>

		</div>

		<!-- 우측 페이지 -->
		<div id="mainRight" align="center">
			<br>

			<c:forEach items="${list}" var="dto">

				<hr>
				<div align="center">${dto.phtitle}</div>
				<div align="center">${dto.phday}</div>
				<hr>
				<br>
				<div align="center">
					<img id="im" src="resources/upload/file/${dto.phphoto}">
				</div>
				<br>
				<div align="center">${dto.phcontent}</div>
				<hr>
					<table>
						<tr>
							<td>
								<div id="preplylist"></div>
								<a href="del2.do?phid=${dto.phid}&memid=${sessionId}">
									<button>삭제</button>
								</a>
							</td>
						</tr>
					</table>
								
				<input type="hidden" id="phid" value="${dto.phid}">
					댓글 <input id="com" name="com" type="text" style="width: 500px">
				<button id="b1" onclick="btn2()">확인</button>

				<input type="hidden" value=a id="memid" name="memid">

				<div align="right">
					<table>
						<tr>
							<td><a href="up.do?phid=${dto.phid}&memid=${sessionId}">
									<button>수정</button>
							</a></td>

							<td><a href="del.do?phid=${dto.phid}&memid=${sessionId}">
									<button>삭제</button>
							</a></td>
						</tr>
					</table>
				</div>

				<br>
				<br>

			</c:forEach>

		</div>

	</div>
</body>
</html>