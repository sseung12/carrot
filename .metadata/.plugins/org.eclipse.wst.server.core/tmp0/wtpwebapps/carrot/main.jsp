<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>main</title>
<link href="css/style.css?v=3" rel ="stylesheet" type="text/css">
<style>

}
</style>
	<script type = "text/javascript">
		
		let i =0;
		function changeImg(){
			
			console.log("changeimg 호출 ");
			let obj = document.getElementById('intro_img');
 		 	let arr = new Array("1.jpg","2.jpg","3.jpg","4.jpg");	
 		 	obj.src ="img/"+arr[i]; 
			fadeIn2(obj);
			i +=1;
			if(i==3) {
				i=0};			
			
		}
		
		function fadeIn2(obj){
			obj.style.opacity =0;
			let tick = function(){
				obj.style.opacity = +obj.style.opacity + 0.01;
				if(+obj.style.opacity < 1){
					(window.requestAnimationFrame && requestAnimationFrame(tick)) || setTimeout(tick,16)
				}
			};
			tick();
			
		}
		
		 
	</script>
</head>
<body>
<jsp:include page="header.jsp" flush="false"/>

<div class="main">
	<div class="main_wrapper">
		<div class="main_text" id ="main_intro_text">
			자연과 함께하는 기업.   <br> AirShop
		</div>
		<div>
			<img id="intro_img" class="main_img" src="img/4.jpg">	 
		</div>
	</div>
</div>

<jsp:include page="footer.jsp" flush="false"/>
</body>

<script>
	let obj = document.getElementById('intro_img');
	let intro_text = document.getElementById('main_intro_text');
	 setInterval(changeImg,10000);

	const user = '${user}';

	if(user!= ""){
	
	let text = document.getElementById('header_title_login');
	text.innerHTML = "로그아웃";
	text.href ="logout.jsp"; 
	}


</script>
</html>