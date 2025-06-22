<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<header class="header">
    <div class="container">
        <div class="header-content">
            <div class="logo">
                <img src="${pageContext.request.contextPath}/images/damak-logo.png" alt="Damak Municipality" onerror="this.style.display='none'">
                <span>Damak Medical System</span>
            </div>
            
            <nav class="nav-menu">
                <c:choose>
                    <c:when test="${sessionScope.currentUser.role == 'ADMIN'}">
                        <!-- Admin Navigation -->
                        <ul class="nav-menu">
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/dashboard/admin" class="nav-link">
                                    Dashboard
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/patients" class="nav-link">
                                    Patients
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/admin/users" class="nav-link">
                                    User Management
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/reports" class="nav-link">
                                    Reports
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/settings" class="nav-link">
                                    Settings
                                </a>
                            </li>
                        </ul>
                    </c:when>
                    
                    <c:when test="${sessionScope.currentUser.role == 'MEDICAL_STAFF'}">
                        <!-- Medical Staff Navigation -->
                        <ul class="nav-menu">
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/dashboard/medical" class="nav-link">
                                    Dashboard
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/patients" class="nav-link">
                                    Patients
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/appointments" class="nav-link">
                                    Appointments
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/medications" class="nav-link">
                                    Medications
                                </a>
                            </li>
                            <c:if test="${sessionScope.currentUser.staffType == 'DOCTOR'}">
                                <li class="nav-item">
                                    <a href="${pageContext.request.contextPath}/prescriptions" class="nav-link">
                                        Prescriptions
                                    </a>
                                </li>
                            </c:if>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/lab-reports" class="nav-link">
                                    Lab Reports
                                </a>
                            </li>
                        </ul>
                    </c:when>
                    
                    <c:when test="${sessionScope.currentUser.role == 'FAMILY_MEMBER'}">
                        <!-- Family Member Navigation -->
                        <ul class="nav-menu">
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/dashboard/family" class="nav-link">
                                    Dashboard
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/family/patients" class="nav-link">
                                    My Patients
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/family/appointments" class="nav-link">
                                    Appointments
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/family/alerts" class="nav-link">
                                    Alerts
                                </a>
                            </li>
                        </ul>
                    </c:when>
                </c:choose>
            </nav>
            
            <div class="user-info">
                <div class="user-avatar">
                    ${sessionScope.currentUser.fullName.substring(0,1).toUpperCase()}
                </div>
                <div class="user-details">
                    <div class="user-name">${sessionScope.currentUser.fullName}</div>
                    <div class="user-role">
                        <c:choose>
                            <c:when test="${sessionScope.currentUser.role == 'ADMIN'}">
                                Municipality Officer
                            </c:when>
                            <c:when test="${sessionScope.currentUser.role == 'MEDICAL_STAFF'}">
                                ${sessionScope.currentUser.staffType}
                                <c:if test="${not empty sessionScope.currentUser.licenseNumber}">
                                    (${sessionScope.currentUser.licenseNumber})
                                </c:if>
                            </c:when>
                            <c:when test="${sessionScope.currentUser.role == 'FAMILY_MEMBER'}">
                                Family Member
                            </c:when>
                        </c:choose>
                    </div>
                </div>
                <div class="user-actions">
                    <a href="${pageContext.request.contextPath}/profile" class="nav-link" title="Profile">
                        Profile
                    </a>
                    <a href="${pageContext.request.contextPath}/logout" class="nav-link" title="Logout">
                        Logout
                    </a>
                </div>
            </div>
        </div>
    </div>
</header>

<style>
.user-info {
    display: flex;
    align-items: center;
    gap: 1rem;
}

.user-details {
    display: flex;
    flex-direction: column;
    align-items: flex-start;
}

.user-name {
    font-weight: 600;
    font-size: 0.9rem;
}

.user-role {
    font-size: 0.75rem;
    opacity: 0.8;
}

.user-actions {
    display: flex;
    gap: 0.5rem;
}

.user-actions .nav-link {
    padding: 0.25rem 0.5rem;
    font-size: 0.8rem;
}

@media (max-width: 768px) {
    .user-details {
        display: none;
    }
    
    .user-actions {
        flex-direction: column;
    }
}
</style>
