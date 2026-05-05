package com.sapphirepalace.dao;

import java.util.List;

import com.sapphirepalace.dto.Image;

public interface ImageDAO {

	 	void addImage(Image image);
	    Image getImageById(Integer imageId);
	    List<Image> getImagesByRoomId(Integer roomId);
	    void updateImage(Image image);
	    void deleteImage(Integer imageId);
	  //  List<Image> getImagesByRoomCategory(String type);
}
