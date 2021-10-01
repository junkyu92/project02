<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- jQuery -->
  <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
  <!-- iamport.payment.js -->
  <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.8.js"></script>
<script type="text/javascript">
	var IMP = window.IMP; // 생략 가능
	IMP.init("iamport"); // 예: imp00000000
	dateTime = new Date();
	IMP.request_pay({ // param
        pg: "html5_inicis",
        pay_method: "card",
        merchant_uid : 'merchant_' + dateTime.getTime(), // date,time location
        name: '${paydata}',
        amount: ${total},
        buyer_email: "",
        buyer_name: "${dto.mname}",
        buyer_tel: "${dto.tel}",
        buyer_addr: "",
        buyer_postcode: ""
    }, function (rsp) { // callback
        if (rsp.success) {
            location.href="pay.add?memid=${memid}&pay_data=${paydata}&pay_total=${total}&pay_datetime="+dateTime
        } else {
            
        }
    });
</script>
</head>
<body>

</body>
</html>