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
		Guest login=gdao.getGuestByMailAndPassword(req.getParameter("mail"), req.getParameter("password"));
		
		if(login!=null) {
			HttpSession session=req.getSession();
			session.setAttribute("user", login);
			if(login.getGuestId()==1) {
				req.getRequestDispatcher("admin.jsp").forward(req, resp);
			}
			else {
				req.setAttribute("loginSuccess", "Login successful!");
				req.getRequestDispatcher("index.jsp").forward(req, resp);
			}
		}
		else {
			req.setAttribute("loginError", "Failed to login!");
			req.getRequestDispatcher("sign.jsp").forward(req, resp);
		}
	}
}
