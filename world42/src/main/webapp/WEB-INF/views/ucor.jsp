<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<% String sessionId = (String)session.getAttribute("sessionId"); %>

	<link rel="stylesheet" href="resources/css/ucor.css">
		<script type="text/javascript" src="resources/js/jquery-3.6.0.js"></script>
		<script type="text/javascript">
			
		
		</script>
</head>
<body>
	<div class="loging">
	<h1><a href="main.home?memid=${sessionId}"><img src="/world42/resources/img/wo.png"></a></h1>
		<form action="uc.up">
			<table>
				
					<tr>
						<td>
							비밀번호: <input type="text" name="mempw" id="mempw" value="${dto.mempw}">
						</td>
					</tr>
				
					<tr>
						<td>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							이  름: <input type="text" name="mname" id="mname" value="${dto.mname}">
						</td>
					</tr>
					
					<tr>
						<td>
							전화번호: <input type="text" name="tel" id="tel" value="${dto.tel}"><br><br>
						</td>
					</tr>
					
		            <tr>
		            	<td>
		            		<button value="수정" id="b1"> 수정 </button> 
		            		<a href="us.de?memid=${sessionId}"><button type="button" value="탈퇴" id="b2">탈퇴</button> </a>
		            		<input type="hidden" value=${sessionId} id="memid" name="memid">
		            	</td>
		            </tr>
					
			</table>
		</form>
	</div>
</body>
</html>