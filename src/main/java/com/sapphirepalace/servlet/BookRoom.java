package com.sapphirepalace.servlet;

import java.io.IOException;
import java.time.LocalDate;
import java.time.Period;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.Comparator;
import java.util.List;

import com.sapphirepalace.dao.BookingDAO;
import com.sapphirepalace.dao.GuestDAO;
import com.sapphirepalace.dao.RoomsDAO;
import com.sapphirepalace.dao.impl.BookingDAOImpl;
import com.sapphirepalace.dao.impl.GuestDAOImpl;
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

@WebServlet("/bookRoom")
public class BookRoom extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		BookingDAO bdao=new BookingDAOImpl();
		HttpSession session=req.getSession();
		Guest guest=(Guest)session.getAttribute("user");
		RoomsDAO rdao=new RoomsDAOImpl();
		
		Integer guestId=guest.getGuestId();
		Integer roomId=Integer.parseInt(req.getParameter("roomId"));
		Rooms r=rdao.getRoomById(roomId);
		
		
		
		if(guest!=null&&guest.getGuestId()==guestId) {
			if(r!=null&&r.getAvailability()) {
				Booking b=new Booking();
				b.setGuestId(guestId);
				b.setRoomId(roomId);
				b.setCheckIn(req.getParameter("checkIn"));
				b.setCheckOut(req.getParameter("checkOut"));
				
				b.setStatus("Pending");
				bdao.addBooking(b);
				Booking booking=bdao.getAllBookings().stream().sorted(Comparator.comparing(Booking::getBookingId).reversed()).findFirst().orElse(null);
				req.setAttribute("room", r);
				req.setAttribute("booking",booking);
				req.setAttribute("nights", noOfNights(b.getCheckIn(), b.getCheckOut()));
				//req.setAttribute("success", "Complete payment to confirm your booking!");
				req.getRequestDispatcher("payment.jsp").forward(req, resp);
			}
			else {
				req.setAttribute("error", "Room unavailable");
				req.getRequestDispatcher("guestBooking.jsp").forward(req, resp);
			}
		}
		else{
			req.setAttribute("error", "Kindly login to complete boooking!");
			req.getRequestDispatcher("login.jsp").forward(req, resp);
		}
	}
	
	public static Integer noOfNights(String checkIn, String checkOut) {
		
		DateTimeFormatter formatter=DateTimeFormatter.ofPattern("yyyy-MM-dd");
		LocalDate checkInDate=LocalDate.parse(checkIn, formatter);
		LocalDate checkOutDate=LocalDate.parse(checkOut, formatter);
		
		Period p=Period.between(checkInDate, checkOutDate);
		
		return p.getDays();
	}
	
	
}
