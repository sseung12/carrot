<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="com.carrot.beans.MemberDAO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("utf-8");
	String id =request.getParameter("id");
	System.out.println(id);
	MemberDAO dao = MemberDAO.getInstance();
	int idchk = dao.checkId(id);
	request.setAttribute("idchk", idchk);
%>
<%=idchk %>
