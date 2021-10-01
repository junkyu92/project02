<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>42World - 도토리</title>
<link rel="stylesheet" href="resources/css/main.css">
<link rel="stylesheet" href="resources/css/shop.css">
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;400;500&display=swap"
	rel="stylesheet">
	<!-- 아이콘 외부 링크 -->
<script src="https://kit.fontawesome.com/57a2eb66e4.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">

/* 결제 완료 후 결제 결과출력 */
if("${msg}" != ""){
	alert("${msg}")
}

/* 입력창의 금액에 x의 금액을 더해 출력 */
function cal(x) {
	ownAcorn = Number($('#ownAcorn').text().replace("개", ""))
	in1Val = Number($('#in1').val())
	cost = x
	$('#in1').val(in1Val + cost)
	$('#totalPay').html(in1Val + cost + '원')
	$('#total').html(in1Val + ownAcorn + cost + '개')
} 

/* 보유 bgm list의 첫 곡 재생 */
function a() {
	$('#mp3').html('<source src="resources/mp3/'+src[0]+'.mp3">')
	$('#mp3').play
	<c:forEach items="${list}" var="dto">
		if (src[num] == ${dto.bgmid}){
			$('#mp3Info').text('${dto.bgmid}. ${dto.bgm_title} - ${dto.bgm_artist}')
		}
	</c:forEach>
}

/* 다음 곡 재생, 다음 곡 정보 출력 */
function b() {
    num = (num + 1) % src.length
    $('#mp3').attr("src", "resources/mp3/"+src[num]+".mp3")
    $('#mp3').play
    <c:forEach items="${list}" var="dto">
	if (src[num] == ${dto.bgmid}){
		$('#mp3Info').text('${dto.bgmid}. ${dto.bgm_title} - ${dto.bgm_artist}')
	}
</c:forEach>
}

