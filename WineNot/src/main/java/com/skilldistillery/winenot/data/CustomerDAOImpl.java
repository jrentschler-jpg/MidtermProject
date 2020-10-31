package com.skilldistillery.winenot.data;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.winenot.entities.Customer;
import com.skilldistillery.winenot.entities.CustomerOrder;
import com.skilldistillery.winenot.entities.Review;
import com.skilldistillery.winenot.entities.User;
import com.skilldistillery.winenot.entities.Wine;

@Service
@Transactional
public class CustomerDAOImpl implements CustomerDAO {
	@PersistenceContext
	private EntityManager em;

	@Override
	public Customer getCustomerById(int id) {
		Customer customer = em.find(Customer.class, id);
		em.close();
		return customer;
	}
	
	@Override
	public List<Customer> getAllCustomers(){
		List<Customer> customers = null;
		String jpql = "SELECT c FROM Customer c";
		customers = em.createQuery(jpql, Customer.class).getResultList();
		em.close();
		return customers;
	}

	@Override
	public Customer createCustomer(Customer customer) {
		em.persist(customer);
		em.flush();
		em.close();
		return customer;
	}

	@Override
	public Customer updateCustomer(int id, Customer customer) {
		Customer dbCustomer = em.find(Customer.class, id);
		dbCustomer.setfName(customer.getfName());
		dbCustomer.setlName(customer.getlName());
		dbCustomer.setBio(customer.getBio());
		dbCustomer.setBirthdate(customer.getBirthdate());
		dbCustomer.setCustomerImage(customer.getCustomerImage());
		dbCustomer.setCreateDate(customer.getCreateDate());
		em.close();
		return dbCustomer;
	}

	@Override
	public boolean deleteCustomer(int id) {
		Customer customerToDelete = em.find(Customer.class, id);
		User dbUser = em.find(User.class, customerToDelete.getUser().getId());
		dbUser.setEnabled(0);
		em.close();
		return (dbUser.getEnabled() == 0);
	}

	@Override
	public List<Wine> getCustomerFavorites(int id) {
		Customer customer = em.find(Customer.class, id);
		List<Wine> wines = customer.getWines();
		em.close();
		return wines;
	}

	@Override
	public List<CustomerOrder> getCustomerOrders(int id) {
		Customer customer = em.find(Customer.class, id);
		List<CustomerOrder> orders = customer.getCustomerOrders();
		em.close();
		return orders;
	}

	@Override
	public List<Review> getCustomerReviews(int id) {
		Customer customer = em.find(Customer.class, id);
		List<Review> reviews = customer.getReviews();
		em.close();
		return reviews;
	}
	
}