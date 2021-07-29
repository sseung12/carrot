<%@page import="com.carrot.beans.ShoesDAO"%>
<%@page import="com.carrot.beans.ShoesVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${item.name }</title>
<link href="css/style.css?v=2" rel="stylesheet" type="text/css"/>
</head>

<%
	String id = request.getParameter("id");
	ShoesDAO dao = ShoesDAO.getInstance();
	ShoesVO vo = new ShoesVO();
	vo =dao.getShoesOne(id);
	request.setAttribute("item", vo);
	
%>
<script>
document.title = '${item.name}';
function count_up(){
	let count =document.getElementById('shoes_count');
	count.value= parseInt(count.value) + 1;
	count_check();
}
function count_down(){
	let count = document.getElementById('shoes_count');
	count.value = parseInt(count.value) - 1 ;
	count_check();
}
function count_check(){
	console.log('count_check 호출');
	let count = document.getElementById('shoes_count');
	let icon = document.getElementById('minus_icon');
		
	if(count.value == 1){
		console.log("count ==1 버튼 비활성화")
		console.log(icon);
		icon.disabled =true;
	}
	else{
	icon.disabled =false;		
	}
	
}


</script>
<body onload ="count_check()">
<jsp:include page="header.jsp" flush="false"/>

<div class="center">
	<div class="shoes_wrapper">
	
		<div class="shoes_image_wrapper">
			<img src="${item.img }">
		</div>
		
		<div class="shoes_info">
			<div class="shoes_title">
				<div>${item.name }</div>
				<div><fmt:formatNumber type="number" value="${item.price }"/>원</div>
			</div>
			<div class="shoes_name">
					${item.type }
			</div>
			<div class="shoes_size_warpper">
				<div class="shoes_size_title">
					사이즈 선택
				</div>
				<div class="shoes_size_list">
					<c:forEach var ="i" begin="250" end="290" step="5">
					<div class="shoes_size center">${i }</div>
					</c:forEach>
				</div>
			</div>
			
			<div class="shoes_count_wrapper">
				 <span>수량</span>
				 <input id="shoes_count" type="number" name="count" value="1">
				 <button onclick="count_down()" id="minus_icon"><i class="fas fa-minus"></i></button>
				 <button onclick="count_up()" id="plus_icon"><i class="fas fa-plus"></i></button>
			</div>
			<hr>
			<div class="shoes_button_wrapper center">
				<div>
					<button class="shoes_buy_button">바로구매</button>
				</div>
				<div class="shoes_button_wrapper2">
					<div class="shoes_etc_button center">장바구니</div>
					<div class="shoes_etc_button center">위시리스트</div>
				</div>
			</div>
			<hr style="margin : 1em 0 1.3em 0">
			<div class="shoes_review_wrapper">
				<div class="shoes_review_title">
					<div class="shoes_review_count">리뷰(1)</div>
					<div class="shoes_review_title2">
						<div class="shoes_review_star"></div>
						<div class="shoes_updown_icon"><i class="fas fa-chevron-up"></i></div>
					</div>
				</div>
				<div class="shoes_review_write">
					<a href="#">리뷰 작성하기</a>
				</div>
				<div class="shoes_review_list">
					<div class="review_title">만족합니다</div>
					<div class="review_star">****</div>
					<div class="review_info_wrapper">
						<span>이*수</span>
						<span>2021.07.13</span>
						<span>270</span>
					</div>
					<div class="review_content">
						이뻐요, 친구들도 다 이쁘다합니다. 잘샀어요.
					</div>
					<div class="review_img">
						<img src="img/shoe_4.png">
					</div>
				</div>
			</div>
		</div>
	</div>
	
</div>
<script>
	const btns =document.querySelectorAll(".shoes_size");
	
	btns.forEach(function(btn){
		btn.addEventListener('click',btnClick);
	});
	function btnClick(event){
		const tar = event.target;
		if(tar.style.background =="grey"){
			tar.style.color = "black";
			tar.style.background ="white";
		}
		else{
			tar.style.color ="white";
			tar.style.background ="grey";
		}
	}


	let count =document.getElementById('shoes_count')
	count.addEventListener('blur', () =>{
	if(count.value < 1){
		count.value =1;
	}
});
</script>
</body>
</html>