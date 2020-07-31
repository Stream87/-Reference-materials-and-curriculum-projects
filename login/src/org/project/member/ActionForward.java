package org.project.member;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ActionForward {
	
	private boolean isRedirect =false;
	private String jspName = "";
	
	public ActionForward() {
		// TODO Auto-generated constructor stub
	}

	 public ActionForward(boolean isRedirect, String jspName) {
	
		this.isRedirect = isRedirect;
		this.jspName = jspName;
	}

	 /**
	 * @return the isRedirect
	 */
	public boolean isRedirect() {
		return isRedirect;
	}

	/**
	 * @param isRedirect the isRedirect to set
	 */
	public void setRedirect(boolean isRedirect) {
		this.isRedirect = isRedirect;
	}

	/**
	 * @return the viewName
	 */
	public String getJspName() {
		return jspName;
	}

	/**
	 * @param viewName the viewName to set
	 */
	public void setJspName(String jspName) {
		this.jspName = jspName;
	}
	
	protected void excute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		if(isRedirect) {
			resp.sendRedirect(jspName);
		}else {
		RequestDispatcher view = req.getRequestDispatcher(jspName);
		view.forward(req, resp);
	}
	}
}
