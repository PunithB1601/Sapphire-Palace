package com.sapphirepalace.servlet;

import java.io.IOException;
import java.time.LocalDateTime;

import com.sapphirepalace.dao.BookingDAO;
import com.sapphirepalace.dao.PaymentDAO;
import com.sapphirepalace.dao.RoomsDAO;
import com.sapphirepalace.dao.impl.BookingDAOImpl;
import com.sapphirepalace.dao.impl.PaymentDAOImpl;
import com.sapphirepalace.dao.impl.RoomsDAOImpl;
import com.sapphirepalace.dto.Booking;
import com.sapphirepalace.dto.Guest;
import com.sapphirepalace.dto.Payment;
import com.sapphirepalace.dto.Rooms;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/payment")
public class PaymentComplete extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		PaymentDAO pdao=new PaymentDAOImpl();
		BookingDAO bdao=new BookingDAOImpl();
		RoomsDAO rdao=new RoomsDAOImpl();
		HttpSession session=req.getSession();
		Guest guest=(Guest)session.getAttribute("user");
		
		Integer bookingId=Integer.parseInt(req.getParameter("bookingId"));
		Booking b=bdao.getBookingById(bookingId);
		if(guest!=null) {

			Payment p=pdao.getAllPayments().stream().filter(alreadyPaid->alreadyPaid.getBookingId()==bookingId).findFirst().orElse(null);
			if(p==null) {
				p=new Payment();
				p.setBookingId(bookingId);
				p.setMethod(req.getParameter("method"));
				p.setAmount(Double.parseDouble(req.getParameter("finalPrice")));
				p.setPaymentDate(LocalDateTime.now().toString());
				pdao.addPayment(p);
			}
			forwardToBill(req, resp, bookingId);
			req.getRequestDispatcher("bill.jsp").forward(req, resp);
		}
		else {
			req.setAttribute("loginError", "Session expired!");
			req.getRequestDispatcher("sign.jsp").forward(req, resp);
		}

	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Integer bookingId=Integer.parseInt(req.getParameter("bookingId"));
		forwardToBill(req, resp, bookingId);
	}
	
	private void forwardToBill(HttpServletRequest req, HttpServletResponse resp, Integer bookingId) 
	        throws ServletException, IOException {
	    PaymentDAO pdao = new PaymentDAOImpl();
	    BookingDAO bdao = new BookingDAOImpl();
	    RoomsDAO rdao = new RoomsDAOImpl();

	    Booking b = bdao.getBookingById(bookingId);
	    Payment p = pdao.getAllPayments().stream()
	                    .filter(pay -> pay.getBookingId() == bookingId)
	                    .findFirst()
	                    .orElse(null);

	    Rooms r = rdao.getRoomById(b.getRoomId());

	    req.setAttribute("room", r);
	    req.setAttribute("booking", b);
	    req.setAttribute("payment", p);
	    req.setAttribute("success", "Payment succesful!");
	    req.getRequestDispatcher("bill.jsp").forward(req, resp);
	}

	
}
