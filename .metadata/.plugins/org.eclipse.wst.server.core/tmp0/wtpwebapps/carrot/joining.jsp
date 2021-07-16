<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="com.carrot.beans.MemberVO" %>
<%@ page import ="com.carrot.beans.MemberDAO" %>
<%@ page import ="com.carrot.beans.test" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var ="cpath">${pageContext.request.contextPath}</c:set>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가입완료</title>
<link href="css/style.css?v=1" rel="stylesheet" type="text/css"/>
</head>
<body>
		<%
			request.setCharacterEncoding("utf-8");
		%>
		

		<jsp:useBean id="memberVO" class="com.carrot.beans.MemberVO"/>
		<jsp:setProperty property="*" name="memberVO"/>
	
		<%
			
			MemberDAO dao = MemberDAO.getInstance();
			if(memberVO != null){
			 
 			 /* dao.insertMember(memberVO);  */
			}
		
		%>
	
			
		
		<script >
			
		 	alert("회원가입을 축하드립니다.");
		 	window.location.href = '${cpath}/main.jsp';
		</script>
		
		
</body>
</html>