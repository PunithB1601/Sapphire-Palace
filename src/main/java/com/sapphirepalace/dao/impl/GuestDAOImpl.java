package com.sapphirepalace.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.sapphirepalace.dao.GuestDAO;
import com.sapphirepalace.dto.Guest;
import com.sapphirepalace.utility.Connector;

public class GuestDAOImpl implements GuestDAO {

	private Connection con;
	
	public GuestDAOImpl() {
		this.con=Connector.requestConnection();
	}
	
	@Override
	public void addGuest(Guest guest) {
		String sql = "INSERT INTO Guest VALUES (0,?,?,?,?,?)";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, guest.getName());
            ps.setString(2, guest.getEmail());
            ps.setString(3, guest.getPhone());
            ps.setString(4, guest.getPreferences());
            ps.setString(5, guest.getPassword());
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error adding guest: " + e.getMessage());
        }
	}

	@Override
	public Guest getGuestById(Integer guestId) {
		 Guest guest = null;
	        String sql = "SELECT * FROM Guest WHERE guest_id = ?";
	        try (PreparedStatement ps = con.prepareStatement(sql)) {
	            ps.setInt(1, guestId);
	            ResultSet rs = ps.executeQuery();
	            while (rs.next()) {
	                guest = new Guest();
	                guest.setGuestId(rs.getInt("guest_id"));
	                guest.setName(rs.getString("name"));
	                guest.setEmail(rs.getString("email"));
	                guest.setPhone(rs.getString("phone"));
	                guest.setPreferences(rs.getString("preferences"));
	                guest.setPassword(rs.getString("password"));
	            }
	        } catch (SQLException e) {
	            System.out.println("Error fetching guest: " + e.getMessage());
	        }
	        return guest;
	}

	@Override
	public List<Guest> getAllGuests() {
		List<Guest> guests = new ArrayList<>();
        String sql = "SELECT * FROM Guest";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Guest guest = new Guest();
                guest.setGuestId(rs.getInt("guest_id"));
                guest.setName(rs.getString("name"));
                guest.setEmail(rs.getString("email"));
                guest.setPhone(rs.getString("phone"));
                guest.setPreferences(rs.getString("preferences"));
                guest.setPassword(rs.getString("password"));
                guests.add(guest);
            }
        } catch (SQLException e) {
            System.out.println("Error fetching guests: " + e.getMessage());
        }
        return guests;
	}

	@Override
	public void updateGuest(Guest guest) {
		String sql = "UPDATE Guest SET name=?, email=?, phone=?, preferences=?,password=? WHERE guest_id=?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, guest.getName());
            ps.setString(2, guest.getEmail());
            ps.setString(3, guest.getPhone());
            ps.setString(4, guest.getPreferences());
            ps.setString(5, guest.getPassword());
            ps.setInt(6, guest.getGuestId());
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error updating guest: " + e.getMessage());
        }
	}

	@Override
	public void deleteGuest(Integer guestId) {
		String sql = "DELETE FROM Guest WHERE guest_id=?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, guestId);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error deleting guest: " + e.getMessage());
        }
	}

	@Override
	public Guest getGuestByMailAndPassword(String mail, String password) {
		 Guest guest = null;
	        String sql = "SELECT * FROM Guest WHERE email=? AND password=?";
	        try (PreparedStatement ps = con.prepareStatement(sql)) {
	            ps.setString(1, mail);
	            ps.setString(2,password);
	            ResultSet rs = ps.executeQuery();
	            while (rs.next()) {
	                guest = new Guest();
	                guest.setGuestId(rs.getInt("guest_id"));
	                guest.setName(rs.getString("name"));
	                guest.setEmail(rs.getString("email"));
	                guest.setPhone(rs.getString("phone"));
	                guest.setPreferences(rs.getString("preferences"));
	                guest.setPassword(rs.getString("password"));
	            }
	        } catch (SQLException e) {
	            System.out.println("Error fetching guest: " + e.getMessage());
	        }
	        return guest;
	}

	@Override
	public Guest getGuestByMail(String mail) {
		// TODO Auto-generated method stub
		return null;
	}

}
