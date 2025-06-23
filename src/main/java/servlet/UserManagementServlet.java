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
import java.util.List;

@WebServlet({"/admin/users", "/admin/users/new", "/admin/users/edit", "/admin/users/delete"})
public class UserManagementServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check if user is admin
        if (!SessionUtil.hasRole(request, "ADMIN")) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied");
            return;
        }
        
        String action = getAction(request);
        
        switch (action) {
            case "list":
                handleList(request, response);
                break;
            case "new":
                handleNew(request, response);
                break;
            case "edit":
                handleEdit(request, response);
                break;
            case "delete":
                handleDelete(request, response);
                break;
            default:
                handleList(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check if user is admin
        if (!SessionUtil.hasRole(request, "ADMIN")) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied");
            return;
        }
        
        String action = getAction(request);
        
        switch (action) {
            case "new":
                handleCreate(request, response);
                break;
            case "edit":
                handleUpdate(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
        }
    }

    private String getAction(HttpServletRequest request) {
        String pathInfo = request.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            return "list";
        }
        return pathInfo.substring(1); // Remove leading slash
    }

    private void handleList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String role = request.getParameter("role");
        List<User> users;
        
        if (role != null && !role.trim().isEmpty()) {
            users = userDAO.findByRole(role);
        } else {
            users = userDAO.findAll();
        }
        
        request.setAttribute("users", users);
        request.setAttribute("selectedRole", role);
        
        request.getRequestDispatcher("/views/admin/users/list.jsp").forward(request, response);
    }

    private void handleNew(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.getRequestDispatcher("/views/admin/users/new.jsp").forward(request, response);
    }

    private void handleEdit(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String idParam = request.getParameter("id");
        if (idParam == null) {
            response.sendRedirect(request.getContextPath() + "/admin/users");
            return;
        }
        
        try {
            int userId = Integer.parseInt(idParam);
            User user = userDAO.findById(userId);
            
            if (user == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "User not found");
                return;
            }
            
            request.setAttribute("user", user);
            request.getRequestDispatcher("/views/admin/users/edit.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid user ID");
        }
    }

    private void handleCreate(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            User user = createUserFromRequest(request);
            
            // Check if username already exists
            if (userDAO.findByUsername(user.getUsername()) != null) {
                request.setAttribute("error", "Username already exists");
                request.getRequestDispatcher("/views/admin/users/new.jsp").forward(request, response);
                return;
            }
            
            if (userDAO.save(user)) {
                response.sendRedirect(request.getContextPath() + "/admin/users?success=created");
            } else {
                request.setAttribute("error", "Failed to create user");
                request.getRequestDispatcher("/views/admin/users/new.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error creating user: " + e.getMessage());
            request.getRequestDispatcher("/views/admin/users/new.jsp").forward(request, response);
        }
    }

    private void handleUpdate(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String idParam = request.getParameter("id");
        if (idParam == null) {
            response.sendRedirect(request.getContextPath() + "/admin/users");
            return;
        }
        
        try {
            int userId = Integer.parseInt(idParam);
            User user = createUserFromRequest(request);
            user.setUserId(userId);
            
            // Don't update password if not provided
            String password = request.getParameter("password");
            if (password == null || password.trim().isEmpty()) {
                User existingUser = userDAO.findById(userId);
                if (existingUser != null) {
                    user.setPasswordHash(existingUser.getPasswordHash());
                }
            }
            
            if (userDAO.update(user)) {
                response.sendRedirect(request.getContextPath() + "/admin/users?success=updated");
            } else {
                request.setAttribute("error", "Failed to update user");
                request.setAttribute("user", user);
                request.getRequestDispatcher("/views/admin/users/edit.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error updating user: " + e.getMessage());
            request.getRequestDispatcher("/views/admin/users/edit.jsp").forward(request, response);
        }
    }

    private void handleDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String idParam = request.getParameter("id");
        if (idParam == null) {
            response.sendRedirect(request.getContextPath() + "/admin/users");
            return;
        }
        
        try {
            int userId = Integer.parseInt(idParam);
            
            // Prevent admin from deleting themselves
            User currentUser = SessionUtil.getUserFromSession(request);
            if (currentUser != null && currentUser.getUserId() == userId) {
                response.sendRedirect(request.getContextPath() + "/admin/users?error=cannot_delete_self");
                return;
            }
            
            if (userDAO.delete(userId)) {
                response.sendRedirect(request.getContextPath() + "/admin/users?success=deleted");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/users?error=delete_failed");
            }
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid user ID");
        }
    }

    private User createUserFromRequest(HttpServletRequest request) throws Exception {
        User user = new User();
        
        user.setUsername(request.getParameter("username"));
        user.setEmail(request.getParameter("email"));
        user.setPhone(request.getParameter("phone"));
        user.setRole(request.getParameter("role"));
        
        String password = request.getParameter("password");
        if (password != null && !password.trim().isEmpty()) {
            user.setPasswordHash(PasswordUtil.hashPassword(password));
        }
        
        String activeStr = request.getParameter("isActive");
        user.setActive(activeStr != null && activeStr.equals("true"));
        
        return user;
    }
}