//readQty()에서 가져온 개수들 html 출력
function showQty(qty){
	$('#bgmQ').html(qty.bgmSize)
	$('#acornQ').html(qty.macorn)
	$('#m1chonQ').html(qty.m1chonSize)
}
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
	// 우상단 bgm개수, 도토리수, 일촌수 가져오기
	readQty()
	
	/* 보유한 bgm 첫 곡 재생, 곡 종료시 다음곡 자동재생 */
	num = 0
	src = []
	<c:forEach items="${bgm_list}" var="bgm_list2">
		src.push("${bgm_list2}")
	</c:forEach>
	a()
	$("#mp3").on("ended", b)
	
	/* 입력창에서 커서가 벗어날 때, 입력된 금액 출력 */
	$('#in1').blur(function() {
		ownAcorn = Number($('#ownAcorn').text().replace("개", ""))
		in1Val = Number($('#in1').val())
		in2Val = Math.floor(in1Val/100)*100;
		if(in2Val < 1000){
			in2Val = 1000
		}
		$('#in1').val(in2Val)
		$('#totalPay').html(in2Val + '원')
		$('#total').html(in2Val + ownAcorn + '개')
	}) 
	
	/* 버튼 클릭시 입력창의 금액에 1,000의 금액을 더해 출력 */
	$('#b1000').click(function() {
		cal(1000)
	})
	
	/* 버튼 클릭시 입력창의 금액에 5,000의 금액을 더해 출력 */
	$('#b5000').click(function() {
		cal(5000)
	})
	
	/* 버튼 클릭시 입력창의 금액에 10,000의 금액을 더해 출력 */
	$('#b10000').click(function() {
		cal(10000)
	})
	
	/* 버튼 클릭시 결제페이지로 이동 */
	$('#bPay').click(function() {
		total = $('#totalPay').text().replace("원", "")
		location.href = 'pay?memid=${sessionId}&paydata=도토리' + total + '개&total=' + Number(total)
	})
	
	/* 버튼 클릭시 선택한 곡 구매 */
	$('#bBgm').click(function() {
			count = 0
			checkBgm = "";
			<c:forEach items="${list}" var="dto">
				if($('#check${dto.bgmid}').is(":checked") == true){
					checkBgm = checkBgm + ${dto.bgmid} + ","
					count++
				}
			</c:forEach>
			if(count == 0){
				alert("구매할 곡을 선택해주세요.")
			}else if (${result} >= 500*count){
				location.href="bgm.add?memid=${sessionId}&bgm_list="+checkBgm
			}else{
				alert("도토리가 부족합니다.")
			}
	})
	
	/* 각 메뉴 클릭시 화면변경 */
	$('#bgmMenu').click(function() {
		$("#bgmPage").css("display", "")
		$("#acornPage").css("display", "none")
		$("#payConfirmPage").css("display", "none")
		$("#bgmListPage").css("display", "none")
		$("#acornMenu").css("font-weight", "")
		$("#bgmMenu").css("font-weight", "bold")
		$("#payConfirmMenu").css("font-weight", "")
		$("#bgmListMenu").css("font-weight", "")
	})
	$('#acornMenu').click(function() {
		$("#acornPage").css("display", "")
		$("#bgmPage").css("display", "none")
		$("#payConfirmPage").css("display", "none")
		$("#bgmListPage").css("display", "none")
		$("#acornMenu").css("font-weight", "bold")
		$("#bgmMenu").css("font-weight", "")
		$("#payConfirmMenu").css("font-weight", "")
		$("#bgmListMenu").css("font-weight", "")
		/* 입력 초기화 */
		$('#in1').val("")
		$('#totalPay').text("0원")
		$('#total').text($('#ownAcorn').text())
	})
	$('#payConfirmMenu').click(function() {
		$("#payConfirmPage").css("display", "")
		$("#bgmPage").css("display", "none")
		$("#acornPage").css("display", "none")
		$("#bgmListPage").css("display", "none")
		$("#acornMenu").css("font-weight", "")
		$("#bgmMenu").css("font-weight", "")
		$("#payConfirmMenu").css("font-weight", "bold")
		$("#bgmListMenu").css("font-weight", "")
	})
	$('#bgmListMenu').click(function() {
		$("#bgmListPage").css("display", "")
		$("#payConfirmPage").css("display", "none")
		$("#bgmPage").css("display", "none")
		$("#acornPage").css("display", "none")
		$("#acornMenu").css("font-weight", "")
		$("#bgmMenu").css("font-weight", "")
		$("#payConfirmMenu").css("font-weight", "")
		$("#bgmListMenu").css("font-weight", "bold")
	})
	$('.qtyBtn').click(function() {
		location.href="main.shop?memid=${sessionId}"
	})
})
</script>
</head>
<body id="body">
	<div id="frame">
		<!-- 우측 메뉴바 -->
		<div id="mainMenu">
			<div class="menuOff">
				<a href="main.home?memid=${main.memid}">홈</a>
			</div>
			<div class="menuOff">
				<a href="diaryMainView?memid=${main.memid}">다이어리</a>
			</div>
			<div class="menuOff">
				<a href="main.photo?memid=${main.memid}">사진첩</a>
			</div>
			<div class="menuOff">
				<a href="ug.re?memid=${main.memid}">방명록</a>
			</div>
			<div class="menuOn">
				<a href="main.shop?memid=${sessionId}">쇼핑</a>
			</div>
		</div>

		<!-- today / total 카운트 -->
		<div id="visitCount">
			<font color="grey">TODAY</font> <font color="red">${main.mToday}</font>
			ㅣ <font color="grey">TOTAL</font> ${main.mTotal}
		</div>

		<!-- 미니홈피 타이틀 -->
		<div id="mainTitle">${main.mTitle}</div>

		<!-- 좌측 페이지 -->
		<div id="mainLeft">
			<button id="acornMenu" style="font-weight: bold">도토리</button><br>
			<button id="bgmMenu">BGM</button><br>
			<button id="payConfirmMenu">결제내역</button><br>
			<button id="bgmListMenu">보유 BGM</button><br>
		</div>

		<!-- 우측 페이지 -->
		<div id="mainRight">
		
			<!-- 도토리 충전 -->
			<div id='acornPage'>
				<h3>도토리 충전</h3><br>
				<div style="display: inline" id='acornPage1'>
					현재 보유 도토리
					<!-- users 테이블의 macorn출력 -->
					<div id='ownAcorn' style="display: inline; float: right;">${result}개</div> 
				</div>
				<br><br> 충전할 도토리 <br> 
				<!-- 충전할 금액 입력칸 -->
				<input id="in1" placeholder="1000이상 100단위"><br>
				<!-- 금액 추가 버튼 --> 
				<button id="b1000">+1,000</button>
				<button id="b5000">+5,000</button>
				<button id="b10000">+10,000</button>
				<div style="display: inline" id='acornPage2'>
					<br><br> 결제하실 금액
					<!-- 결제할 금액 -->
					<div style="display: inline; float: right;" id="totalPay">0원</div>
				</div>
				<div style="display: inline">
					<br><br> 결제 후 내 도토리
					<!-- 결제 후 도토리 -->
					<div style="display: inline; float: right;" id="total">${result}개</div>
				</div>
				<br>
				<div align="center">
					<button id="bPay">충전하기</button>
					<br>
				</div>
			</div>
			
			<!-- 전체 bgm 리스트 -->
			<div style="display: none;" id='bgmPage'>
				<table>
					<tr class='tableTitle'>
						<td class='ownBgmId'>No.</td>
						<td class='table1'>곡명</td>
						<td class='table2'>아티스트</td>
						<td class='ownBgmId'>가격</td>
						<td class='ownBgmId'>구매</td>
					</tr>
					<!-- 전체 bgm list forEach문 -->
					<c:forEach items="${list}" var="dto">
						<tr>
							<td class='ownBgmId' id='${dto.bgmid}'>${dto.bgmid}</td>
							<td class='table1'>${dto.bgm_title}</td>
							<td class='table2'>${dto.bgm_artist}</td>
							<td class='ownBgmId'>500개</td>
							<td class='ownBgmId'><input type="checkbox" id='check${dto.bgmid}'></td>
							<!-- 보유 bgm list forEach문 -->
							<c:forEach items="${bgm_list}" var="bgm_list2">
								<!-- 보유한 bgm이 있을경우 -->
								<c:if test="${dto.bgmid == bgm_list2}">
									<!-- 체크박스 숨기기 -->
									<script>
										$(function() {
											$("#check${dto.bgmid}").css("display", "none")
										})
									</script>
								</c:if>
							</c:forEach>
						</tr>
					</c:forEach>
				</table><br>
				<div align="center">
					<button id='bBgm'>구매하기</button>
				</div>
			</div>

			<!-- 결제내역 --> 
			<div style="display: none;" id='payConfirmPage'>
				<table>
					<tr class='tableTitle'>
						<td class='ownBgmId'>결제ID</td>
						<td>결제정보</td>
						<td>결제시간</td>
						<td>결제금액</td>
					</tr>
					<c:forEach items="${list2}" var="dto">
						<tr>
							<td class='ownBgmId'>${dto.payid}</td>
							<td>${dto.pay_data}</td>
							<td>${dto.pay_datetime}</td>
							<td>${dto.pay_total}</td>
						</tr>
					</c:forEach>
				</table>
			</div>

			<!-- 보유 bgm 리스트 -->
			<div style="display: none;" id='bgmListPage'>
				<table>
					<tr class='tableTitle'>
						<td class='ownBgmId'>No.</td>
						<td>곡명</td>
						<td>아티스트</td>
					</tr>
					<c:forEach items="${bgm_list}" var="bgm_list2">
						<c:forEach items="${list}" var="dto">
							<c:if test="${bgm_list2 == dto.bgmid}">
								<tr>
									<td class='ownBgmId' id='${dto.bgmid}'>${dto.bgmid}</td>
									<td>${dto.bgm_title}</td>
									<td>${dto.bgm_artist}</td>
								</tr>
							</c:if>
						</c:forEach>
					</c:forEach>
				</table>
			</div>
		</div>
		
		<!-- 우측 상단 div (bgm/도토리/검색) -->
	<div id="mainTop">
	
		<!-- bgm 관련 -->
		<div id="bgmDiv">
			<MARQUEE id="mp3Info" style="padding-top: 10px;"></MARQUEE>
			<audio id="mp3" style="width:250px; height:60px;" autoplay="autoplay" controls="controls"></audio>
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
	
	</div>
</body>
</html>