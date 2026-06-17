package com.sapphirepalace.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.sapphirepalace.dao.BookingDAO;
import com.sapphirepalace.dto.Booking;
import com.sapphirepalace.utility.Connector;

public class BookingDAOImpl implements BookingDAO{

	private Connection con;
	
	public BookingDAOImpl() {
		this.con=Connector.requestConnection();
	}
	
	@Override
    public void addBooking(Booking booking) {
        String sql = "INSERT INTO Booking (guest_id, room_id, check_in, check_out, status) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, booking.getGuestId());
            ps.setInt(2, booking.getRoomId());
            ps.setString(3, booking.getCheckIn());   // String instead of Date
            ps.setString(4, booking.getCheckOut());  // String instead of Date
            ps.setString(5, booking.getStatus());
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error adding booking: " + e.getMessage());
        }
    }

    
	@Override
	public List<Booking> getAllBookings() {
		List<Booking> bookingsList=new ArrayList<>();
		Booking booking = null;
        String sql = "SELECT * FROM Booking";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                booking = new Booking();
                booking.setBookingId(rs.getInt("booking_id"));
                booking.setGuestId(rs.getInt("guest_id"));
                booking.setRoomId(rs.getInt("room_id"));
                booking.setCheckIn(rs.getString("check_in"));   // String
                booking.setCheckOut(rs.getString("check_out")); // String
                booking.setStatus(rs.getString("status"));
                bookingsList.add(booking);
            }
        } catch (SQLException e) {
            System.out.println("Error fetching booking: " + e.getMessage());
        }
		return bookingsList;
	}

	@Override
	public void updateBooking(Booking booking) {
		String query="UPDATE BOOKING SET GUEST_ID=?,ROOM_ID=?,CHECK_IN=?,CHECK_OUT=?,STATUS=? WHERE BOOKING_ID=?";
		try (PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, booking.getGuestId());
            ps.setInt(2, booking.getRoomId());
            ps.setString(3, booking.getCheckIn());
            ps.setString(4, booking.getCheckOut());
            ps.setString(5, booking.getStatus());
            ps.setInt(6, booking.getBookingId());
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error updating booking: " + e.getMessage());
        }
	}

	@Override
	public void deleteBooking(Integer bookingId) {
		String query="DELETE FROM BOOKING WHERE BOOKING_ID=?";
		try (PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1,bookingId);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error deleting booking: " + e.getMessage());
        }
		
	}

	@Override
	public Booking getBookingById(Integer bookingId) {
		Booking booking = null;
        String sql = "SELECT * FROM Booking WHERE booking_id=?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                booking = new Booking();
                booking.setBookingId(rs.getInt("booking_id"));
                booking.setGuestId(rs.getInt("guest_id"));
                booking.setRoomId(rs.getInt("room_id"));
                booking.setCheckIn(rs.getString("check_in"));   // String
                booking.setCheckOut(rs.getString("check_out")); // String
                booking.setStatus(rs.getString("status"));
            }
        } catch (SQLException e) {
            System.out.println("Error fetching booking: " + e.getMessage());
        }
        return booking;
	}

}
