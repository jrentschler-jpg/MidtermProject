package com.skilldistillery.winenot.data;

import com.skilldistillery.winenot.entities.Payment;

public interface PaymentDAO {
	public Payment findById(int id);
	
	public Payment createPayment(Payment payment);
	public Payment updatePayment(int id, Payment payment);
	public boolean deletePayment(int id);

	public Payment findPaymentByOrderId(int id);

}
