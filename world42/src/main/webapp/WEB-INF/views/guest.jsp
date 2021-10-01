<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- 줄바꿈 -->
<% pageContext.setAttribute("replaceChar", "\n"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>42World 사이월드 - ${main.mName}님의 미니홈피</title>

<!-- css -->
<link rel="stylesheet" href="resources/css/main.css">
<link rel="stylesheet" href="resources/css/guest.css">
<!-- 폰트 외부 링크 -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
<!-- 아이콘 외부 링크 -->
<script src="https://kit.fontawesome.com/57a2eb66e4.js"></script>
<!-- jquery 라이브러리 -->
<script type="text/javascript" src="resources/js/jquery-3.6.0.js"></script>
<!-- 카카오맵 api -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=900622db6a1b86328452062916477a82"></script>
<script type="text/javascript">
//미니미, 미니룸 이미지(소스)명
var src = {
	'roomImg' : ['room1.png', 'room2.png', 'room3.png', 'room4.png', 'room5.png'],
	'miniImg' : ['minimi1.png', 'minimi2.png', 'minimi3.png', 'minimi4.png']
}
//미니룸 불러오는 ajax
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
			showImg(roomData)
		}
	})
}
//미니룸 띄우는 함수
function showImg(roomData){
	var miniOpt = roomData.miniOpt;
	$('#guestImg').attr("src", 'resources/img/miniroom/' + src['miniImg'][miniOpt]);
}
// 일촌 목록 가져오는 ajax 함수(일촌 관리 후 저장하면 호출)
function read1chon(){
	$.ajax({
		url : "main.read1chon",
		type : "GET",
		data : {
			memid : '${main.memid}'
		},
		error : function(){
			console.log('일촌목록 불러오지 못함')
		},
		success : function(list){
			console.log('일촌목록 불러오기 성공')
			select1chon(list)
		}
	})
}

// 상대방과 일촌인지 확인하는 ajax 함수
function if1chon(){
	$.ajax({
		url : "main.if1chon",
		type : "GET",
		data : {
			sessionId : '${sessionId}',
			memid : '${main.memid}'
		},
		error : function(){
			console.log('일촌인지 확인 불가능')
		},
		success : function(bool){
			console.log('일촌인지 확인 성공')
			console.log(bool)
			if1chonShow(bool)
			if1chonCmnt(bool)
		}
	})
}

// 일촌 맺기, 끊기 버튼 활성화
function if1chonShow(bool){
	result = ""
	if ('${main.memid}' == '${sessionId}') {
		result += "<button id='m1B3'>일촌 관리</button>"
	} else {
		if (bool){
			result += "<button id='m1B2' onclick='rmv1chon()'>일촌 끊기</button>"
		} else {
			result += "<button id='m1B1' onclick='add1chon()'>일촌 맺기</button>"
		}
	}
	$('#m1chon').html(result)
}

// 일촌 맺기 ajax 함수
function add1chon(){
	$.ajax({
		url : "main.add1chon",
		type : "POST",
		data : {
			sessionId : '${sessionId}',
			memid : '${main.memid}'
		},
		error : function(){
			console.log('일촌 맺기 실패')
		},
		success : function(){
			console.log('일촌 맺기 성공')
			if1chon()
		}
	})
}

//일촌 끊기 ajax 함수
function rmv1chon(){
	$.ajax({
		url : "main.rmv1chon",
		type : "POST",
		data : {
			sessionId : '${sessionId}',
			memid : '${main.memid}'
		},
		error : function(){
			console.log('일촌 끊기 실패')
		},
		success : function(){
			console.log('일촌 끊기 성공')
			if1chon()
		}
	})
}

// 일촌 목록 파도타기 select에 출력하는 함수
function select1chon(list){
	var result = ""
	result += "<select id='m1chonSel' onchange='location.href=this.value'>"
	result += "<option selected>일촌 목록</option>"
	result += "<option disabled>---------------------</option>"
	if (list.length == 0){
		result += "<option disabled>아직 일촌이 없습니다</option>"
	} else {
		$.each(list, function(index, item) {
			result += "<option value='main.others?memid=" + item.memid + "'>"	
			result += item.mname
			result += "</option>"
		})
	}
	result += "</select>"
	$('#m1chonSelDiv').html(result)
}

