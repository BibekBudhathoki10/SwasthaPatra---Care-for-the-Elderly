<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Damak Municipality Medical System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <%@ include file="../common/header.jsp" %>
    
    <div class="main-content">
        <div class="container">
            <div class="page-header">
                <h1 class="page-title">Administrator Dashboard</h1>
                <p class="page-subtitle">Complete system overview and management controls</p>
            </div>
            
            <!-- System Statistics -->
            <div class="dashboard-stats">
                <div class="stat-card">
                    <div class="stat-number">${totalPatients}</div>
                    <div class="stat-label">Total Patients (80+)</div>
                    <div class="stat-actions">
                        <a href="${pageContext.request.contextPath}/patients" class="btn btn-sm btn-primary">
                            View All Patients
                        </a>
                    </div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-number">${totalUsers}</div>
                    <div class="stat-label">System Users</div>
                    <div class="stat-actions">
                        <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-sm btn-primary">
                            Manage Users
                        </a>
                    </div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-number">${medicalStaffCount}</div>
                    <div class="stat-label">Medical Staff</div>
                    <div class="stat-actions">
                        <a href="${pageContext.request.contextPath}/admin/users?role=MEDICAL_STAFF" class="btn btn-sm btn-info">
                            View Staff
                        </a>
                    </div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-number">${familyMemberCount}</div>
                    <div class="stat-label">Family Members</div>
                    <div class="stat-actions">
                        <a href="${pageContext.request.contextPath}/admin/users?role=FAMILY_MEMBER" class="btn btn-sm btn-info">
                            View Families
                        </a>
                    </div>
                </div>
            </div>
            
            <!-- Quick Actions -->
            <div class="row">
                <div class="col-8">
                    <div class="card">
                        <div class="card-header">
                            <h5 class="mb-0">Quick Actions</h5>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-6">
                                    <h6 class="text-primary">Patient Management</h6>
                                    <div class="mb-3">
                                        <a href="${pageContext.request.contextPath}/patients/new" class="btn btn-success btn-sm">
                                            Register New Patient
                                        </a>
                                        <a href="${pageContext.request.contextPath}/patients" class="btn btn-info btn-sm">
                                            Search Patients
                                        </a>
                                    </div>
                                    
                                    <h6 class="text-primary">User Management</h6>
                                    <div class="mb-3">
                                        <a href="${pageContext.request.contextPath}/admin/users/new" class="btn btn-success btn-sm">
                                            Add New User
                                        </a>
                                        <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-info btn-sm">
                                            Manage Users
                                        </a>
                                    </div>
                                </div>
                                
                                <div class="col-6">
                                    <h6 class="text-primary">System Reports</h6>
                                    <div class="mb-3">
                                        <a href="${pageContext.request.contextPath}/reports/patients" class="btn btn-warning btn-sm">
                                            Patient Reports
                                        </a>
                                        <a href="${pageContext.request.contextPath}/reports/medical" class="btn btn-warning btn-sm">
                                            Medical Reports
                                        </a>
                                    </div>
                                    
                                    <h6 class="text-primary">System Settings</h6>
                                    <div class="mb-3">
                                        <a href="${pageContext.request.contextPath}/settings/system" class="btn btn-secondary btn-sm">
                                            System Settings
                                        </a>
                                        <a href="${pageContext.request.contextPath}/settings/backup" class="btn btn-secondary btn-sm">
                                            Backup & Restore
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
                            <h6 class="mb-0">System Status</h6>
                        </div>
                        <div class="card-body">
                            <div class="mb-3">
                                <div class="d-flex justify-content-between">
                                    <span>Database Status:</span>
                                    <span class="badge badge-success">Online</span>
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <div class="d-flex justify-content-between">
                                    <span>Last Backup:</span>
                                    <span class="text-muted">Today 2:00 AM</span>
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <div class="d-flex justify-content-between">
                                    <span>Active Sessions:</span>
                                    <span class="badge badge-info">5</span>
                                </div>
                            </div>
                            
                            <hr>
                            
                            <h6 class="text-primary">Recent Activity</h6>
                            <div class="text-muted">
                                <small>
                                    • New patient registered<br>
                                    • Medical staff login<br>
                                    • Report generated<br>
                                    • System backup completed
                                </small>
                            </div>
                        </div>
                    </div>
                    
                    <div class="card mt-3">
                        <div class="card-header">
                            <h6 class="mb-0">Administrator Privileges</h6>
                        </div>
                        <div class="card-body">
                            <ul class="list-unstyled mb-0">
                                <li>✓ Full system control</li>
                                <li>✓ User management</li>
                                <li>✓ Patient record access</li>
                                <li>✓ Report generation</li>
                                <li>✓ System configuration</li>
                                <li>✓ Data backup & restore</li>
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
