<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가</title>
<link href="css/style.css?v=3" rel ="stylesheet" type="text/css">
<script>
	
	/* function checkValue(){
		if(!document.userinfo.name.value){
			alert("이름을 입력하세요 !")
		}
		if(!document.userinfo.id.value){
			alert("아이디를 입력하세요!");
			return false;
		}
		if(!document.userinfo.pwd.value){
			alert("비밀번호를 입력하세요!")
			return false;
		}
		if(!document.userinfo.phone_number.value){
			alert("전화번호를 입력하시오.");
			return false;
		}
	}
 */

</script>
</head>
<body>

	<div id="join_top">
		<div>메인화면</div>
	</div>
	<div id = "mid">
	<form action="joining.jsp" method="post">
	
	<div>이름 : <input type="text" name="name" ></div>
	<div>아이디 :<input type="text" name ="id" ></div>
	<div>비밀번호 : <input type="password" name="pwd" ></div>
	<div>휴대전화 번호 : <input type="tel" name="phone_number" ></div>
	<div><input type="text" name="birthyy" maxlength="4" placeholder="년(4자)" size="6" >
                        <select name="birthmm">
                            <option value="">월</option>
                            <option value="01" >1</option>
                            
                            <option value="02" >2</option>
                            <option value="03" >3</option>
                            <option value="04" >4</option>
                            <option value="05" >5</option>
                            <option value="06" >6</option>
                            <option value="07" >7</option>
                            <option value="08" >8</option>
                            <option value="09" >9</option>
                            
                            <option value="10" >10</option>
                            <option value="11" >11</option>
                            <option value="12" >12</option>
                        </select>
                        <input type="number" name="birthdd" min="1" max="31" maxlength="2" placeholder="일" size="4" >


	</div>
	<div><input type="submit" value="가입하기" ></div>
	
	
	</form>
	
	
	
	</div>
</body>



</html>