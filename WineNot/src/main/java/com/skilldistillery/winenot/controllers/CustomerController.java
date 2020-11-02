package com.skilldistillery.winenot.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.skilldistillery.winenot.data.AddressDAO;
import com.skilldistillery.winenot.data.CustomerDAO;
import com.skilldistillery.winenot.data.CustomerOrderDAO;
import com.skilldistillery.winenot.data.PaymentInfoDAO;
import com.skilldistillery.winenot.data.ReviewDAO;
import com.skilldistillery.winenot.data.UserDAO;
import com.skilldistillery.winenot.entities.Address;
import com.skilldistillery.winenot.entities.Customer;
import com.skilldistillery.winenot.entities.CustomerOrder;
import com.skilldistillery.winenot.entities.PaymentInfo;
import com.skilldistillery.winenot.entities.Review;
import com.skilldistillery.winenot.entities.ReviewId;
import com.skilldistillery.winenot.entities.User;
import com.skilldistillery.winenot.entities.Wine;

@Controller
public class CustomerController {

	// All DAOS that could be implemented by the Customer ==================

	@Autowired
	private CustomerDAO custDAO;

	@Autowired
	private UserDAO userDAO;

	@Autowired
	private AddressDAO addrDAO;

	@Autowired
	private CustomerOrderDAO custOrdDAO;

	@Autowired
	private PaymentInfoDAO payInfoDAO;

	@Autowired
	private ReviewDAO rviewDAO;

	// REQUEST MAPPING ======================================================

	@RequestMapping(path = "index.html")
	public String index(Model model) {
		return "index.html";
	}

	// USER FORMS ================

	@RequestMapping(path = "createUserForm.do", method = RequestMethod.GET)
	public String createUserForm(User user) {
		return "LogIn";
//		return "folder/newUserForm";
	}

	@RequestMapping(path = "createUser.do", method = RequestMethod.POST)
	public String createUser(User user, Model model) {
		model.addAttribute("newUser", userDAO.createUser(user));

//		return "folder/userProfilePage";
		return "userProfilePage";
	}

	@RequestMapping(path = "updateUserForm.do")
	public String updateUsernameById(Model model, int id) {
		User updateUser = userDAO.getUserById(id);
		model.addAttribute("user", updateUser);
		return "userProfilePage";
	}
	@RequestMapping(path = "updateUsernameForm.do")
	public String updateUsername(Model model, int id, String username) {
		User updateUser = userDAO.getUserById(id);
		updateUser.setUsername(username);
		userDAO.updateUser(id, updateUser);
		model.addAttribute("user", updateUser);
		return "userProfilePage";
	}

	@RequestMapping(path = "updatePasswordForm.do")
	public String updatePass(Model model, int id, String pass) {
		User updateUser = userDAO.getUserById(id);
		updateUser.setPassword(pass);
		userDAO.updateUser(id, updateUser);
		model.addAttribute("user", updateUser);
		return "userProfilePage";
	}

	@RequestMapping(path = "updateEmailForm.do")
	public String updateEmail(Model model, int id, String email) {
		User updateUser = userDAO.getUserById(id);
		updateUser.setEmail(email);
		userDAO.updateUser(id, updateUser);
		model.addAttribute("user", updateUser);
		return "userProfilePage";
	}

	@RequestMapping(path = "deleteUser.do")
	public String deleteUser(int id, Model model) {
		if (custDAO.deleteCustomer(id)) {
			model.addAttribute("deleteResult", "Customer Account deleted");
		}

		else {
			model.addAttribute("deleteResult", "Customer account not found");
		}

		return "homePage";
	}

	// ADDRESS FORMS =================

	@RequestMapping(path = "createAddressForm.do", method = RequestMethod.GET)
	public String CreateAddressForm(Address Address) {

		return "folder/newAddressForm";
	}

	@RequestMapping(path = "createAddress.do", method = RequestMethod.POST)
	public String createAddress(Address address, Model model) {
		model.addAttribute("newAddress", addrDAO.createAddress(address));

		return "folder/userProfilePage";
	}

	// PAYMENT FORMS =================

	@RequestMapping(path = "createPaymentInfoForm.do", method = RequestMethod.GET)
	public String createPayInfoForm(PaymentInfo payInfo) {

		return "folder/newPayInfoForm";
	}

	@RequestMapping(path = "createPaymentInfo.do", method = RequestMethod.POST)
	public String createPayInfo(PaymentInfo payInfo, Model model) {
		model.addAttribute("newUser", payInfoDAO.create(payInfo));

		return "folder/userProfilePage";
	}

	// REVIEW FORMS =====================

	@RequestMapping(path = "createReviewForm.do", method = RequestMethod.GET)
	public String createReviewForm(Review review) {

		return "folder/reviewsForm";
	}

	@RequestMapping(path = "createReview.do", method = RequestMethod.POST)
	public String createReview(Review review, Model model) {
		model.addAttribute("review", rviewDAO.createReview(review));

		return "folder/userProfilePage";
	}
	
	@RequestMapping(path = "getAllReviews.do", method = RequestMethod.GET)
	public String getAllReviews(Model model, int id) {
		List<Review> reviews = custDAO.getCustomerReviews(id);
		model.addAttribute("reviews", reviews);
		return "myReviews";
	}
	
	@RequestMapping(path = "removeReview.do", method = RequestMethod.GET)
	public String removeReview(Model model, int custId, int wineId) {
		Boolean deleted = rviewDAO.deleteReview(custId, wineId);
		model.addAttribute("deleted", deleted);
		return "myReviews";
	}
	
	@RequestMapping(path = "updateReviewReview.do", method = RequestMethod.GET)
	public String updateReviewReview(Model model, int custId, int wineId, String reviewUpdate) {
		Review review = rviewDAO.getReviewByCustomerAndWineId(custId, wineId);
		review.setReview(reviewUpdate);
		rviewDAO.updateReview(custId, wineId, review);
		return "myReviews";
	}
	@RequestMapping(path = "updateReviewRating.do", method = RequestMethod.GET)
	public String updateReviewRating(Model model, int custId, int wineId, int rating) {
		Review review = rviewDAO.getReviewByCustomerAndWineId(custId, wineId);
		review.setRating(rating);
		rviewDAO.updateReview(custId, wineId, review);
		return "myReviews";
	}
	@RequestMapping(path = "updateReviewImage.do", method = RequestMethod.GET)
	public String updateReviewImage(Model model, int custId, int wineId, String image) {
		Review review = rviewDAO.getReviewByCustomerAndWineId(custId, wineId);
		review.setImage(image);
		rviewDAO.updateReview(custId, wineId, review);
		return "myReviews";
	}
	//List of all wines
//		@RequestMapping(path = "wineList.do", method = RequestMethod.GET)
//		public String listedWines(Model model) {
//			List<Wine> listOfWines = wineDao.findAllWine();
//			model.addAttribute("wine", listOfWines);
//			return "listOfWines";
//		}

	// FAVORITES FORMS ===================
	
	@RequestMapping(path = "favoritesList.do")
	public String getFavorites(Model model, Integer id) {
		List<Wine> cust = custDAO.getCustomerFavorites(id);
		model.addAttribute("favList", cust);
		
		return "favorites";
	}

	
	//ORDER FORMS ========================
	@RequestMapping(path ="listAllCustomerOrders.do", method = RequestMethod.GET)
	public String listAllCustomerOrders(Model model, int id) {
		Customer customer = custDAO.getCustomerById(id);
		List<CustomerOrder> orders = customer.getCustomerOrders();
		model.addAttribute("orders", orders);
		return "orderhistory";
	}

}
