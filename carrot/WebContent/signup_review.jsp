<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.carrot.beans.ShoesDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
	request.setCharacterEncoding("utf-8");
	System.out.println(request.getAttribute("name"));
%>
<jsp:useBean id="review" class="com.carrot.beans.ReviewVO" scope="request" >
<jsp:setProperty name="review" property="name"/>
<jsp:getProperty property="name" name="review"/>
<jsp:getProperty property="title" name="review"/>
</jsp:useBean>
<%
	
	/* String path = request.getSession().getServletContext().getRealPath("img/review");
	
	int size = 1024 *1024 * 10;
	String file ="";
	String originalFile="";
	MultipartRequest multi = null;
	try{
		multi = new MultipartRequest(request,path,size,"UTF-8",new DefaultFileRenamePolicy());
		
		Enumeration<?> files = multi.getFileNames();
		String str = (String)files.nextElement();
		
		file = multi.getFilesystemName(str);
		
	}catch(Exception e){
		e.printStackTrace();
	} 
	
	request.setAttribute("filename",file );	 */
%>
<%-- <jsp:setProperty property="img" name="review" value="${filename }"/> --%>

 
	


<%--  	System.out.println(review.getContent());
	System.out.println(review.getMember_id());
	System.out.println(review.getName());
	System.out.println(review.getTitle());
	System.out.println(review.getShoes_id());
	
	ShoesDAO dao = ShoesDAO.getInstance();
	dao.signReview(review); 
	
 --%>

</html>