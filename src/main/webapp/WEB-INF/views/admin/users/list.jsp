<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Management - Damak Municipality Medical System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <%@ include file="../../common/header.jsp" %>
    
    <div class="main-content">
        <div class="container">
            <div class="page-header">
                <div class="row">
                    <div class="col-8">
                        <h1 class="page-title">User Management</h1>
                        <p class="page-subtitle">Manage system users and their access permissions</p>
                    </div>
                    <div class="col-4 text-right">
                        <a href="${pageContext.request.contextPath}/admin/users/new" class="btn btn-primary">
                            Add New User
                        </a>
                    </div>
                </div>
            </div>
            
            <!-- User Statistics -->   
            <div class="dashboard-stats">
                <div class="stat-card">
                    <div class="stat-number">${adminCount}</div>
                    <div class="stat-label">Administrators</div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-number">${medicalStaffCount}</div>
                    <div class="stat-label">Medical Staff</div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-number">${familyMemberCount}</div>
                    <div class="stat-label">Family Members</div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-number">${adminCount + medicalStaffCount + familyMemberCount}</div>
                    <div class="stat-label">Total Users</div>
                </div>
            </div>
            
            <!-- Messages -->
            <c:if test="${not empty param.message}">
                <div class="alert alert-success">
                    ${param.message}
                </div>
            </c:if>
            
            <c:if test="${not empty param.error}">
                <div class="alert alert-danger">
                    ${param.error}
                </div>
            </c:if>
            
            <!-- Users Table -->
            <div class="card">
                <div class="card-header">
                    <h5 class="mb-0">System Users</h5>
                </div>
                <div class="card-body">
                    <c:choose>
                        <c:when test="${empty users}">
                            <div class="text-center text-muted">
                                <p>No users found.</p>
                                <a href="${pageContext.request.contextPath}/admin/users/new" class="btn btn-primary">
                                    Add First User
                                </a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="table-responsive">
                                <table class="table table-striped table-hover">
                                    <thead>
                                        <tr>
                                            <th>Username</th>
                                            <th>Full Name</th>
                                            <th>Role</th>
                                            <th>Staff Type</th>
                                            <th>Email</th>
                                            <th>Phone</th>
                                            <th>Status</th>
                                            <th>Created</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="user" items="${users}">
                                            <tr>
                                                <td>
                                                    <strong class="text-primary">${user.username}</strong>
                                                </td>
                                                <td>
                                                    <a href="${pageContext.request.contextPath}/admin/users/${user.userId}" 
                                                       class="text-decoration-none">
                                                        ${user.fullName}
                                                    </a>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${user.role == 'ADMIN'}">
                                                            <span class="badge badge-danger">Administrator</span>
                                                        </c:when>
                                                        <c:when test="${user.role == 'MEDICAL_STAFF'}">
                                                            <span class="badge badge-success">Medical Staff</span>
                                                        </c:when>
                                                        <c:when test="${user.role == 'FAMILY_MEMBER'}">
                                                            <span class="badge badge-info">Family Member</span>
                                                        </c:when>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <c:if test="${user.role == 'MEDICAL_STAFF'}">
                                                        <span class="badge badge-light">${user.staffType}</span>
                                                        <c:if test="${not empty user.licenseNumber}">
                                                            <br><small class="text-muted">${user.licenseNumber}</small>
                                                        </c:if>
                                                    </c:if>
                                                </td>
                                                <td>${user.email}</td>
                                                <td>${user.phone}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${user.active}">
                                                            <span class="badge badge-success">Active</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge badge-secondary">Inactive</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <fmt:formatDate value="${user.createdAt}" pattern="MMM dd, yyyy"/>
                                                </td>
                                                <td>
                                                    <div class="btn-group">
                                                        <a href="${pageContext.request.contextPath}/admin/users/${user.userId}" 
                                                           class="btn btn-sm btn-info" title="View Details">
                                                            View
                                                        </a>
                                                        <a href="${pageContext.request.contextPath}/admin/users/${user.userId}/edit" 
                                                           class="btn btn-sm btn-warning" title="Edit User">
                                                            Edit
                                                        </a>
                                                        <c:if test="${user.userId != sessionScope.currentUser.userId}">
                                                            <button type="button" 
                                                                    class="btn btn-sm btn-danger" 
                                                                    onclick="confirmDeactivate(${user.userId}, '${user.fullName}')"
                                                                    title="Deactivate User">
                                                                Deactivate
                                                            </button>
                                                        </c:if>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
    
    <%@ include file="../../common/footer.jsp" %>
    
    <!-- Deactivate User Modal -->
    <div id="deactivateModal" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); z-index: 1000;">
        <div style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); background: white; padding: 2rem; border-radius: 8px; max-width: 400px; width: 90%;">
            <h5>Confirm User Deactivation</h5>
            <p>Are you sure you want to deactivate <strong id="userName"></strong>?</p>
            <p class="text-muted">This action will prevent the user from logging into the system.</p>
            
            <form id="deactivateForm" method="post" action="${pageContext.request.contextPath}/admin/users">
                <input type="hidden" name="action" value="deactivate">
                <input type="hidden" name="userId" id="deactivateUserId">
                
                <div class="text-right">
                    <button type="button" class="btn btn-secondary" onclick="closeDeactivateModal()">
                        Cancel
                    </button>
                    <button type="submit" class="btn btn-danger">
                        Deactivate User
                    </button>
                </div>
            </form>
        </div>
    </div>
    
    <script>
        function confirmDeactivate(userId, userName) {
            document.getElementById('deactivateUserId').value = userId;
            document.getElementById('userName').textContent = userName;
            document.getElementById('deactivateModal').style.display = 'block';
        }
        
        function closeDeactivateModal() {
            document.getElementById('deactivateModal').style.display = 'none';
        }
        
        // Close modal when clicking outside
        document.getElementById('deactivateModal').addEventListener('click', function(e) {
            if (e.target === this) {
                closeDeactivateModal();
            }
        });
    </script>
</body>
</html>