// 메인 타이틀 갖고오는 ajax 함수 (타이틀 수정 후 저장하면 호출)
function readTitle(){
	$.ajax({
		url : "main.readTitle",
		type : "GET",
		data : {
			mIdx : '${main.mIdx}'
		},
		error : function(){
			console.log('타이틀 불러오지 못함')
		},
		success : function(title){
			console.log('타이틀 불러오기 성공')
			showTitle(title.mTitle)
		}
	})
}

// 타이틀 출력 함수
function showTitle(title){
	$('#mainTitle').text(title)
}

// 타이틀 수정 버튼 클릭시 css class(hide) 추가+제거하는 함수
function editTitle(){
	$('#mainTitle').addClass('hide')
	$('#mTitleBtn1').addClass('hide')
	$('#mainTitleEdit').removeClass('hide')
	$('#mTitleBtn2').removeClass('hide')
	$('#mTitleBtn3').removeClass('hide')
}

// 타이틀 수정 - 취소 클릭시 css class(hide) 원래대로 돌리는 함수
function editTitleBack(){
	$('#mainTitle').removeClass('hide')
	$('#mTitleBtn1').removeClass('hide')
	$('#mainTitleEdit').addClass('hide')
	$('#mTitleBtn2').addClass('hide')
	$('#mTitleBtn3').addClass('hide')
}

// 타이틀 수정 - db 업데이트 ajax 함수
function editTitleOk(){
	$.ajax({
		url : "main.updateTitle",
		type : "POST",
		data : {
			mIdx : '${main.mIdx}',
			mTitle : $('#mTitleInput').val()
		},
		error : function(){
			console.log('타이틀 수정 실패')
		},
		success : function(){
			console.log('타이틀 수정 성공')
			readTitle()
			editTitleBack()
		}
	})
}

// 메인 프로필 문구 갖고오는 ajax 함수
function readProfile(){
	$.ajax({
		url : "main.readProfile",
		type : "GET",
		data : {
			mIdx : '${main.mIdx}'
		},
		error : function(){
			console.log('프로필 불러오기 실패')
		}, 
		success : function(profile){
			console.log('프로필 불러오기 성공')
			showProfile(profile);
		}
	})
}

// 프로필 문구 출력 함수
function showProfile(profile){
	var rePro = profile.mPro.replaceAll('\n', '<br>')
	$('#mPro').html(rePro)
}

//메인 사진 갖고오는 ajax 함수
function readPic(){
	$.ajax({
		url : "main.readPic",
		type : "GET",
		data : {
			mIdx : '${main.mIdx}'
		},
		error : function(){
			console.log('사진 불러오기 실패')
		}, 
		success : function(pic){
			console.log('사진 불러오기 성공')
			showPic(pic);
		}
	})
}

// 메인 사진 출력 함수
function showPic(pic){
	var imgTag = "<img src='resources/img/mainImg/upload/" + pic.mImg + "' id='mImg'>"
	$('#mImgDiv').html(imgTag)
}

//프로필 수정 버튼 클릭시 css class(hide) 추가+제거하는 함수
function editProfile(){
	$('#mImgDiv').addClass('hide')
	$('#mPro').addClass('hide')
	$('#mEdit').addClass('hide')
	$('#mImgDivEdit').removeClass('hide')
	$('#mProEdit').removeClass('hide')
	$('#mEditConfirm').removeClass('hide')
}

//프로필 수정 - 취소 클릭시 css class(hide) 원래대로 돌리는 함수
function editProfileBack(){
	$('#mImgDiv').removeClass('hide')
	$('#mPro').removeClass('hide')
	$('#mEdit').removeClass('hide')
	$('#mImgDivEdit').addClass('hide')
	$('#mProEdit').addClass('hide')
	$('#mEditConfirm').addClass('hide')
}

