package org.project.member;

import java.io.IOException;

import javax.activation.CommandMap;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Controller extends HttpServlet {
	
	protected void doProcess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println(resp);
		
		String command = req.getParameter("command");
		ActionForward forward = null;
		
		if(command.equals("member_form")) {
			System.out.println("member_form");
			forward  = new ActionForward(false,"member/member_frorm.jsp");
		
		}else if (command.equals("confirm")) {
			System.out.println("confirm");

			forward  = new ActionForward(false,"member/confirm.jsp");
		
		}else if (command.equals("regist")) {
			System.out.println("regist");

			forward  = new ActionForward(true,"confirm.jsp");
			String id = req.getParameter("id");
			String password = req.getParameter("password");
			String name = req.getParameter("name");
			String email = req.getParameter("email");

			System.out.println(id+"/"+password+"/"+name+"/"+email+"/");
		}
		System.out.println("ddddend");
		forward.excute(req, resp);
		System.out.println("dddden11111d");
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req, resp);
	}
	
}
