package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao.PatientDAO;
import dao.UserDAO;
import util.SessionUtil;

import java.io.IOException;

@WebServlet({"/dashboard", "/dashboard/admin", "/dashboard/medical", "/dashboard/family"})
public class DashboardServlet extends HttpServlet {
    private PatientDAO patientDAO;
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        patientDAO = new PatientDAO();
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String userRole = SessionUtil.getUserRole(request);
        String requestURI = request.getRequestURI();
        
        if (userRole == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Load dashboard data based on role
        loadDashboardData(request, userRole);
        
        // Forward to appropriate dashboard view
        String viewPath = getDashboardView(requestURI, userRole);
        request.getRequestDispatcher(viewPath).forward(request, response);
    }

    private void loadDashboardData(HttpServletRequest request, String userRole) {
        try {
            switch (userRole) {
                case "ADMIN":
                    // Load admin dashboard data
                    request.setAttribute("totalPatients", patientDAO.getTotalPatients());
                    request.setAttribute("totalUsers", userDAO.findAll().size());
                    request.setAttribute("medicalStaffCount", userDAO.findByRole("MEDICAL_STAFF").size());
                    request.setAttribute("familyMemberCount", userDAO.findByRole("FAMILY_MEMBER").size());
                    break;
                    
                case "MEDICAL_STAFF":
                    // Load medical staff dashboard data
                    request.setAttribute("totalPatients", patientDAO.getTotalPatients());
                    request.setAttribute("recentPatients", patientDAO.findAll());
                    break;
                    
                case "FAMILY_MEMBER":
                    // Load family member dashboard data
                    // This would typically show only patients related to this family member
                    request.setAttribute("myPatients", patientDAO.findAll()); // Simplified for now
                    break;
            }
        } catch (Exception e) {
            System.err.println("Error loading dashboard data: " + e.getMessage());
        }
    }

    private String getDashboardView(String requestURI, String userRole) {
        if (requestURI.contains("/admin")) {
            return "/views/dashboard/admin.jsp";
        } else if (requestURI.contains("/medical")) {
            return "/views/dashboard/medical.jsp";
        } else if (requestURI.contains("/family")) {
            return "/views/dashboard/family.jsp";
        } else {
            // Default dashboard based on role
            switch (userRole) {
                case "ADMIN":
                    return "/views/dashboard/admin.jsp";
                case "MEDICAL_STAFF":
                    return "/views/dashboard/medical.jsp";
                case "FAMILY_MEMBER":
                    return "/views/dashboard/family.jsp";
                default:
                    return "/views/login.jsp";
            }
        }
    }
}
