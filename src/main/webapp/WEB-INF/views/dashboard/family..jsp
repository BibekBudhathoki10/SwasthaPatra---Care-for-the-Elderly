<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Family Member Dashboard - Damak Municipality Medical System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <%@ include file="../common/header.jsp" %>
    
    <div class="main-content">
        <div class="container">
            <div class="page-header">
                <h1 class="page-title">Family Member Dashboard</h1>
                <p class="page-subtitle">
                    Welcome, ${sessionScope.currentUser.fullName} - 
                    Monitor your family member's health and care
                </p>
            </div>
            
            <!-- Family Member Statistics -->
            <div class="dashboard-stats">
                <div class="stat-card">
                    <div class="stat-number">0</div>
                    <div class="stat-label">Assigned Patients</div>
                    <div class="stat-actions">
                        <a href="${pageContext.request.contextPath}/family/patients" class="btn btn-sm btn-primary">
                            View Patients
                        </a>
                    </div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-number">0</div>
                    <div class="stat-label">Upcoming Appointments</div>
                    <div class="stat-actions">
                        <a href="${pageContext.request.contextPath}/family/appointments" class="btn btn-sm btn-info">
                            View Schedule
                        </a>
                    </div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-number">0</div>
                    <div class="stat-label">Active Medications</div>
                    <div class="stat-actions">
                        <a href="${pageContext.request.contextPath}/family/medications" class="btn btn-sm btn-warning">
                            View Medications
                        </a>
                    </div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-number">0</div>
                    <div class="stat-label">New Alerts</div>
                    <div class="stat-actions">
                        <a href="${pageContext.request.contextPath}/family/alerts" class="btn btn-sm btn-danger">
                            View Alerts
                        </a>
                    </div>
                </div>
            </div>
            
            <!-- Family Member Actions -->
            <div class="row">
                <div class="col-8">
                    <div class="card">
                        <div class="card-header">
                            <h5 class="mb-0">Patient Care Overview</h5>
                        </div>
                        <div class="card-body">
                            <div class="alert alert-info">
                                <h6>Welcome to the Family Member Portal</h6>
                                <p class="mb-0">
                                    As a registered family member, you have read-only access to view your 
                                    assigned patient's medical information, appointments, and receive important 
                                    health alerts and reminders.
                                </p>
                            </div>
                            
                            <div class="row">
                                <div class="col-6">
                                    <h6 class="text-primary">Patient Information</h6>
                                    <div class="mb-3">
                                        <a href="${pageContext.request.contextPath}/family/patients" class="btn btn-info btn-sm">
                                            View Patient Details
                                        </a>
                                        <a href="${pageContext.request.contextPath}/family/medical-history" class="btn btn-info btn-sm">
                                            Medical History
                                        </a>
                                    </div>
                                    
                                    <h6 class="text-primary">Health Monitoring</h6>
                                    <div class="mb-3">
                                        <a href="${pageContext.request.contextPath}/family/vitals" class="btn btn-info btn-sm">
                                            Vital Signs History
                                        </a>
                                        <a href="${pageContext.request.contextPath}/family/lab-reports" class="btn btn-info btn-sm">
                                            Lab Reports
                                        </a>
                                    </div>
                                </div>
                                
                                <div class="col-6">
                                    <h6 class="text-primary">Appointments & Care</h6>
                                    <div class="mb-3">
                                        <a href="${pageContext.request.contextPath}/family/appointments" class="btn btn-info btn-sm">
                                            Appointment History
                                        </a>
                                        <a href="${pageContext.request.contextPath}/family/medications" class="btn btn-info btn-sm">
                                            Current Medications
                                        </a>
                                    </div>
                                    
                                    <h6 class="text-primary">Notifications</h6>
                                    <div class="mb-3">
                                        <a href="${pageContext.request.contextPath}/family/alerts" class="btn btn-warning btn-sm">
                                            Health Alerts
                                        </a>
                                        <a href="${pageContext.request.contextPath}/family/reminders" class="btn btn-warning btn-sm">
                                            Medication Reminders
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-4">
                    <div class="card">
                        <div class="card-header">
                            <h6 class="mb-0">Your Information</h6>
                        </div>
                        <div class="card-body">
                            <div class="mb-2">
                                <strong>Name:</strong> ${sessionScope.currentUser.fullName}
                            </div>
                            <div class="mb-2">
                                <strong>Role:</strong> Family Member
                            </div>
                            <div class="mb-2">
                                <strong>Email:</strong> ${sessionScope.currentUser.email}
                            </div>
                            <div class="mb-3">
                                <strong>Phone:</strong> ${sessionScope.currentUser.phone}
                            </div>
                            
                            <a href="${pageContext.request.contextPath}/profile" class="btn btn-sm btn-secondary">
                                Update Profile
                            </a>
                        </div>
                    </div>
                    
                    <div class="card mt-3">
                        <div class="card-header">
                            <h6 class="mb-0">Family Member Access</h6>
                        </div>
                        <div class="card-body">
                            <ul class="list-unstyled mb-0">
                                <li>✓ View patient information</li>
                                <li>✓ Access medical history</li>
                                <li>✓ View appointment schedule</li>
                                <li>✓ Monitor medications</li>
                                <li>✓ Receive health alerts</li>
                                <li>✓ View lab reports</li>
                                <li>✓ Get appointment reminders</li>
                            </ul>
                            
                            <div class="mt-3 p-2 bg-light rounded">
                                <small class="text-muted">
                                    <strong>Note:</strong> You have read-only access. 
                                    Contact medical staff for any changes or concerns.
                                </small>
                            </div>
                        </div>
                    </div>
                    
                    <div class="card mt-3">
                        <div class="card-header">
                            <h6 class="mb-0">Emergency Contacts</h6>
                        </div>
                        <div class="card-body">
                            <div class="mb-2">
                                <strong>Damak Health Center:</strong><br>
                                <span class="text-primary">023-123456</span>
                            </div>
                            <div class="mb-2">
                                <strong>Emergency:</strong><br>
                                <span class="text-danger">102 / 911</span>
                            </div>
                            <div class="mb-2">
                                <strong>Municipality Office:</strong><br>
                                <span class="text-info">023-654321</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <%@ include file="../common/footer.jsp" %>
</body>
</html>
