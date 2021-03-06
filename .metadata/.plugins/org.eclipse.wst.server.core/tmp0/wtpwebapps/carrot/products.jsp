<%@page import="com.carrot.beans.ShoesVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.carrot.beans.ShoesDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>products</title>
</head>
<link href="css/style.css?v=2" rel="stylesheet" type="text/css" />
<style>

.item_wrapper{
	margin-top : 4em;
	display :grid;
	grid-template-columns : 1fr 1fr 1fr;
	grid-column-gap : 2em;
	grid-row-gap : 2em;
}
.product_item_textarea{

	display :flex;
	justify-content: space-between;
}
.product_item img{
	width :380px;
	height : 380px;
}
.product_item_textarea_right span{
	display :block;
}
.product_item{
	width: 380px;
	color :black;
}
.product_main{
	display :grid;
	grid-template-columns : 1.1fr 6fr;
	
}
.product_title_wrapper{
	margin-top : 1em;
	margin-bottom : 1em;
	width : 100%;
	display:flex;
	justify-content : center;
}
.product_title{
	
	width :94%;
	display: flex;
	justify-content : space-between;
	
}
.product_title div{
	font-size :  3.4em;
}
.product_aside{
	overflow : scroll;
	margin-right : 1em;
	height: 100%;
	display: flex;
	flex-direction : column;
	align-items : center;
	padding : 0 1em 0 1em; 
}
.product_aside_sizebox{
	
	display :grid;
	grid-template-columns :1fr 1fr 1fr;
	grid-row-gap : 0.3em;
	width :100%;
}
.product_aside_size{
	border :1px solid grey;
	border-radius : 0.6em;
	color : grey;
	width :4em;
	height : 2em;
	font-size : 0.9em;	
}
.product_aside_size:hover{
	background : grey;
	color :white;
}
.product_aside_title{
	margin :1em;
}

</style>

<% 
	request.setCharacterEncoding("utf-8");	
	ShoesDAO dao = ShoesDAO.getInstance();
	ArrayList<ShoesVO> list = dao.getShoesList();
	request.setAttribute("list", list);
%>

<body>
<jsp:include page="header.jsp" flush ="false"/>
<div class="product_title_wrapper">
	<div class="product_title">
		<div>Men 신발</div>
		<div>필터</div>
	</div>
</div>
<div class ="product_main">
<div class="product_aside">
	<div class="center product_aside_title">신발 사이즈</div>
	<div class="product_aside_sizebox">
		<c:forEach var ="i" begin="225" end="280" step="5">
		<div class="product_aside_size center">${i}</div>
		</c:forEach>
	
	</div>

</div>
	<div class="item_wrapper">
		<c:forEach var="item" items="${list }">
		<a href="shoes.jsp?id=${item.shoes_id }">
		<div class="product_item">
			<img src="${item.img }" alt="상품" />
			<div class ="product_item_textarea">
				<div class="product_item_textarea_right">
					<span>${item.name }</span>
					<span>${item.type }</span>
				</div>
				<div>
					<span><fmt:formatNumber type="number" value="${item.price }"/></span>
				</div>
			</div>
		</div>
		</a>
		</c:forEach>
	
	
	</div>

</div>
<jsp:include page="footer.jsp"/>
<script>
	const btns =document.querySelectorAll(".product_aside_size");
	
	btns.forEach(function(btn){
		btn.addEventListener('click',btnClick);
	});
	function btnClick(event){
		const tar = event.target;
		if(tar.style.background =="grey"){
			tar.style.color = "grey";
			tar.style.background ="white";
		}
		else{
			tar.style.color ="white";
			tar.style.background ="grey";
		}
	}
</script>
</body>
</html>