<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var ="cpath">${pageContext.request.contextPath}</c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="css/style.css?v=7" rel="stylesheet" type="text/css">
<title>회원가입</title>
<style>
.sign_text{
	margin-bottom : 1.2em;
	font-size : 0.8em;
	color :grey;
}
</style>
<script>


</script>

</head>

<body class="singup_body">
	
	<div class="sign_wrapper">
		<div class="sign_title">
			<a href="${cpath }/main.jsp">Airshop</a>
		</div>
		
		<form id="sign_form" action="joining.jsp" method="post">
		
		<div class="sign_input_wrapper">
			
			<div class="sign_box">
				<label for="sign_id">아이디</label>
				<input type="text" name="id" id="sign_id" required >
				<span class="sign_text" id="id_text"></span>
			</div>
			
			<div class="sign_box">
				<label for="sign_pwd">비밀번호</label>
					<input style="font-size:14px;" type="password" name="pwd" id="sign_pwd" placeholder="한글,영어,특수문자포함 8자리이상" required>		
					<span class="sign_text" id ="pwd_text"></span>
			</div>
			
			<div class="sign_box">
				<label for="sign_pwd2">비밀번호 재확인</label>
				<input type="password" id="sign_pwd2" required>
				<span class="sign_text" id="pwd2_text"></span>
			</div>
			
			<div class="sign_box">
				<label for ="sign_name">이름</label>
				<input type="text" name ="name" id="sign_name" required>
			</div>
			
			<div class="sign_box">
				<label for="sign_gender">성별</label>
				<select id="sign_gender" name="gener" required>
					<option value="남자">남자</option>
					<option value="여자">여자</option>
				</select>
			</div>
			
			<div class="sign_box">
			 	<label for="sign_email">본인 확인 이메일</label>
				<input type="email" name="email" id="sign_email" required>
			</div>
			<div class="sign_box">
				<label for ="sign_phone_num">전화번호</label>
				<input type="text" placeholder="010 - **** - ****" name="phone_num" id="sign_phone_num" >
			</div>
			<div class="sign_box2">
				<label>생년월일</label>
				<div class="sign_birth_wrapper">
				<input id="sign_year"type="text" name="birthyy" placeholder="년(4자)">
				<select id="sign_month" name="birthmm">
					
					<option value="01">1</option>
					<option value="02">2</option>
					<option value="03">3</option>
					<option value="04">4</option>
					<option value="05">5</option>
					<option value="06">6</option>
					<option value="07">7</option>
					<option value="08">8</option>
					<option value="09">9</option>
					<option value="10">10</option>
					<option value="11">11</option>
					<option value="12">12</option>
				</select>
				<input id= "sign_day"type="number" name="birthdd" min="1" max="31" placeholder="일" >
				</div>
			</div>
			
			<div class="sign_box">
				<input type="button" id="sign_submit" value="가입하기">
			</div>
		</div>
			
		</form>
		
	</div>
</body>
<script>

// 아이디,비밀번호 통과 boolean값 지정
let id_push = false;
let pwd_push = false;
let pwd_push2 =false;
let push_arr = [id_push,pwd_push,pwd_push2];


//아이디 중복검사
sign_id.addEventListener('blur', () => {
	
	let id = document.getElementById('sign_id').value;
	let text = document.getElementById('id_text');
	
	if(!/[!?@#$%^&*():;+-=~{}<>\_\[\]\|\\\,\.\/a-zA-Z0-9]{4,12}$/.test(id)){
		text.innerHTML ="4~12자를 입력해주세요.";
		text.style.color = "red";
		push_arr[0] = false;
	}
	else{
		//Ajax 아이디 중복 검사
		let xhr = new XMLHttpRequest();
		xhr.open('get','ajax.jsp?id='+id,true);
		xhr.setRequestHeader('Content-type','application/x-www-form-urlencoded');
		xhr.send("post=post_ajax");
		
		xhr.onload = function(){
			if(xhr.status ==200 && xhr.readyState ==4){		
				console.log("Ajax 통신성공");

				let idchk = xhr.responseText;
				idchk.replace(" ","");
				
				// select문으로 일치하는 개수가 0개일때 통과
				if(idchk ==0){
					text.innerHTML ="사용가능한 아이디입니다.";
					text.style.color ="blue";
					push_arr[0] = true;
				}
				else{
					text.innerHTML = "이미 존재하는 아이디입니다.";
					text.style.color = "red";
					push_arr[0] = false;
				}			
			}
			else{
				text.innerHTML = "통신오류";
				text.style.color = "red";
			}
		}
		
	}
});

//비밀번호 유효성 검사
let pwd = document.getElementById('sign_pwd');

pwd.addEventListener('blur',()=>{
	let text = document.getElementById('pwd_text');

	if(!/[!?@#$%^&*():;+-=~{}<>\_\[\]\|\\\,\.\/a-zA-Z0-9]{8,16}$/.test(pwd.value)){
 		
		text.innerHTML ="비밀번호는 영어,한글,특수문자 포함 8~ 16글자입니다.";
		text.style.color = "red";
		push_arr[1] = false;
 	}
	
	  else{
		text.innerHTML = "비밀번호가 적합합니다.";
		text.style.color ="blue";
		push_arr[1] = true;
	} 
});		
//비밀번호 불일치 검사 
let pwd2 = document.getElementById('sign_pwd2');

pwd2.addEventListener('blur',() => {
	let text = document.getElementById('pwd2_text');
	if(pwd.value === pwd2.value){
		text.innerHTML = '비밀번호가 일치합니다.';
		text.style.color='blue';
		push_arr[2] = true;
	}
	else{
		text.innerHTML = "비밀번호가 일치하지 않습니다.";
		text.style.color ='red';
		push_arr[2] = false;
	}
});
 //sumbmit 전 체크
 console.log(push_arr);
	let submit = document.getElementById('sign_submit');
	
	submit.addEventListener('click',() => {
		let check = true;	
		for(let key in push_arr){
			if(push_arr[key] == false && key == 0){
				alert('아이디를 확인해주세요.');
				check =false;
				break;
			}
			else if(push_arr[key]==false && key ==1){
				alert('비밀번호를 확인해주세요.');
				check =false;
				break;
			}
			else if (push_arr[key]==false && key ==2){
				alert('비밀번호 확인을 확인해주세요.');
				check = false;
			}
		}
		if(check== true){
			if(
					document.getElementById('sign_name')!="" && 
					document.getElementById('sign_gender').value!="" && 
					document.getElementById('sign_email').value !=""&&
					document.getElementById('sign_phone_num').value !="" && 
					document.getElementById('sign_year').value != "" &&
					document.getElementById('sign_month').value != ""&&
					document.getElementById('sign_day').value != "" )
					
			{				
					document.getElementById('sign_form').submit();
			}
			else{
				alert('빈 항목을 확인해 주세요.');							
			}
		}
		
	});
	
	
</script>
</html> 