package com.sapphirepalace.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.sapphirepalace.dao.ImageDAO;
import com.sapphirepalace.dto.Image;
import com.sapphirepalace.utility.Connector;

public class ImageDAOImpl implements ImageDAO {

	private Connection con;
	
	public ImageDAOImpl() {
		this.con=Connector.requestConnection();
	}
	@Override
	public void addImage(Image image) {
		 String sql = "INSERT INTO Image (room_id, file_path, description) VALUES (?, ?, ?)";
	        try (PreparedStatement ps = con.prepareStatement(sql)) {
	            ps.setInt(1, image.getRoomId());
	            ps.setString(2, image.getFilePath());
	            ps.setString(3, image.getDescription());
	            ps.executeUpdate();
	        } catch (SQLException e) {
	            System.out.println("Error adding image: " + e.getMessage());
	        }
	    }

	    @Override
	    public Image getImageById(Integer imageId) {
	        Image image = null;
	        String sql = "SELECT * FROM Image WHERE image_id=?";
	        try (PreparedStatement ps = con.prepareStatement(sql)) {
	            ps.setInt(1, imageId);
	            ResultSet rs = ps.executeQuery();
	            if (rs.next()) {
	                image = new Image();
	                image.setImageId(rs.getInt("image_id"));
	                image.setRoomId(rs.getInt("room_id"));
	                image.setFilePath(rs.getString("file_path"));
	                image.setDescription(rs.getString("description"));
	            }
	        } catch (SQLException e) {
	            System.out.println("Error fetching image: " + e.getMessage());
	        }
	        return image;
	    }

	@Override
	public List<Image> getImagesByRoomId(Integer roomId) {
		List<Image> roomImages=new ArrayList<>();
		Image image = null;
        String sql = "SELECT * FROM Image WHERE room_id=?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, roomId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                image = new Image();
                image.setImageId(rs.getInt("image_id"));
                image.setRoomId(rs.getInt("room_id"));
                image.setFilePath(rs.getString("file_path"));
                image.setDescription(rs.getString("description"));
                roomImages.add(image);
            }
        } catch (SQLException e) {
            System.out.println("Error fetching image: " + e.getMessage());
        }
		return roomImages;
	}

	@Override
	public void updateImage(Image image) {
		 String sql = "UPDATE Image SET room_id=?, file_path=?, description=? WHERE image_id=?";
	        try (PreparedStatement ps = con.prepareStatement(sql)) {
	            ps.setInt(1, image.getRoomId());
	            ps.setString(2, image.getFilePath());
	            ps.setString(3, image.getDescription());
	            ps.setInt(4, image.getImageId());
	            ps.executeUpdate();
	        } catch (SQLException e) {
	            System.out.println("Error updating image: " + e.getMessage());
	        }
	    }

	    @Override
	    public void deleteImage(Integer imageId) {
	        String sql = "DELETE FROM Image WHERE image_id=?";
	        try (PreparedStatement ps = con.prepareStatement(sql)) {
	            ps.setInt(1, imageId);
	            ps.executeUpdate();
	        } catch (SQLException e) {
	            System.out.println("Error deleting image: " + e.getMessage());
	        }
	    }
		/*
		 * @Override public List<Image> getImagesByRoomCategory(String type) {
		 * List<Image> roomImages=new ArrayList<>(); Image image = null; String sql =
		 * "SELECT * FROM Image WHERE type=?"; try (PreparedStatement ps =
		 * con.prepareStatement(sql)) { ps.setString(1, type); ResultSet rs =
		 * ps.executeQuery(); if (rs.next()) { image = new Image();
		 * image.setImageId(rs.getInt("image_id"));
		 * image.setRoomId(rs.getInt("room_id"));
		 * image.setFilePath(rs.getString("file_path"));
		 * image.setDescription(rs.getString("description")); roomImages.add(image); } }
		 * catch (SQLException e) { System.out.println("Error fetching image: " +
		 * e.getMessage()); } return roomImages; }
		 */
		@Override
		public List<Image> getImagesByRoomType(String type) {
			List<Image> roomImages=new ArrayList<Image>();
			Image image=null;
			String query="SELECT I.* FROM ROOM R INNER JOIN IMAGE I "
					+ "ON R.ROOM_ID=I.ROOM_ID WHERE R.TYPE=?";
			try(PreparedStatement ps=con.prepareStatement(query)) {
				ps.setString(1, type);
				ResultSet rs=ps.executeQuery();
				while(rs.next()) {
					image = new Image();
	                image.setImageId(rs.getInt("image_id"));
	                image.setRoomId(rs.getInt("room_id"));
	                image.setFilePath(rs.getString("file_path"));
	                image.setDescription(rs.getString("description"));
	                roomImages.add(image);
				}
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return roomImages;
		}

}