//프로필 수정 - db 업데이트 ajax 함수
function editProfileOk(){
	$.ajax({
		url : "main.updateProfile",
		type : "POST",
		data : {
			mIdx : '${main.mIdx}',
			mPro : $('#mProTextarea').val()
		},
		error : function(){
			console.log('프로필 수정 실패')
		},
		success : function(){
			console.log('프로필 수정 성공')
			readProfile()
			editProfileBack()
		}
	})
}

//메인사진 수정 - db 업데이트 ajax 함수
function editPicOk(){
	var form = $('#fileForm')[0]
	var formData = new FormData(form)
	formData.append('mIdx', '${main.mIdx}')
	$.ajax({
		url : "main.updatePic",
		type : "POST",
		enctype : "multipart/form-data",
		data : formData,
		processData : false,
		contentType : false,
		error : function(){
			console.log('이미지 업로드 실패')
		},
		success : function(){
			console.log('이미지 업로드 성공')
			readPic()
			editProfileBack()
		}
	})
}
//방명록 가지고 오기		
function conread() {

	owner = $("#owner").val() 

	$.ajax({

		url : "guest1.on",
		type : "GET",
		data : {
			owner : owner /* owner 다른 홈피 검색가능 시 합할때 owner로 바꿔 줘야한다.  */
		}, // data
		success : function(list) {
			/* console.log(list) */
			showcon(list);
		}, // success
		error : function() {
			console.log("리스트를 불러오지 못함")

		} // error
	}) // $.ajax
} //function conread()

// 방명록 가지고 와서 보여주기
function showcon(list) {
	var result = "";

	if (list.length == 0) {
		result += "<div id='nolist'>등록된 방명록이 없습니다.<br>방명록을 등록해보요.<div>"

	} else {
			
		$.each(list,function(i, f) {
			
			result += "<br><hr>"
			result += "<div id='total4'>"
			result += "No."+f.no + "&nbsp;"//숫자
			result += f.writer + "&nbsp;" // 작성자
			result += "(" + f.gdate + ")&nbsp;"// 날짜
			result += "<button  class='conde' id='b2' onclick='decon(this)' value='" + f.no + "'>삭제</button><br>"
			result += "</div>"
			result +="<div id='condiv'>"
			result += f.content// 내용
			result += "</div>"
			if (f.comments != null) {
				result +="<div class='total3'>"
				result += "<br><br><br><br><br>"
				result += f.owner + "&nbsp;&nbsp;"// 주인
				result += f.comments+ "&nbsp;&nbsp;" // 댓글
				result += "(" + f.redate + ")&nbsp;&nbsp;"// 날짜
				result += "</div>"
			}else {
				
			result += "<br><br><br><br><br>"	
			result += "<textarea  cols='45' rows='1.8'id='comment'></textarea>"
			result += "<button class='comup' id='bu' onclick='upcom(this)' value='" + f.no +"'>등록</button><br>"
			result += "<div id='d1' style='font-size: 12px'></div>"
			}
		
	
		}) // $.each              

	} // else
	$("#conlist").html(result)

} // function showcon(list)

//방명록 삭제		
function decon(de) {

	$.ajax({

		url : "gu.de",
		type : "POST",
		data : {
			no : de.value 
		}, // data
		success : function(list) {
			console.log("방명록 삭제 성공")
			conread();
		}, // success
		error : function() {
			console.log("방명록 삭제 실패")
		} // error
	}) // $.ajax

} //function

	// 방명록 댓글
	function upcom(up) {
		
		comments = $("#comment").val()
		
	
			// 방명록 댓글 미입력시
			if (comments == "") {
				
				$('#d1').html('<span style = "color:red">댓글 내용을 입력해주세요.</span>')
					$("#comment").val('')
							comments.focus();
				
						} else {
							
							$.ajax({
								url : "com.on",
								type : "POST",
								data : {
									comments : comments,
									no : up.value
								},
								error : function(){
									console.log('댓글등록 실패')
								},
								success : function() {
									conread();
								}
							}) //$.ajax
						} //else
				}	

