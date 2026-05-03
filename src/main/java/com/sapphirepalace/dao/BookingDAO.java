package com.sapphirepalace.dao;

import java.util.List;

import com.sapphirepalace.dto.Booking;

public interface BookingDAO {

	void addBooking(Booking booking);
    Booking getBookingById(Integer bookingId);
    List<Booking> getAllBookings();
    void updateBooking(Booking booking);
    void deleteBooking(Integer bookingId);
}
