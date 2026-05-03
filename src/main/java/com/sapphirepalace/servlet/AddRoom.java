package com.sapphirepalace.servlet;

import java.io.IOException;

import com.sapphirepalace.dao.RoomsDAO;
import com.sapphirepalace.dao.impl.RoomsDAOImpl;
import com.sapphirepalace.dto.Rooms;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/addroom")
public class AddRoom extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		RoomsDAO rdao=new RoomsDAOImpl();
		
		Rooms r=new Rooms();
		r.setRoomNumber(req.getParameter("roomNumber"));
		r.setType(req.getParameter("roomType"));
		r.setPrice(Double.parseDouble(req.getParameter("price")));
		r.setAmenities(req.getParameter("amenities"));
		r.setDescription(req.getParameter("desription"));
		r.setAvailability(Boolean.parseBoolean(req.getParameter("availability")));
		rdao.addRoom(r);
		req.setAttribute("success","Rooms added successfully!");
		req.getRequestDispatcher("admin.jsp").forward(req, resp);
	}
}
