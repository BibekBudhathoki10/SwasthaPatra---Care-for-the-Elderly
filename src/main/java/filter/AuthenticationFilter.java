package filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import util.SessionUtil;

import java.io.IOException;

@WebFilter("/*")
public class AuthenticationFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization code if needed
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        String requestURI = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();
        
        // Allow access to login page, static resources, and public endpoints
        if (isPublicResource(requestURI, contextPath)) {
            chain.doFilter(request, response);
            return;
        }
        
        // Check if user is logged in
        if (!SessionUtil.isLoggedIn(httpRequest)) {
            httpResponse.sendRedirect(contextPath + "/login");
            return;
        }
        
        // Check role-based access
        if (!hasRequiredAccess(httpRequest)) {
            httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied");
            return;
        }
        
        chain.doFilter(request, response);
    }

    private boolean isPublicResource(String requestURI, String contextPath) {
        String path = requestURI.substring(contextPath.length());
        
        return path.equals("/") ||
               path.equals("/login") ||
               path.startsWith("/css/") ||
               path.startsWith("/js/") ||
               path.startsWith("/images/") ||
               path.startsWith("/static/") ||
               path.equals("/favicon.ico");
    }

    private boolean hasRequiredAccess(HttpServletRequest request) {
        String requestURI = request.getRequestURI();
        String contextPath = request.getContextPath();
        String path = requestURI.substring(contextPath.length());
        String userRole = SessionUtil.getUserRole(request);
        
        if (userRole == null) {
            return false;
        }
        
        // Admin has access to everything
        if ("ADMIN".equals(userRole)) {
            return true;
        }
        
        // Medical staff access
        if ("MEDICAL_STAFF".equals(userRole)) {
            return !path.startsWith("/admin/");
        }
        
        // Family member access (limited)
        if ("FAMILY_MEMBER".equals(userRole)) {
            return path.startsWith("/dashboard") ||
                   path.startsWith("/patients/view") ||
                   path.startsWith("/appointments/") ||
                   path.startsWith("/notifications/");
        }
        
        return false;
    }

    @Override
    public void destroy() {
        // Cleanup code if needed
    }
}
