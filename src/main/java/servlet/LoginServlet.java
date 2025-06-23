package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao.UserDAO;
import model.User;
import util.PasswordUtil;
import util.SessionUtil;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // If user is already logged in, redirect to dashboard
        if (SessionUtil.isLoggedIn(request)) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }
        
        request.getRequestDispatcher("/views/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        if (username == null || password == null || username.trim().isEmpty() || password.trim().isEmpty()) {
            request.setAttribute("error", "Username and password are required");
            request.getRequestDispatcher("/views/login.jsp").forward(request, response);
            return;
        }
        
        try {
            User user = userDAO.findByUsername(username.trim());
            
            if (user != null && PasswordUtil.verifyPassword(password, user.getPasswordHash())) {
                // Login successful
                SessionUtil.setUserSession(request, user);
                
                // Redirect based on role
                String redirectURL = getRedirectURL(user.getRole());
                response.sendRedirect(request.getContextPath() + redirectURL);
            } else {
                // Login failed
                request.setAttribute("error", "Invalid username or password");
                request.getRequestDispatcher("/views/login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            System.err.println("Login error: " + e.getMessage());
            request.setAttribute("error", "An error occurred during login. Please try again.");
            request.getRequestDispatcher("/views/login.jsp").forward(request, response);
        }
    }

    private String getRedirectURL(String role) {
        switch (role) {
            case "ADMIN":
                return "/dashboard/admin";
            case "MEDICAL_STAFF":
                return "/dashboard/medical";
            case "FAMILY_MEMBER":
                return "/dashboard/family";
            default:
                return "/dashboard";
        }
    }
}
