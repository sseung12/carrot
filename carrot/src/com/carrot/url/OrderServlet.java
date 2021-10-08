package com.carrot.url;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.websocket.Session;

import com.carrot.beans.ShoesDAO;
import com.carrot.beans.orderVO;

@WebServlet("/orderform")
public class OrderServlet extends HttpServlet{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
		public void init(ServletConfig config)throws ServletException{
		
		
		
		
	}
	

	
	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException,IOException{
		
		req.setCharacterEncoding("utf-8");
		
		System.out.println("get 호출");
	}
	
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException,IOException{
		System.out.println("post 실행");
		req.setCharacterEncoding("utf-8");
		String[] pageList = {"orderform_first.jsp","orderform_second.jsp","orderform_third.jsp"};
		int index = 0;
	
		
		if(req.getParameter("orderform_type") != null){
			index =  Integer.parseInt(req.getParameter("orderform_type"));
		}
		
		if(index == 0) {
			setOrderVO(req);
		}
	
		req.setAttribute("form_number", pageList[index]);

		
		RequestDispatcher rd = req.getRequestDispatcher("orderform.jsp");
		rd.forward(req, res);
		
		
	}
	
	public void setOrderVO(HttpServletRequest req) {
		orderVO vo = new orderVO();
		vo.setCount(Integer.parseInt(req.getParameter("count")));
		vo.setMember_id(Integer.parseInt(req.getParameter("member_id")));
		vo.setShoes_id(Integer.parseInt(req.getParameter("shoes_id")));
		vo.setSize(req.getParameter("size"));
		
		HttpSession session = req.getSession();
		session.setAttribute("orderVO", vo);
	}
}