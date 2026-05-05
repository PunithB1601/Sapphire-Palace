package com.sapphirepalace.dao;

import java.util.List;

import com.sapphirepalace.dto.Rooms;

public interface RoomsDAO {

	void addRoom(Rooms room);
    Rooms getRoomById(Integer roomId);
    List<Rooms> getAllRooms();
    void updateRoom(Rooms room);
    void deleteRoom(Integer roomId);
    List<Rooms> getRoomsByType(String type);
}
