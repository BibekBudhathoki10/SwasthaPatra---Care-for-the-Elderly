<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<footer style="background-color: var(--dark-color); color: white; padding: 2rem 0; margin-top: 3rem;">
    <div class="container">
        <div class="row">
            <div class="col-4">
                <h6>Damak Municipality</h6>
                <p class="mb-2">Medical Management System</p>
                <p class="mb-0">
                    <small>
                        Dedicated to providing quality healthcare<br>
                        services to our senior citizens (80+)
                    </small>
                </p>
            </div>
            
            <div class="col-4">
                <h6>Contact Information</h6>
                <p class="mb-1">
                    <strong>Address:</strong><br>
                    Damak Municipality Office<br>
                    Jhapa, Nepal
                </p>
                <p class="mb-1">
                    <strong>Phone:</strong> 023-123456<br>
                    <strong>Emergency:</strong> 102
                </p>
            </div>
            
            <div class="col-4">
                <h6>Quick Links</h6>
                <ul style="list-style: none; padding: 0;">
                    <li><a href="${pageContext.request.contextPath}/dashboard" style="color: #ccc; text-decoration: none;">Dashboard</a></li>
                    <li><a href="${pageContext.request.contextPath}/patients" style="color: #ccc; text-decoration: none;">Patients</a></li>
                    <li><a href="${pageContext.request.contextPath}/help" style="color: #ccc; text-decoration: none;">Help & Support</a></li>
                    <li><a href="${pageContext.request.contextPath}/about" style="color: #ccc; text-decoration: none;">About System</a></li>
                </ul>
            </div>
        </div>
        
        <hr style="border-color: #555; margin: 1.5rem 0;">
        
        <div class="text-center">
            <small>
                © 2024 Damak Municipality Medical Management System. 
                All rights reserved. | 
                <a href="${pageContext.request.contextPath}/privacy" style="color: #ccc;">Privacy Policy</a> | 
                <a href="${pageContext.request.contextPath}/terms" style="color: #ccc;">Terms of Service</a>
            </small>
        </div>
    </div>
</footer>
