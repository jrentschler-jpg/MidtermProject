package com.skilldistillery.winenot.controllers;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.Period;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.skilldistillery.winenot.data.AddressDAO;
import com.skilldistillery.winenot.data.CustomerDAO;
import com.skilldistillery.winenot.data.PaymentInfoDAO;
import com.skilldistillery.winenot.data.ReviewDAO;
import com.skilldistillery.winenot.data.UserDAO;
import com.skilldistillery.winenot.data.WineDAO;
import com.skilldistillery.winenot.entities.Address;
import com.skilldistillery.winenot.entities.Customer;
import com.skilldistillery.winenot.entities.CustomerOrder;
import com.skilldistillery.winenot.entities.PaymentInfo;
import com.skilldistillery.winenot.entities.Review;
import com.skilldistillery.winenot.entities.User;
import com.skilldistillery.winenot.entities.Wine;

@Controller
public class CustomerController {

	// All DAOS that could be implemented by the Customer ==============================================

	@Autowired
	private CustomerDAO custDAO;
	@Autowired
	private UserDAO userDAO;
	@Autowired
	private AddressDAO addrDAO;
	@Autowired
	private PaymentInfoDAO payInfoDAO;
	@Autowired
	private ReviewDAO rviewDAO;
	@Autowired
	private WineDAO wineDao;
	
	//Guide for request mappings ========================================================================
	
	//User forms start at line 55.
	//Address forms start at line 144.
	//Payment forms start at line 189.
	//Review forms start at line 225.
	//Favorite forms start at 290.
	//Order formm start at 309
	//Log in/out forms start at line 319

	// USER FORMS ============================================================================================

	@RequestMapping(path = "createUserForm.do", method = RequestMethod.GET)
	public String createUserForm(User user) {
		return "LogIn";
	}

	@RequestMapping(path = "createUser.do", method = RequestMethod.POST)
	public String createUser(User user, Model model) {
		model.addAttribute("newUser", userDAO.createUser(user));
		return "userProfilePage";
	}
	@RequestMapping(path = "createCustomerForm.do")
	public String createAccount() {
		return "createNewAccount";
	}
	@RequestMapping(path = "createCustomer.do", method = RequestMethod.POST)
	public String createNewAccount(HttpSession session, Model model, User user, String date, String firstName, String lastName) {
		LocalDate birthDate = LocalDate.parse(date);
		Period period = Period.between(birthDate, LocalDate.now());
		if (period.getYears() < 21) {
			model.addAttribute("failure", "You must be 21 or older to use this service!");
			return "homePage";
		}
		LocalDateTime bornDate = birthDate.atStartOfDay();
		LocalDateTime createDate = LocalDateTime.now();
		User newUser = userDAO.createUser(user);
		Customer customer = new Customer();
		newUser.setEnabled(1);
		customer.setUser(newUser);
		customer.setfName(firstName);
		customer.setlName(lastName);
		customer.setBirthdate(bornDate);
		customer.setCreateDate(createDate);
		customer = custDAO.createCustomer(customer);
		model.addAttribute("newAccount", newUser);
		if (session.getAttribute("customer") == null) {
		session.setAttribute("customer", customer);
		}
		return "redirect:customerCreated.do";
	}
	@RequestMapping(path = "customerCreated.do")
	public String customerCreated() {
		return "address";
	}

	@RequestMapping(path = "updateUserForm.do")
	public String updateUsernameById(HttpSession session, Model model) {
		Customer customer = (Customer) session.getAttribute("customer");
		User updateUser = userDAO.getUserById(customer.getId());
		model.addAttribute("user", updateUser);
		model.addAttribute("customer", customer);
		model.addAttribute("address", customer.getAddress());
		return "userProfilePage";
	}
	@RequestMapping(path = "updateUsernameForm.do")
	public String updateUsername(HttpSession session, Model model, String username) {
		Customer customer = (Customer) session.getAttribute("customer");
		User updateUser = userDAO.getUserById(customer.getId());
		updateUser.setUsername(username);
		userDAO.updateUser(customer.getId(), updateUser);
		model.addAttribute("user", updateUser);
		return "userProfilePage";
	}

