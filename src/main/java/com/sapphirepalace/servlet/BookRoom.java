package com.sapphirepalace.servlet;

import java.io.IOException;

import com.sapphirepalace.dao.BookingDAO;
import com.sapphirepalace.dao.GuestDAO;
import com.sapphirepalace.dao.RoomsDAO;
import com.sapphirepalace.dao.impl.BookingDAOImpl;
import com.sapphirepalace.dao.impl.GuestDAOImpl;
import com.sapphirepalace.dao.impl.RoomsDAOImpl;
import com.sapphirepalace.dto.Booking;
import com.sapphirepalace.dto.Rooms;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/book")
public class BookRoom extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		BookingDAO bdao=new BookingDAOImpl();
		GuestDAO gdao=new GuestDAOImpl();
		RoomsDAO rdao=new RoomsDAOImpl();
		
		Integer guestId=Integer.parseInt(req.getParameter("guestId"));
		Integer roomId=Integer.parseInt(req.getParameter("roomId"));
		Rooms r=rdao.getRoomById(roomId);
		
		if(gdao.getGuestById(guestId)!=null) {
			if(r!=null&&r.getAvailability()) {
				Booking b=new Booking();
				b.setGuestId(guestId);
				b.setRoomId(roomId);
				b.setCheckIn(req.getParameter("checkInDate"));
				b.setCheckOut(req.getParameter("checkOutDate"));
				b.setStatus("Pending");
				bdao.addBooking(b);
				req.setAttribute("success", "Complete payment to confirm your booking!");
				req.getRequestDispatcher("payment.jsp").forward(req, resp);
			}
			else {
				req.setAttribute("error", "Room unavailable");
				req.getRequestDispatcher("booking.jsp").forward(req, resp);
			}
		}
		else{
			req.setAttribute("error", "Kindly login to complete boooking!");
			req.getRequestDispatcher("login.jsp").forward(req, resp);
			
		}
	}
}
