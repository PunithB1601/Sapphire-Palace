package com.sapphirepalace.dao;

import java.util.List;

import com.sapphirepalace.dto.Payment;

public interface PaymentDAO {

	 	void addPayment(Payment payment);
	    Payment getPaymentById(Integer paymentId);
	    List<Payment> getAllPayments();
	    void updatePayment(Payment payment);
	    void deletePayment(Integer paymentId);
}
