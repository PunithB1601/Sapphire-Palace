package com.sapphirepalace.servlet;

import java.io.IOException;

import com.sapphirepalace.dao.BookingDAO;
import com.sapphirepalace.dao.RoomsDAO;
import com.sapphirepalace.dao.impl.BookingDAOImpl;
import com.sapphirepalace.dao.impl.RoomsDAOImpl;
import com.sapphirepalace.dto.Booking;
import com.sapphirepalace.dto.Guest;
import com.sapphirepalace.dto.Rooms;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/updateBooking")
public class UpdateBooking extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session=req.getSession();
		BookingDAO bdao=new BookingDAOImpl();
		RoomsDAO rdao=new RoomsDAOImpl();
		Guest admin=(Guest)session.getAttribute("user");
		if(admin!=null) {
			Integer bookingId=Integer.parseInt(req.getParameter("bookingId"));
			Booking b=bdao.getBookingById(bookingId);
			if(b!=null) {
				b.setStatus(req.getParameter("status"));
				bdao.updateBooking(b);
				if(b.getStatus().equalsIgnoreCase("COMPLETED")) {
					Rooms r=rdao.getRoomById(b.getRoomId());
					r.setAvailability(true);
					rdao.updateRoom(r);
				}
				resp.sendRedirect("booking.jsp");
			}
			else {
				req.setAttribute("error", "Booking not found!");
				req.getRequestDispatcher("admin.jsp").forward(req, resp);
			}
		}
	}
}
