package com.sapphirepalace.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.sapphirepalace.dao.PaymentDAO;
import com.sapphirepalace.dto.Payment;
import com.sapphirepalace.utility.Connector;

public class PaymentDAOImpl implements PaymentDAO{

	private Connection con;
	
	public PaymentDAOImpl() {
		this.con=Connector.requestConnection();
	}
	

    @Override
    public void addPayment(Payment payment) {
        String sql = "INSERT INTO Payment (booking_id, amount, payment_date, method) VALUES (?, ?, SYSDATE(), ?)";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, payment.getBookingId());
            ps.setDouble(2, payment.getAmount());
            ps.setString(3, payment.getMethod());
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error adding payment: " + e.getMessage());
        }
    }

    @Override
    public Payment getPaymentById(Integer paymentId) {
        Payment payment = null;
        String sql = "SELECT * FROM Payment WHERE payment_id=?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, paymentId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                payment = new Payment();
                payment.setPaymentId(rs.getInt("payment_id"));
                payment.setBookingId(rs.getInt("booking_id"));
                payment.setAmount(rs.getDouble("amount"));
                payment.setPaymentDate(rs.getString("payment_date")); // String
                payment.setMethod(rs.getString("method"));
            }
        } catch (SQLException e) {
            System.out.println("Error fetching payment: " + e.getMessage());
        }
        return payment;
    }
	

	@Override
	public List<Payment> getAllPayments() {
		List<Payment> paymentsList=new ArrayList<>(); 
		Payment payment = null;
	        String sql = "SELECT * FROM Payment";
	        try (PreparedStatement ps = con.prepareStatement(sql)) {
	           
	            ResultSet rs = ps.executeQuery();
	            while(rs.next()) {
	                payment = new Payment();
	                payment.setPaymentId(rs.getInt("payment_id"));
	                payment.setBookingId(rs.getInt("booking_id"));
	                payment.setAmount(rs.getDouble("amount"));
	                payment.setPaymentDate(rs.getString("payment_date")); // String
	                payment.setMethod(rs.getString("method"));
	                paymentsList.add(payment);
	            }
	        } catch (SQLException e) {
	            System.out.println("Error fetching payment: " + e.getMessage());
	        }
		return paymentsList;
	}

	@Override
	public void updatePayment(Payment payment) {
		String query="UPDATE PAYMENT SET BOOKING_ID=?,AMOUNT=?,PAYMENT_DATE=?,METHOD=? WHERE PAYMENT_ID=?";
		try (PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1,payment.getBookingId());
            ps.setDouble(2,payment.getAmount());
            ps.setString(3,payment.getPaymentDate());
            ps.setString(4,payment.getMethod());
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error updating payment: " + e.getMessage());
        }	
	}

	@Override
	public void deletePayment(Integer paymentId) {
		String query="DELETE FROM PAYMENT WHERE PAYMENT_ID=?";
		try (PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1,paymentId);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error deleting payment: " + e.getMessage());
        }	
	}


	@Override
	public Payment getPaymentByBookingId(Integer bookingId) {
		Payment payment = null;
        String sql = "SELECT * FROM Payment WHERE booking_id=?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                payment = new Payment();
                payment.setPaymentId(rs.getInt("payment_id"));
                payment.setBookingId(rs.getInt("booking_id"));
                payment.setAmount(rs.getDouble("amount"));
                payment.setPaymentDate(rs.getString("payment_date")); // String
                payment.setMethod(rs.getString("method"));
            }
        } catch (SQLException e) {
            System.out.println("Error fetching payment: " + e.getMessage());
        }
        return payment;
	}

}
