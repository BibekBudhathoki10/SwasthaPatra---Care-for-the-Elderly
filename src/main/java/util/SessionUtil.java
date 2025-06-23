package util;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import model.User;

public class SessionUtil {
    private static final String USER_SESSION_KEY = "currentUser";
    private static final String ROLE_SESSION_KEY = "userRole";

    public static void setUserSession(HttpServletRequest request, User user) {
        HttpSession session = request.getSession();
        session.setAttribute(USER_SESSION_KEY, user);
        session.setAttribute(ROLE_SESSION_KEY, user.getRole());
    }

    public static User getUserFromSession(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            return (User) session.getAttribute(USER_SESSION_KEY);
        }
        return null;
    }

    public static String getUserRole(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            return (String) session.getAttribute(ROLE_SESSION_KEY);
        }
        return null;
    }

    public static boolean isLoggedIn(HttpServletRequest request) {
        return getUserFromSession(request) != null;
    }

    public static boolean hasRole(HttpServletRequest request, String role) {
        String userRole = getUserRole(request);
        return userRole != null && userRole.equals(role);
    }

    public static void invalidateSession(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
    }
}