// 검색창 
function readSearch(){
	var name = $('#searchInput').val()
	$.ajax({
		url : "main.search",
		type : "GET",
		data : {
			mName : name
		},
		error : function(){
			console.log('검색하지 못함')
		},
		success : function(list) {
			showSearch(list)
		}
	})
}

// 검색결과창
function showSearch(list){
	console.log(list)
	var result = ""
	if (list.length == 0) {
		result += "검색 결과가 없습니다."
	} else {
		$.each(list, function(index, item){
			result += "<div class='searchNames'>"
			result += "<a href='main.others?memid=" + item.memid + "'>" + item.mname + "</a>"
			result += "</div>"
		})
	}
	$('#searchResult').html(result)
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
	readRoom();
	$('#b1').click(function() {
		content = $("#content").val()

			// 방명록 미입력시
			if (content == "") {
				$('#d').html('<span style = "color:red">방명록 내용을 입력해주세요.</span>')
					$("#content").val('')
							content.focus();
						} else {
							guest.submit();
						}

					}) // $('#b1')	
	

	conread(); // 방명록 불러오기 + 뿌리기
	// 쿠키 확인 (방문자수 관련)
	console.log(document.cookie);
	
	// 일촌목록 불러오기 + 뿌리기
	read1chon();
	
	// 메인 사진 불러오기 + 뿌리기
	readPic();
	
	// 프로필 불러오기 + 뿌리기
	readProfile();
	
	// 타이틀 불러오기 + 뿌리기
	readTitle();
	
	// 일촌인지 확인
	if1chon()

	// 타이틀 수정 confirm 확인 후 타이틀 수정 + 출력 함수 호출
	$('#mTitleBtn3').click(function(e){
		if (!confirm('미니홈피 타이틀을 수정하시겠습니까?')) {
			e.preventDefault()
		} else {
			editTitleOk()
		}
	})
	
	// 메인 사진 변경 confirm 확인 후 프로필 수정 + 출력 함수 호출
	$('#mEditBtn5').click(function(e){
		if (!confirm('미니홈피 메인 사진을 변경하시겠습니까?')) {
			e.preventDefault()
		} else {
			editPicOk()
		}
	})
	
	// 프로필 수정 confirm 확인 후 프로필 수정 + 출력 함수 호출
	$('#mEditBtn2').click(function(e){
		if (!confirm('미니홈피 프로필을 수정하시겠습니까?')) {
			e.preventDefault()
		} else {
			editProfileOk()
		}
	})

	// 검색창 입력 감지
	$('#searchInput').on("keyup", function(){
		$('#searchResult').removeClass('hide');
		if (!$('#searchInput').val() == ''){
			readSearch()
		}
	})
	
	// 검색창 떠나면 검색결과창 가리기
	$(document).mouseup(function (e){
		  var searchResult = $("#searchResult");
		  if(searchResult.has(e.target).length === 0){
		    searchResult.addClass('hide');
		  }
	});
})
</script>
</head>

<body id="body">

