<!DOCTYPE html>
<%@page import="com.carrot.beans.ReviewVO"%>
<%@page import="com.carrot.beans.Shoes_size"%>
<%@page import="com.carrot.beans.ShoesDAO"%>
<%@page import="com.carrot.beans.ShoesVO"%>
<%@page import="com.carrot.beans.Shoes_sizeVO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html>
<head>
<meta charset="UTF-8">
<title>${item.name }</title>
<link href="css/style.css?v=2" rel="stylesheet" type="text/css" />
</head>

	<%
	String id = request.getParameter("id");
	ShoesDAO dao = ShoesDAO.getInstance();
	ShoesVO vo = new ShoesVO();
	ArrayList<Shoes_size> sizevo = new ArrayList<Shoes_size>();
	ArrayList<ReviewVO> review = new ArrayList<ReviewVO>();
	vo = dao.getShoesOne(id);
	sizevo = dao.getSizeList(id);
	review = dao.getReviewList(id);
	
	request.setAttribute("review", review);
	request.setAttribute("sizevo", sizevo);
	request.setAttribute("item", vo);
	%>
<script>
	document.title = '${item.name}';
	
	
	
	// 수량 카운터 더하기 빼기, 체크함수
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
		let count = document.getElementById('shoes_count');
		let icon = document.getElementById('minus_icon');
			
		if(count.value == 1){
			console.log(icon);
			icon.disabled =true;
		}
		else{
			icon.disabled =false;		
		}
		
	}
	// form 전송시 size를 input에 저장
	function input_size_check(){
		const size = document.querySelector('.checked_size');
		const input_size = document.getElementById('input_size');
		if(size == undefined){
			alert('size 선택을 해주세요.');
			event.preventDefault();
			
		}
		else{
			input_size.value=size.innerText;			
		}
		
	}
	//form 전송시 count를 input에 저장
	function input_count_check(){
		const check = document.getElementById('input_count');
		check.value = document.getElementById('shoes_count').value;
		
	}
	
	//form 전송시 수량 체크
	
	
