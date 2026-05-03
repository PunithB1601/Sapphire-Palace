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
@WebServlet("/signup")
public class Signup extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		GuestDAO gdao=new GuestDAOImpl();
		Guest guest=new Guest();

		Guest alreadyExists=gdao.getGuestByMail(req.getParameter("email"));
		if(alreadyExists!=null) {
			if(req.getParameter("password").equals(req.getParameter("confirm"))) {
				guest.setName(req.getParameter("name"));
				guest.setPhone(req.getParameter("phone"));
				guest.setEmail(req.getParameter("email"));
				guest.setPassword(req.getParameter("password"));
				guest.setPreferences(req.getParameter("preferences"));
				gdao.addGuest(guest);
				req.setAttribute("success", "Account created!");
				req.getRequestDispatcher("login.jsp").forward(req, resp);
			}
			else {
				req.setAttribute("error", "Password mismatch!");
				req.getRequestDispatcher("signup.jsp").forward(req, resp);
			}
		}
		else {
			req.setAttribute("error", "Account already exists with this email!");
			
		}

	}
}
