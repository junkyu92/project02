<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link rel="stylesheet" href="resources/css/ujoin.css">
		<script type="text/javascript" src="resources/js/jquery-3.6.0.js"></script>
		<script type="text/javascript">
			function check() {
				memid = $("#memid").val()
				
				if(memid.value =="" || memid.length < 0){
					alert("아이디를 먼저 입력해주세요")
					f.memid.focus();
				}else if (memid.length < 5 || memid.length > 13) {
			        alert("아이디를 5~12자까지 입력해주세요.")
			        f.memid.focus();
			        return false;
			        
				}else{
		        
				$.ajax({
					url : "uj1.on",
					type : "GET",
					data : {
						memid : memid
					},
					success : function(result) {
						/* alert('test.jsp 호출 성공') */
						/* alert(result) */
						if(result){
							$('#d').html("사용가능한 아이디 입니다.").css({"color": "green" }) // css
							/* flag = 0 */
						}else{
							
							$('#d').html("사용불가능한 아이디 입니다.").css({"color": "red" }) // css
							/* flag = 1 */	
						}
					}, // success
					error : function() {
						alert('uj1.re 호출 실패')
					} // error
				}) // $.ajax({
				
				}// else
					
			}//function check()
			
		$(function() {
			/* flag = 1 */
			
			$('#b1').click(function() {
				
				check()
				
			}) //$('#b1')
			
			
			$('#b2').click(function() {
				memid = $("#memid").val()
				mempw = $("#mempw").val()
				pw2 = $("#pw2").val()
				mname = $("#mname").val()
				tel = $("#tel").val()
				mbday = $("#mbday").val()
				
				// 아이디 유효성 검사
				// 아이디 미입력
				if (memid == "") {
					$('#d').html('<span style = "color:red">아이디를 입력해주세요.</span>')
					$("#memid").val('')
					memid.focus();
				// 	아이디에 공백이 있는지
				} else if(memid.indexOf(" ") >= 0){
					$('#d').html('<span style = "color:red"> 아이디에 공백을 사용할 수 없습니다.</span>')
					$("#memid").val('')
					memid.focus();
				// 아이디가 5자이상에서 13자 미만
				} else if(memid.length < 4 || memid.length > 13){
					$('#d').html('<span style = "color:red"> 아이디를 5~12자까지 입력해주세요.</span>')
					$("#memid").val('')
					memid.focus();
					
				// 비밀번호 관련
				// 비밀번호 미입력
				} else if(mempw == ""){
					$('#d1').html('<span style = "color:red">비밀번호를 입력해주세요.</span>')
					$("#mempw").val('')
					mempw.focus();
				// 비밀번호 6자이상인지	
				} else if(mempw.length < 6){
					$('#d1').html('<span style = "color:red">비밀번호를 6자이상 입력해주세요.</span>')
					$("#mempw").val('')
					mempw.focus();
				// 비밀번호 입력값이 같은가		
				} else if(mempw != pw2){
					$('#d2').html('<span style = "color:red">비밀번호가 일치하지 않습니다.</span>')
					$("#pw2").val('')
					pw2.focus();
					
				// 이름 유효성 검사
				// 이름 미입력
				} else if(mname == ""){
					$('#d3').html('<span style = "color:red">이름을 입력해주세요.</span>')
					$("mname").val('')
					mname.focus();
					
				// 전화번호 유효성 검사
				// 전화번호 미입력	
				} else if(tel == ""){
					$('#d4').html('<span style = "color:red">전화번호를 입력해주세요.</span>')
					$("tel").val('')
					tel.focus();	
				
				// 생년.월.일 유효성 검사
				// 생년.월.일 미입력
				} else if(mbday == ""){
					$('#d5').html('<span style = "color:red">생년.월.일을 입력해주세요.</span>')
					$("mbday").val('')
					mbday.focus();
				// 생년.월.일 길이
				} else if(mbday.length != 8){
					$('#d5').html('<span style = "color:red">생년.월.일을 올바르게 입력해 주세요.</span>')
					$("mbday").val('')
					mbday.focus();	
				
				// 다 통과 후 
				} else {
					ujoin.submit();
				}	
				
				}) // $('#b2').click(function() 
			}) // $(function()
		</script>
</head>
<body>
	<div class="loging">
	<h1><a href="./index.jsp"><img src="/world42/resources/img/wo.png"></a></h1>
		<form name="ujoin" action="uj.cr">
			<table>
				
				<tr>
					<td>
						&nbsp;&nbsp;&nbsp;
						아이디: <input type="text" name="memid" id="memid" 
						placeholder="4~12자까지/중복확인"> 
						<button type="button" value="중복확인" id="b1" >중복확인</button>
						<div id="d" style = "font-size:12px"></div>
					</td>
				</tr>	
				
				<tr>
					<td>			
						비밀번호: <input type="password" name="mempw" id="mempw">
						<div id="d1" style = "font-size:12px"></div>
					</td>
				</tr>	
				
				<tr>
					<td>
						비밀번호: <input type="password" name="pw2" id="pw2" placeholder="비밀번호 재입력">
						<div id="d2" style = "font-size:12px"></div>
					</td>
				</tr>	
				
				<tr>
					<td>			
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						이  름: <input type="text" name="mname" id="mname">
						<div id="d3" style = "font-size:12px"></div>
					</td>
				</tr>	
					
				<tr>
					<td>			
						전화번호: <input type="text" name="tel" id="tel" placeholder="-를 빼고 입력해주세요">
						<div id="d4" style = "font-size:12px"></div>
					</td>
				</tr>	
					
				<tr>
					<td>		
						주민번호: <input type="text" name="mbday" id="mbday" placeholder="ex)1990-05-01">
						<div id="d5" style = "font-size:12px"></div><br>
					</td>
				</tr>
				
				<tr>
					<td>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<button type="button" value="회원가입" id="b2">회원가입</button>
					</td>
				</tr>
				
			</table>
		</form>
	</div>
</body>
</html>