</script>
<body onload="count_check()">
	<jsp:include page="header.jsp" flush="false" />

	<div class="center">
		<div class="shoes_wrapper">

			<div class="shoes_image_wrapper">
				<img src="${item.img }">
			</div>

			<div class="shoes_info">
				<div class="shoes_title">
					<div>${item.name }</div>
					<div>
						<fmt:formatNumber type="number" value="${item.price }" />
						원
					</div>
				</div>
				<form id="shoessize_form" method="post">
					<input type="hidden" name="member_id" value="1">
					<input type="hidden" name="shoes_id" value="${item.shoes_id }">
					<input type="hidden" id="input_size" name="size" value="">
					<input type="hidden" id="input_count" name="count">
					<div class="shoes_name">${item.type }</div>
					<div class="shoes_size_warpper">
						<div class="shoes_size_title">사이즈 선택</div>
						<div class="shoes_size_list">
							<c:forEach var="i" items="${sizevo }" varStatus="status">
								<c:choose>
									<c:when test="${i.count > 0 }">
										<div class="shoes_size center nonezerosize">${i.name }</div>
									</c:when>
									<c:otherwise>
										<div class="shoes_size center zerosize">${i.name}</div>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</div>
					</div>
				</form>
					<div class="shoes_count_wrapper">
						<span>수량</span> <input id="shoes_count" type="number" name="count"
							value="1">
						<button onclick="count_down()" id="minus_icon">
							<i class="fas fa-minus"></i>
						</button>
						<button onclick="count_up()" id="plus_icon">
							<i class="fas fa-plus"></i>
						</button>
					</div>
				
				<hr>
				<div class="shoes_button_wrapper center">
					<div>
						<input type="submit" form="shoessize_form" class="shoes_buy_button" formaction="${pageContext.request.contextPath}/orderform" value="바로구매" onclick="input_size_check();input_count_check()">
					</div>
					<div class="shoes_button_wrapper2">
						<button class="shoes_etc_button center">장바구니</button>
						<button class="shoes_etc_button center">위시리스트</button>
					</div>
				</div>
				<hr style="margin: 1em 0 1.3em 0">
				<div class="shoes_review_wrapper">
					<div class="shoes_review_title">
						<div class="shoes_review_count">리뷰 ( ${fn:length(review) } )</div>
						<div class="shoes_review_title2">
							<div class="shoes_review_star"></div>
							<div class="shoes_updown_icon">
								<i class="fas fa-chevron-down" id="review_icon"></i>
							</div>
						</div>
					</div>
					<div class="shoes_review_hidden">
						<div class="shoes_review_write">
							<span class="review_signup_button">리뷰 작성하기</span>
						</div>
						<div class="review_signup_wrapper">
							<form action="signup_review.jsp" method="post" enctype="multipart/form-data">
								<input type="hidden" name="shoes_id" value= "${item.shoes_id }">
								<input type="hidden" name="member_id"  value="1">
								<input type="hidden" name="name" value="${item.name }">
								<input type="hidden" name="shoes_size" value="270">
								<input type="hidden" id="star_count" name="star" value="0">
								
								<div class="review_signup_title">
									<span class="review_word">제목</span>
									<input type="text" name="title" required>
								</div>
								
								<div class="review_signup_content">
									<span class="review_word">내용</span>
									<textarea name="content"rows="4" cols="20" required="required">
									</textarea>
								</div>
								
								<div class="review_signup_star_wrapper">
									<span class="review_word">
										평점
									</span>
									<div class="review_signup_star_wrapper2">
										<c:forEach varStatus="status" begin="1" end="5" step="1">
											<img class="star singup_review_star star_${status.index } review_star" src="img/star.png">
										</c:forEach>
									</div>
								</div>
								
								<div class="review_signup_img">
									<span class="review_word">
										이미지
									</span>
									<input type="file" name="img" id="review_img" accept="image/*">
								</div>
								
								<div class="center">
									<input id="review_button" type="submit" value= "등록">
								</div>
								
							</form>
						</div>
						<div class="shoes_review_list">
							<c:forEach var="i" items="${review}">
							<div class="shoes_review_list_wrapper">
								<div class="review_title">${i.title }</div>
								<div class="review_star_wrapper">
								<c:forEach  begin="1" end="${i.star }" step="1">
									<img class="star" src="img/blackstar.png">							
								</c:forEach>
								<c:set var="white_star" value="${5-i.star }"/>
								<c:forEach begin="1" end="${white_star }" step="1" >	
									<img class="star" src="img/star.png">
								</c:forEach>
								</div>
								<div class="review_info_wrapper">
									<span>${i.name }</span> <span>${i.registdate}</span> <span>270</span>
								</div>
								<div class="review_content">${i.content }</div>
								<div class="review_img">
									<img src="img/review/${i.img }">
								</div>
							</div>
							</c:forEach>
						</div>
					</div>
				
				</div>
			</div>
		</div>

	</div>
	<script>
	
	// size check 함수
	const btns =document.querySelectorAll(".nonezerosize");
	const zerobtns = document.querySelectorAll(".zerosize");
	
	function checking(target){
		target.style.background= "white";
		target.style.color ="black";
	}
	function nocheking(target){
		target.style.background="grey";
		target.style.color ="white";
		target.classList.add("checked_size");
		
	}
	
	// size button 함수
	btns.forEach(function(btn){
		btn.addEventListener('click',btnClick);
	});
	
	function btnClick(event){
		
		const tar = event.target;
		
		if(tar.style.background == "grey"){
			checking(tar);
		}
		else{
			btns.forEach(function(target){
				target.style.background="white";
				target.style.color ="black";
				target.classList.remove('checked_size');
			});
			nocheking(tar);
				
		
		}
	}

	// 수량 카운터
	/* let count =document.getElementById('shoes_count')
	count.addEventListener('blur', () => {
	if(count.value < 1){
		count.value =1;
	}
	}); */
	
	// review icon click 함수
	
	const review_icon = document.getElementById('review_icon');
	const review_icon_wrapper = document.querySelector('.shoes_updown_icon');
	const review_wrapper = document.querySelector('.shoes_review_hidden');
	
	review_icon.addEventListener('click', () => {
		if(review_icon.classList.contains("fa-chevron-down")){
			review_wrapper.style.display = "block";
			review_icon.classList.replace('fa-chevron-down','fa-chevron-up');
			
		}
		else{
			review_wrapper.style.display= 'none'; 
			document.querySelector('.review_signup_wrapper').style.display="none";
			review_icon.classList.replace('fa-chevron-up','fa-chevron-down');
		}
	});
	
	//review_signup_star 함수
	
	const review_signup_star = document.querySelectorAll('.singup_review_star');
	const star_count = document.getElementById('star_count');
	review_signup_star.forEach(function(star){
		
		star.addEventListener('click',(star)=> {
			let target = star.target;
			let index = target.classList[2].slice(-1);
			let i = 1;
			for (obj of review_signup_star){
			i <=index ?	obj.src="img/blackstar.png": obj.src="img/star.png";
			i= i+1;
				
			}
			star_count.value =index;
		});
	});
	
	const review_signup_button = document.querySelector(".review_signup_button");
	review_signup_button.addEventListener('click',() =>{
		document.querySelector(".review_signup_wrapper").style.display="flex";
	});
</script>
</body>
</html>