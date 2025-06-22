<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Medical Staff Dashboard - Damak Municipality Medical System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <%@ include file="../common/header.jsp" %>
    
    <div class="main-content">
        <div class="container">
            <div class="page-header">
                <h1 class="page-title">
                    ${staffType} Dashboard
                </h1>
                <p class="page-subtitle">
                    Welcome, ${sessionScope.currentUser.fullName} - 
                    Manage patient care and medical records
                </p>
            </div>
            
            <!-- Medical Staff Statistics -->
            <div class="dashboard-stats">
                <div class="stat-card">
                    <div class="stat-number">${totalPatients}</div>
                    <div class="stat-label">Total Patients</div>
                    <div class="stat-actions">
                        <a href="${pageContext.request.contextPath}/patients" class="btn btn-sm btn-primary">
                            View Patients
                        </a>
                    </div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-number">0</div>
                    <div class="stat-label">Today's Appointments</div>
                    <div class="stat-actions">
                        <a href="${pageContext.request.contextPath}/appointments" class="btn btn-sm btn-info">
                            View Schedule
                        </a>
                    </div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-number">0</div>
                    <div class="stat-label">Pending Prescriptions</div>
                    <div class="stat-actions">
                        <a href="${pageContext.request.contextPath}/prescriptions" class="btn btn-sm btn-warning">
                            Review
                        </a>
                    </div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-number">0</div>
                    <div class="stat-label">Critical Alerts</div>
                    <div class="stat-actions">
                        <a href="${pageContext.request.contextPath}/alerts" class="btn btn-sm btn-danger">
                            View Alerts
                        </a>
                    </div>
                </div>
            </div>
            
            <!-- Medical Staff Actions -->
            <div class="row">
                <div class="col-8">
                    <div class="card">
                        <div class="card-header">
                            <h5 class="mb-0">Medical Actions</h5>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-6">
                                    <h6 class="text-primary">Patient Care</h6>
                                    <div class="mb-3">
                                        <a href="${pageContext.request.contextPath}/patients/new" class="btn btn-success btn-sm">
                                            Register New Patient
                                        </a>
                                        <a href="${pageContext.request.contextPath}/patients" class="btn btn-info btn-sm">
                                            Search Patients
                                        </a>
                                    </div>
                                    
                                    <h6 class="text-primary">Medical Records</h6>
                                    <div class="mb-3">
                                        <a href="${pageContext.request.contextPath}/medical-records/new" class="btn btn-success btn-sm">
                                            Add Medical Record
                                        </a>
                                        <a href="${pageContext.request.contextPath}/medical-records" class="btn btn-info btn-sm">
                                            View Records
                                        </a>
                                    </div>
                                </div>
                                
                                <div class="col-6">
                                    <c:if test="${staffType == 'DOCTOR'}">
                                        <h6 class="text-primary">Prescriptions</h6>
                                        <div class="mb-3">
                                            <a href="${pageContext.request.contextPath}/prescriptions/new" class="btn btn-success btn-sm">
                                                Write Prescription
                                            </a>
                                            <a href="${pageContext.request.contextPath}/prescriptions" class="btn btn-info btn-sm">
                                                View Prescriptions
                                            </a>
                                        </div>
                                    </c:if>
                                    
                                    <h6 class="text-primary">Appointments</h6>
                                    <div class="mb-3">
                                        <a href="${pageContext.request.contextPath}/appointments/new" class="btn btn-success btn-sm">
                                            Schedule Appointment
                                        </a>
                                        <a href="${pageContext.request.contextPath}/appointments" class="btn btn-info btn-sm">
                                            View Schedule
                                        </a>
                                    </div>
                                    
                                    <c:if test="${staffType == 'NURSE'}">
                                        <h6 class="text-primary">Vital Signs</h6>
                                        <div class="mb-3">
                                            <a href="${pageContext.request.contextPath}/vitals/record" class="btn btn-success btn-sm">
                                                Record Vitals
                                            </a>
                                            <a href="${pageContext.request.contextPath}/vitals" class="btn btn-info btn-sm">
                                                View History
                                            </a>
                                        </div>
                                    </c:if>
                                    
                                    <c:if test="${staffType == 'PHARMACIST'}">
                                        <h6 class="text-primary">Medication Management</h6>
                                        <div class="mb-3">
                                            <a href="${pageContext.request.contextPath}/medications/dispense" class="btn btn-success btn-sm">
                                                Dispense Medicine
                                            </a>
                                            <a href="${pageContext.request.contextPath}/medications/inventory" class="btn btn-info btn-sm">
                                                Manage Inventory
                                            </a>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-4">
                    <div class="card">
                        <div class="card-header">
                            <h6 class="mb-0">Your Profile</h6>
                        </div>
                        <div class="card-body">
                            <div class="mb-2">
                                <strong>Name:</strong> ${sessionScope.currentUser.fullName}
                            </div>
                            <div class="mb-2">
                                <strong>Role:</strong> ${staffType}
                            </div>
                            <c:if test="${not empty sessionScope.currentUser.licenseNumber}">
                                <div class="mb-2">
                                    <strong>License:</strong> ${sessionScope.currentUser.licenseNumber}
                                </div>
                            </c:if>
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
                            <h6 class="mb-0">${staffType} Privileges</h6>
                        </div>
                        <div class="card-body">
                            <ul class="list-unstyled mb-0">
                                <li>✓ Patient record access</li>
                                <li>✓ Medical history updates</li>
                                <li>✓ Appointment scheduling</li>
                                <c:if test="${staffType == 'DOCTOR'}">
                                    <li>✓ Prescription writing</li>
                                    <li>✓ Diagnosis recording</li>
                                </c:if>
                                <c:if test="${staffType == 'NURSE'}">
                                    <li>✓ Vital signs recording</li>
                                    <li>✓ Patient monitoring</li>
                                </c:if>
                                <c:if test="${staffType == 'PHARMACIST'}">
                                    <li>✓ Medication dispensing</li>
                                    <li>✓ Inventory management</li>
                                </c:if>
                                <li>✓ Lab report viewing</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <%@ include file="../common/footer.jsp" %>
</body>
</html>