	@RequestMapping(path = "updatePasswordForm.do")
	public String updatePass(HttpSession session, Model model, String pass) {
		Customer customer = (Customer) session.getAttribute("customer");
		User updateUser = userDAO.getUserById(customer.getId());
		updateUser.setPassword(pass);
		userDAO.updateUser(customer.getId(), updateUser);
		model.addAttribute("user", updateUser);
		return "userProfilePage";
	}

	@RequestMapping(path = "updateEmailForm.do")
	public String updateEmail(HttpSession session, Model model, String email) {
		Customer customer = (Customer) session.getAttribute("customer");
		User updateUser = userDAO.getUserById(customer.getId());
		updateUser.setEmail(email);
		userDAO.updateUser(customer.getId(), updateUser);
		model.addAttribute("user", updateUser);
		return "userProfilePage";
	}

	@RequestMapping(path = "deleteUser.do")
	public String deleteUser(HttpSession session, Model model) {
		Customer customer = (Customer) session.getAttribute("customer");
		if (custDAO.deleteCustomer(customer.getId())) {
			model.addAttribute("deleteResult", "Customer Account deleted");
			session.removeAttribute("customer");
		}
		else {
			model.addAttribute("deleteResult", "Customer account not found");
			session.removeAttribute("customer");
		}
		return "homePage";
	}

	// ADDRESS FORMS ================================================================================

	@RequestMapping(path = "createAddressForm.do", method = RequestMethod.GET)
	public String CreateAddressForm(HttpSession session, Address Address) {
		Customer customer = (Customer) session.getAttribute("customer");
		return "address";
	}
	@RequestMapping(path = "createAddress.do", method = RequestMethod.POST)
	public String createAddress(HttpSession session, Address address, Integer id, Model model) {
		Customer customer = (Customer) session.getAttribute("customer");
		model.addAttribute("newAddress", addrDAO.createAddress(address));
		custDAO.setAddress(customer.getId(), address);
		customer.setAddress(address);
		session.setAttribute("customer", customer);
		return "redirect:addressCreated.do";
	}
	@RequestMapping(path = "addressCreated.do", method = RequestMethod.GET)
	public String addressCreated() {
		return "payment";
	}
	@RequestMapping(path = "updateAddressForm.do", method = RequestMethod.GET)
	public String updateAddress(HttpSession session, Model model) {
		Customer customer = (Customer) session.getAttribute("customer");
		model.addAttribute("address", customer.getAddress());
		return "updateAddress";
	}
//	THIS METHOD IS FOR UPDATING ADDRESS.
	@RequestMapping(path = "updateAddressInfo.do", method = RequestMethod.POST)
		public String updateAddress(HttpSession session, Model model, Address address) {
		Customer customer = (Customer) session.getAttribute("customer");
		address = addrDAO.updateAddress(address.getId(), address);
		customer.setAddress(address);
		session.setAttribute("customer", customer);
		model.addAttribute("address", address);
		return "userProfilePage";
	}

	@RequestMapping(path = "deleteAddressForm.do", method = RequestMethod.GET)
	public String deleteAddress(HttpSession session, Model model) {
		Customer customer = (Customer) session.getAttribute("customer");
		Address address = addrDAO.getAddressById(customer.getId());
		custDAO.setAddress(customer.getId(), null);
		Boolean deleted = addrDAO.deleteAddress(address.getId());
		model.addAttribute("address", address);
		model.addAttribute("deleted", deleted);
		return "updateAddress";
	}

	// PAYMENT FORMS =====================================================================================================

	@RequestMapping(path = "createPaymentInfoForm.do", method = RequestMethod.GET)
	public String createPayInfoForm(HttpSession session, Model model, PaymentInfo payInfo) {
		Customer customer = (Customer) session.getAttribute("customer");
		customer.getAddress();
		customer.getPaymentInfo();
		model.addAttribute("payInfo", customer.getPaymentInfo());
		return "payment";
	}

