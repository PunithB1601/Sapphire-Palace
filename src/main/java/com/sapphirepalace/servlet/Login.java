package com.sapphirepalace.servlet;

import java.io.IOException;

import com.sapphirepalace.dao.GuestDAO;
import com.sapphirepalace.dao.impl.GuestDAOImpl;
import com.sapphirepalace.dto.Guest;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class Login extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		GuestDAO gdao=new GuestDAOImpl();
		Guest login=gdao.getGuestByMailAndPassword(req.getParameter("email"), req.getParameter("password"));
		
		if(login!=null) {
			HttpSession session=req.getSession();
			session.setAttribute("user", login);
			if(login.getGuestId()==1) {
				req.setAttribute("admin", "Welcome admin!");
				req.getRequestDispatcher("admin.jsp").forward(req, resp);
			}
			else {
				req.setAttribute("success", "Login successful!");
				req.getRequestDispatcher("home.jsp").forward(req, resp);
			}
		}
		else {
			req.setAttribute("error", "Failed to login!");
			req.getRequestDispatcher("login.jsp").forward(req, resp);
		}
	}
}