<!-- jstl에 사용할 변수 선언 -->
<c:set var="memid" value="${main.memid}"/>
<c:set var="sessionId" value="${sessionId}"/>
<c:set var="sesseion1chon" value="${main.m1chon}"/>

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





	<!-- 좌측 미니홈피 프레임 -->
	<div id="frame">
		<!-- 우측 메뉴바 -->
		<!-- 합칠 때 링크 걸기 (css도) -->
		<!-- 활성화된 메뉴 class를 menuOn -->
		<!-- 비활성화된 메뉴 class를 menuOff -->
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
			<div class="menuOn">
				<a href="ug.re?memid=${main.memid}">방명록</a>
			</div>
			<div class="menuOff">
				<a href="main.shop?memid=${sessionId}">쇼핑</a>
			</div>
		</div>

		<!-- today / total 카운트 -->
		<div id="visitCount">
			TODAY&nbsp;
			<font style="font-weight: 700;" color="red">${main.mToday}</font>
			&nbsp;ㅣ&nbsp;TOTAL&nbsp; 
			<font style="font-weight: 700;" color="black">${main.mTotal}</font>
		</div>

		<!-- 미니홈피 타이틀 -->
		<div id="mainTitle"></div>
		<!--  타이틀 수정할 때 -->
		<div id="mainTitleEdit" class="hide">
			<input id="mTitleInput" value="${main.mTitle }">
		</div>
		<!-- 타이틀 수정 관련 버튼 -->
		<div id="mainTitleBtnDiv">
			<c:if test="${sessionId eq memid }">
				<button id="mTitleBtn1" onclick="editTitle()"><i class="fas fa-cog"></i></button>
			</c:if>
			<button id="mTitleBtn2" class="hide" onclick="editTitleBack()"><i class="fas fa-undo-alt"></i></button>
			<button id="mTitleBtn3" class="hide">저장</button>
		</div>



		<!-- 좌측 페이지 -->
		<div id="mainLeft">
		
			<!-- 프로필 이미지 -->
			<div id="mImgDiv"></div>
			
			<!-- 프로필 이미지 수정할 때 -->
			<div id="mImgDivEdit" class="hide">
				<font style="color: #1897B1; font-weight: 700;">메인사진</font><hr>
				<form id="fileForm" enctype="multipart/form-data">
					<input type="file" name="file" accept=".gif, .jpg, .png"><br>
					<button id="mEditBtn4" type="button" onclick="editProfileBack()"><i class="fas fa-undo-alt"></i></button>
					<button id="mEditBtn5" type="button">사진 변경하기</button>
				</form>
			</div>
			
			<!-- 프로필 문구 -->
			<div id="mPro"></div>
			
			<!-- 프로필 문구 수정할 때 -->
			<div id="mProEdit" class="hide">
				<font style="color: #1897B1; font-weight: 700;">프로필</font><hr>
				<textarea id="mProTextarea">${main.mPro}</textarea>
			</div>
			
			<!-- 프로필 수정 버튼 -->
			<div id="mEdit">
					<c:if test="${memid eq sessionId}">
						<button id="mEditBtn1" onclick="editProfile()"><i class="fas fa-cog"></i> 프로필 변경하기</button>
					</c:if>
			</div>
			
			<!-- 프로필 수정 버튼 확인 -->
			<div id="mEditConfirm" class="hide">
					<button id="mEditBtn3" onclick="editProfileBack()"><i class="fas fa-undo-alt"></i></button>
					<button id="mEditBtn2">프로필 저장</button>
			</div>
			
			
			<!-- 회원 이름 -->
			<div id="mName">${main.mName}
			</div>
			
			<!-- 회원 아이디 -->
			<div id="memid">@${main.memid}</div>
			
			<!-- 일촌 셀렉트 -->
			<div id="m1chonSelDiv"></div>
			
			<!-- 일촌 신청 / 삭제 버튼 -->
			<div id="m1chon"></div>
		</div>
		<!-- 좌측 미니홈피 프레임 끝 -->





	<!-- 방명록 페이지 -->
	<div id="mainRight">
		<div id="conform">
		<hr>
			<form action="guest.cr" name="guest">
				<img id="guestImg" style="height: 120px; width: 60px;">
				<textarea placeholder="내용을 입력해주세요." cols="55" rows="9" name="content"
					id="content"></textarea>
				<div id="d" style="font-size: 12px"></div>
				<input type="button" value="등록" id="b1"><br>
				
				<input type="hidden" value=${sessionId} name="owner" id="owner">
				<input type="hidden" value=dxoxb name="writer"> <!-- 다른 홈피 검색가능 시 합할때 지워 줘야한다. -->
			</form>					
		<hr>
		</div><br>
	<div id="conlist"></div>






		</div>	
		<!-- 우측 미니홈피 프레임 끝 -->

		
		
	</div>
</body>
</html>