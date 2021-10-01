<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>42World - 사이월드</title>
<link rel="stylesheet" href="resources/css/photo.css">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;400;500&display=swap" rel="stylesheet">

</head>
<body id="body">
	<div id="frame">
		<!-- 우측 메뉴바 -->
		<div id="mainMenu">
			<div class="menuOff">
				<a href="main.home?memid=${sessionId}">홈</a>
			</div>
			<div class="menuOff">
				<a href="main.diary?memid=${sessionId}">다이어리</a>
			</div>
			<div class="menuOn">
				<a href="main.photo?memid=${sessionId}">사진첩</a>
			</div>
			<div class="menuOff">
				<a href="main.guest?memid=${sessionId}">방명록</a>
			</div>
			<div class="menuOff">
				<a href="main.shop?memid=${sessionId}">쇼핑</a>
			</div>
		</div>

		<!-- today / total 카운트 -->
		<div id="visitCount">
			<font color="grey">TODAY</font>
			 <font color="red">${main.mToday}</font>
			 <font color="grey">TOTAL</font> ${main.mTotal}
		</div>

		<!-- 미니홈피 타이틀 -->
		<div id="mainTitle">${main.mTitle}</div>

		<!-- 좌측 페이지 -->
		<div id="mainLeft">
		<table>
			<tr>
				<td>
					<a href="list.do?memid=${sessionId}"><button>전체 사진보기</button></a>
				</td>
			</tr>
		</table>
		</div>

		<!-- 우측 페이지 -->
		<div id="mainRight" align="center">
			
			<br>

			<form action="up2.do">
                <input name="memid" type="hidden" value= "${sessionId}">
                <input name="phid" type="hidden" value= "${photoDTO2.phid}">
				<span>
				<input name="phtitle" type="text" style="width: 540px" value="${photoDTO2.phtitle}"><br>
				<br>
				<textarea name="phcontent" rows="27" cols="70" placeholder="내용">${photoDTO2.phcontent}</textarea><br>

				</span>

				<button>수정하기</button>
			</form>

		</div>
	</div>

</body>
</html>