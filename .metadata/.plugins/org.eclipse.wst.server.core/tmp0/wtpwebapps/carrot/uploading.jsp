<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.carrot.beans.MemberDAO" %>
<%

	MemberDAO dao = MemberDAO.getInstance();
	dao.uploadImg(request);




%>
