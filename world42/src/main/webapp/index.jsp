<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>42World 사이월드</title>
<link rel="stylesheet" href="resources/css/index.css">
	<script type="text/javascript" src="resources/js/jquery-3.6.0.js"></script>
	<script type="text/javascript">
		$(function() {
			$('#b1').click(function() {
				memid = $("#memid").val()
				mempw = $("#mempw").val()
				
				if (memid == "") {
					$('#d').html('<span style = "color:red">아이디를 입력해주세요.</span>')
					$("#memid").val('')
					memid.focus();
					
				}else if (mempw == "") {
					$('#d1').html('<span style = "color:red">비밀번호를 입력해주세요.</span>')
					$("#mempw").val('')
					mempw.focus();
				}else {
					ulogin.submit();
					
						/* if(result == 0){
							$('#d1').html('<span style = "color:red">아이디 혹은 비밀번호가 틀렸습니다.</span>')
						}else {
							alert('로그인 되었습니다.')
						} */
						
				} // 처음 else 	
			}) // $('#b1')	
		}) // $(function()
		
		// 회원가입 버튼클릭시 회원가입 화면으로 이동.
		function ujoin() { 
	        location.href = "ujoin.jsp";
		}
		
	</script>
</head>
<body>
	<div class="loging">
	<h1><a href="./index.jsp"><img src="/world42/resources/img/wo.png"></a></h1>
		<form name="ulogin" action="ul.re">
			 <table>
			 
				<tr>
					<td>
						<input type="text" id="memid" name="memid" placeholder="아이디"> 
						<div id="d" style = "font-size:12px"></div>
					</td>
				</tr>
				
				<tr>	
					<td>
						<input type="password" id="mempw" name="mempw" placeholder="비밀번호">
						<div id="d1" style = "font-size:12px"></div><br>
					</td>
				</tr>
				
				<tr>	
					<td>
					 	<button type="button" value="로그인" id="b1">로그인 </button><br>
					</td>
				</tr>
				<tr>
					<td>
						<button type="button" value="회원가입" id="b2" onclick= "ujoin()"> 회원가입</button>
					</td>
				</tr>
				
			 </table>
		</form>
	</div>
</body>
</html>