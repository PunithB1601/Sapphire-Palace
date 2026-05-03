package com.sapphirepalace.dao;

import java.util.List;

import com.sapphirepalace.dto.Guest;

public interface GuestDAO {

	void addGuest(Guest guest);
    Guest getGuestById(Integer guestId);
    List<Guest> getAllGuests();
    void updateGuest(Guest guest);
    Guest getGuestByMail(String mail);
    void deleteGuest(Integer guestId);
    Guest getGuestByMailAndPassword(String mail, String password);
}
