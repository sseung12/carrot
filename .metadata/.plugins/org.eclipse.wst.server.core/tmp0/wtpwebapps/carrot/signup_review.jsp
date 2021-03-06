<%@page import="com.carrot.beans.ReviewVO"%>
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
	String path = "/Users/seungsu/dev/java/carrot/carrot/WebContent/img/review"; 
	
	int size = 1024 *1024 * 10;
	
	ShoesDAO dao = null;			
	String file ="";
	String originalFile="";
	MultipartRequest multi = null;
	ReviewVO vo = new ReviewVO();
	int result;
	try{
		multi = new MultipartRequest(request,path,size,"UTF-8",new DefaultFileRenamePolicy());
		Enumeration<?> files = multi.getFileNames(); 
		String str = (String)files.nextElement(); 		
		file = multi.getFilesystemName(str); 
		
		int id =Integer.parseInt(multi.getParameter("shoes_id"));
		
		vo.setMember_id(Integer.parseInt(multi.getParameter("member_id")));
		vo.setShoes_id(id);
		vo.setStar(multi.getParameter("star"));
		vo.setName(multi.getParameter("name")); 
		vo.setTitle(multi.getParameter("title"));
		vo.setContent(multi.getParameter("content"));
		vo.setImg(file);
		vo.setShoes_size(multi.getParameter("shoes_size"));
		
		dao = ShoesDAO.getInstance();
		result =dao.signReview(vo);
		request.setAttribute("result",result);
		request.setAttribute("id", id);
	}catch(Exception e){
		e.printStackTrace();
	}
%>

 <script>
 	if('${result}' == 0){
 		alert("리뷰 등록 실패.");
 	}
 	else{
 		alert("리뷰 등록 성공.");
 	}
 	document.location.href='shoes.jsp?id='+'${id}';
 	
 </script>


	
	


</html>