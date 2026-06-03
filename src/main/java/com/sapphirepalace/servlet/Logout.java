package com.sapphirepalace.servlet;

import java.io.IOException;

import com.sapphirepalace.dto.Guest;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/logout")
public class Logout extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session=req.getSession();
		Guest user=(Guest)session.getAttribute("user");
		if(user!=null) {
			session.invalidate();
			resp.sendRedirect("index.jsp");
		}
		else {
			req.setAttribute("loginError", "Session expired!");
			req.getRequestDispatcher("sign.jsp").forward(req, resp);
		}
	}
}