	@RequestMapping(path = "createPaymentInfo.do", method = RequestMethod.POST)
	public String createPayInfo(HttpSession session, Model model, String cardNumber, String exprDate) {
		Customer customer = (Customer) session.getAttribute("customer");
//		Address address = new Address();
		exprDate = exprDate.concat("-01");
		PaymentInfo paymentInfo = new PaymentInfo();
		paymentInfo.setCardNumber(cardNumber);
		LocalDate someDate = LocalDate.parse(exprDate);
		LocalDateTime exprDateTime = someDate.atStartOfDay();
		paymentInfo.setExprDate(exprDateTime);
		paymentInfo.setAddress(null);
		PaymentInfo newInfo = payInfoDAO.create(paymentInfo);
		custDAO.setPayment(customer.getId(), paymentInfo);
		model.addAttribute("payInfo", newInfo);
		customer.setPaymentInfo(paymentInfo);
		session.setAttribute("customer", customer);
		return "redirect:paymentInfoCreated.do";
	}
	@RequestMapping(path="paymentInfoCreated.do", method= RequestMethod.GET)
	public String payInfoCreated() {
		return "userProfilePage";
	}
	
	@RequestMapping(path = "updatePaymentInfoForm.do", method = RequestMethod.GET)
	public String updatePaymentInfoForm(HttpSession session, Model model) {
		Customer customer = (Customer) session.getAttribute("customer");
		model.addAttribute("payInfo", customer.getPaymentInfo());
		return "updatePayment";
	}
	
//	THIS METHOD IS FOR UPDATING PAYMENT INFORMATION.
	@RequestMapping(path = "updatePaymentInfo.do", method = RequestMethod.POST)
	public String updatePaymentInfo(HttpSession session, Integer id, Model model, Address address, String cardNumber, String exprDate) {
		Customer customer = (Customer) session.getAttribute("customer");
		exprDate = exprDate.concat("-01");
		LocalDate date = LocalDate.parse(exprDate); 
		LocalDateTime newDate = date.atStartOfDay();
		PaymentInfo paymentInfo = new PaymentInfo();
		paymentInfo.setCardNumber(cardNumber);
		paymentInfo.setAddress(address);
		paymentInfo.setExprDate(newDate);
		paymentInfo.setId(id);
		payInfoDAO.update(id, paymentInfo);
		custDAO.setPayment(customer.getId(), paymentInfo);
		customer.setPaymentInfo(paymentInfo);
		session.setAttribute("customer", customer);
		model.addAttribute("address", address);
		return "redirect:paymentInfoUpdated.do";
	}
	@RequestMapping(path = "paymentInfoUpdated.do", method = RequestMethod.GET)
	public String paymentInfoUpdated() {
		return "userProfilePage";
	}

	// REVIEW FORMS ====================================================================================

	//displays the list of reviews currently
	@RequestMapping(path = "getAllReviews.do", method = RequestMethod.GET)
	public String getAllReviews(HttpSession session, Model model) {
		Customer customer = (Customer) session.getAttribute("customer");
		List<Review> reviews = custDAO.getCustomerReviews(customer.getId());
		model.addAttribute("reviews", reviews);
		return "myReviews";
	}

	//goes to the form to update review of wines.
	@RequestMapping(path = "getUpdatedReviewOfWines.do", method = RequestMethod.GET)
	public String getUpdatedReviewOfWiines(Model model, int custId, int wineId) {
		Review review = rviewDAO.getReviewByCustomerAndWineId(custId, wineId);
		model.addAttribute("review", review);
		model.addAttribute("custId", custId);
		model.addAttribute("wineId", wineId);
		return "updateReviewWine";
	}
	//redisplay the updated wines back to the reviews page.
	@RequestMapping(path = "getAllUpdatedReviews.do", method = RequestMethod.POST)
	public String getAllUpdatedReviews(HttpSession session, Model model, int wineId, String reviewUpdate, int rating, String image) {
		Customer customer = (Customer) session.getAttribute("customer");
		Review review = rviewDAO.getReviewByCustomerAndWineId(customer.getId(), wineId);
		review.setReview(reviewUpdate);
		review.setRating(rating);
		if(image == null || image == "") {
			review.setImage(wineDao.findWineById(wineId).getImage());
		}else {
			review.setImage(image);
			
		}
		
//		if(review.setImage(image) == null) {
//			model.addAttribute("image", review.wine.image);
//		}
		rviewDAO.updateReview(customer.getId(), wineId, review);
		List<Review> reviews = custDAO.getCustomerReviews(customer.getId());
		model.addAttribute("reviews", reviews);
		return "redirect:reviewUpdated.do";
	}
	@RequestMapping(path = "reviewUpdated.do", method = RequestMethod.GET)
	public String reviewUpdated(HttpSession session, Model model) {
		Customer customer = (Customer) session.getAttribute("customer");
		List<Review> reviews = custDAO.getCustomerReviews(customer.getId());
		model.addAttribute("reviews", reviews);
		return "myReviews";
	}
	
