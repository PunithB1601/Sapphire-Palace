package com.sapphirepalace.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.sapphirepalace.dao.RoomsDAO;
import com.sapphirepalace.dto.Rooms;
import com.sapphirepalace.utility.Connector;

public class RoomsDAOImpl implements RoomsDAO {

	private Connection con;
	
	public RoomsDAOImpl() {
		this.con=Connector.requestConnection();
	}
	
	@Override
	public void addRoom(Rooms room) {
		String sql = "INSERT INTO Room  VALUES (0,?,?,?,?,?,?)";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, room.getRoomNumber());
            ps.setString(2, room.getType());
            ps.setDouble(3, room.getPrice());
            ps.setBoolean(4, room.getAvailability());
            ps.setString(5, room.getAmenities());
            ps.setString(6, room.getDescription());
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error adding room: " + e.getMessage());
        }
	}

	@Override
	public Rooms getRoomById(Integer roomId) {
		Rooms rooms=null;
		String sql="SELECT * FROM ROOM WHERE ROOM_ID=?";
		 try (PreparedStatement ps = con.prepareStatement(sql)) {
	            ps.setInt(1, roomId);
	            ResultSet rs=ps.executeQuery();
	            while(rs.next()) {
	            	rooms=new Rooms();
	            	rooms.setRoomId(rs.getInt("room_Id"));
	            	rooms.setRoomNumber(rs.getString("room_number"));
	            	rooms.setType(rs.getString("type"));
	            	rooms.setAmenities(rs.getString("amenities"));
	            	rooms.setAvailability(rs.getBoolean("availability"));
	            	rooms.setPrice(rs.getDouble("price"));
	            	rooms.setDescription(rs.getString("description"));
	            }
		 }
		 catch (SQLException e) {
	            System.out.println("Error fetching room: " + e.getMessage());
	        }
		return rooms;
	}
		 

	@Override
	public List<Rooms> getAllRooms() {
		List<Rooms> roomsList=new ArrayList<>();
		Rooms rooms=null;
		String sql="SELECT * FROM ROOM";
		 try (PreparedStatement ps = con.prepareStatement(sql)) {
	            ResultSet rs=ps.executeQuery();
	            while(rs.next()) {
	            	rooms=new Rooms();
	            	rooms.setRoomId(rs.getInt("room_Id"));
	            	rooms.setRoomNumber(rs.getString("room_number"));
	            rooms.setType(rs.getString("type"));
	            	rooms.setAmenities(rs.getString("amenities"));
	            	rooms.setAvailability(rs.getBoolean("availability"));
	            	rooms.setPrice(rs.getDouble("price"));
	            	rooms.setDescription(rs.getString("description"));
	            	roomsList.add(rooms);
	            }
		 }
		 catch (SQLException e) {
	            System.out.println("Error fetching room: " + e.getMessage());
	        }
		return roomsList;
	}

	@Override
	public void updateRoom(Rooms room) {
		String query="UPDATE ROOM SET ROOM_NUMBER=?,TYPE=?,PRICE=?,AVAILABILITY=?,AMENITIES=?, DESCRIPTION=? WHERE ROOM_ID=?";
		try (PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, room.getRoomNumber());
            ps.setString(2, room.getType());
            ps.setDouble(3, room.getPrice());
            ps.setBoolean(4, room.getAvailability());
            ps.setString(5, room.getAmenities());
            ps.setString(6, room.getDescription());
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error updating room: " + e.getMessage());
        }
	}

	@Override
	public void deleteRoom(Integer roomId) {
		String query="DELETE FROM ROOM WHERE ROOM_ID=?";
		try (PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, roomId);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error deleting room: " + e.getMessage());
        }
	}

	@Override
	public List<Rooms> getRoomsByType(String type) {
		List<Rooms> roomsList=new ArrayList<>();
		Rooms rooms=null;
		String sql="SELECT * FROM ROOM WHERE TYPE=?";
		 try (PreparedStatement ps = con.prepareStatement(sql)) {
	            ps.setString(1, type);
			 	ResultSet rs=ps.executeQuery();
	            while(rs.next()) {
	            	rooms=new Rooms();
	            	rooms.setRoomId(rs.getInt("room_Id"));
	            	rooms.setRoomNumber(rs.getString("room_number"));
	            rooms.setType(rs.getString("type"));
	            	rooms.setAmenities(rs.getString("amenities"));
	            	rooms.setAvailability(rs.getBoolean("availability"));
	            	rooms.setPrice(rs.getDouble("price"));
	            	rooms.setDescription(rs.getString("description"));
	            	roomsList.add(rooms);
	            }
		 }
		 catch (SQLException e) {
	            System.out.println("Error fetching room: " + e.getMessage());
	        }
		return roomsList;
	}

}
