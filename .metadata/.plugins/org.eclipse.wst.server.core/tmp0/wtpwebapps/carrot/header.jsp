<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>header</title>
 <link href="css/style.css?v=3" rel ="stylesheet" type="text/css">
<link href="css/header.css?k=1" rel="stylesheet" type="text/css"/>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Odibee+Sans&display=swap" rel="stylesheet">

</head>



<div id="header_wrap">
	
	<div class="header_item"></div>
	<div class="header_item"></div>
	<div class="header_item">
	
		<div id ="input_wrapper">
			<input id="header_input"type="text" name="search">
			<button id="header_submit" style="">search</button>
		</div>
	</div>
	
	
	<div class="header_item">
		<div>
			<ul>
				<li> <a href="#">로그인</a>
				<li> <a href="#">회원가입</a>
				<li> <a href="#">이벤트</a>
			</ul>
		</div>
	</div>
	<div class="header_item"></div>
	<div class="header_item">
		<a href="header.jsp">AirSHOP</a>
	</div>
	
	<div class="header_item">
		
		<ul>
			<li class="header_navybar">
				<a href="#">Brand Story</a>
				<ul class="sub_menu">
					<li><div><a href="#">menu1</a></div></li>
					<li><div><a href="#">menu2</a></div></li>
					<li><div><a href="#">menu3</a></div></li>
				</ul>

			</li>
				
			<li class="header_navybar"><a href="#">PRODUCTS</a></li>
			<li class="header_navybar"><a href="#">SUPPORT</a></li>
		</ul>
	</div>
	
</div>


</html>