	@RequestMapping(path = "removeReview.do", method = RequestMethod.GET)
	public String removeReview(HttpSession session, Model model, int wineId) {
		Customer customer = (Customer) session.getAttribute("customer");
		Boolean deleted = rviewDAO.deleteReview(customer.getId(), wineId);
		List<Review> reviews = custDAO.getCustomerReviews(customer.getId());
		model.addAttribute("reviews", reviews);
		model.addAttribute("deleted", deleted);
		return "myReviews";
	}
	
	// FAVORITES FORMS =======================================================================
	
	@RequestMapping(path = "favoritesList.do")
	public String getFavorites(HttpSession session, Model model, Integer id) {
		Customer customer = (Customer) session.getAttribute("customer");
		List<Wine> cust = custDAO.getCustomerFavorites(customer.getId());
		model.addAttribute("favList", cust);
		return "favorites";
	}
	
	@RequestMapping(path = "addToFavoritesList.do")
	public String addToFavorites(HttpSession session, Model model, Integer id, Integer wid) {
		Customer customer = (Customer) session.getAttribute("customer");
		List<Wine> cust = custDAO.addWineToFavorites(customer.getId(), wid);
		model.addAttribute("favList", cust);
		return "favorites";
	}
	@RequestMapping(path = "removeFromFavorites.do", method = RequestMethod.GET)
	public String removeFromFavorites(HttpSession session, Model model, int wid) {
		Customer customer = (Customer) session.getAttribute("customer");
		Boolean deleted = custDAO.removeWineFromFavorites(customer.getId(), wid);
		List<Wine> wines = custDAO.getCustomerFavorites(customer.getId());
		model.addAttribute("favList", wines);
		model.addAttribute("deleted", deleted);
		return "favorites";
	}
	
	//ORDER FORMS =====================================================================
	
	@RequestMapping(path ="listAllCustomerOrders.do", method = RequestMethod.GET)
	public String listAllCustomerOrders(HttpSession session, Model model) {
		Customer customer = (Customer) session.getAttribute("customer");
		List<CustomerOrder> orders = custDAO.getCustomerOrders(customer.getId());
		model.addAttribute("orders", orders);
		return "orderhistory";
	}
	
	//Login in ========================================================================
	
	@RequestMapping(path="checkCredentials.do", method = RequestMethod.GET)
	public String checkCredentials(HttpSession session, Model model, String email, String password) {
		Customer customer = custDAO.verifyLogin(email, password);
		if (customer == null ) {
			String failure = "Invalid login credentials, try again or create and account.";
			model.addAttribute("failure", failure);
			return "LogIn";
		}
		if (customer.getUser().getEnabled() == 0) {
			String failure = "Your account is inactive, please contact an administrator.";
			model.addAttribute("failure", failure);
			return "LogIn";
		}
		if (session.getAttribute("customer") == null) {
		session.setAttribute("customer", customer);
		}
		model.addAttribute("customerId", customer.getId());
		return "homePage";
	}
	//Log Out ==========================================================================
	
	@RequestMapping(path="logOutOfAccount.do", method = RequestMethod.GET)
	public ModelAndView logOutOfAccount(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		session.removeAttribute("customer");
		mv.setViewName("homePage");
		return mv;
	}
}
