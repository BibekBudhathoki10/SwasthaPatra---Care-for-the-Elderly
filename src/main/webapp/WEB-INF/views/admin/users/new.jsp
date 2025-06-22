<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New User - Damak Municipality Medical System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <%@ include file="../../common/header.jsp" %>
    
    <div class="main-content">
        <div class="container">
            <div class="page-header">
                <h1 class="page-title">Add New User</h1>
                <p class="page-subtitle">Create a new system user account</p>
            </div>
            
            <c:if test="${not empty error}">
                <div class="alert alert-danger">
                    ${error}
                </div>
            </c:if>
            
            <div class="row">
                <div class="col-8">
                    <div class="card">
                        <div class="card-header">
                            <h5 class="mb-0">User Information</h5>
                        </div>
                        <div class="card-body">
                            <form action="${pageContext.request.contextPath}/admin/users" method="post" id="userForm">
                                <input type="hidden" name="action" value="create">
                                
                                <!-- Login Credentials -->
                                <h6 class="text-primary mb-3">Login Credentials</h6>
                                <div class="row">
                                    <div class="col-6">
                                        <div class="form-group">
                                            <label for="username" class="form-label required">Username</label>
                                            <input type="text" 
                                                   id="username" 
                                                   name="username" 
                                                   class="form-control" 
                                                   required
                                                   pattern="[a-zA-Z0-9_]{3,20}"
                                                   title="3-20 characters, letters, numbers, and underscore only">
                                            <div class="form-text">3-20 characters, letters, numbers, and underscore only</div>
                                        </div>
                                    </div>
                                    <div class="col-6">
                                        <div class="form-group">
                                            <label for="password" class="form-label required">Password</label>
                                            <input type="password" 
                                                   id="password" 
                                                   name="password" 
                                                   class="form-control" 
                                                   required
                                                   minlength="6">
                                            <div class="form-text">Minimum 6 characters</div>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Personal Information -->
                                <h6 class="text-primary mb-3 mt-4">Personal Information</h6>
                                <div class="form-group">
                                    <label for="fullName" class="form-label required">Full Name</label>
                                    <input type="text" 
                                           id="fullName" 
                                           name="fullName" 
                                           class="form-control" 
                                           required>
                                </div>
                                
                                <div class="row">
                                    <div class="col-6">
                                        <div class="form-group">
                                            <label for="email" class="form-label">Email Address</label>
                                            <input type="email" 
                                                   id="email" 
                                                   name="email" 
                                                   class="form-control">
                                        </div>
                                    </div>
                                    <div class="col-6">
                                        <div class="form-group">
                                            <label for="phone" class="form-label">Phone Number</label>
                                            <input type="tel" 
                                                   id="phone" 
                                                   name="phone" 
                                                   class="form-control"
                                                   pattern="[0-9]{10}"
                                                   placeholder="9841234567">
                                            <div class="form-text">10-digit mobile number</div>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Role and Permissions -->
                                <h6 class="text-primary mb-3 mt-4">Role and Permissions</h6>
                                <div class="form-group">
                                    <label for="role" class="form-label required">User Role</label>
                                    <select id="role" name="role" class="form-control form-select" required onchange="toggleStaffFields()">
                                        <option value="">Select Role</option>
                                        <option value="ADMIN">Administrator (Municipality Officer)</option>
                                        <option value="MEDICAL_STAFF">Medical Staff (Doctor/Nurse/Pharmacist)</option>
                                        <option value="FAMILY_MEMBER">Family Member/Caregiver</option>
                                    </select>
                                </div>
                                
                                <!-- Medical Staff Specific Fields -->
                                <div id="medicalStaffFields" style="display: none;">
                                    <div class="row">
                                        <div class="col-6">
                                            <div class="form-group">
                                                <label for="staffType" class="form-label required">Staff Type</label>
                                                <select id="staffType" name="staffType" class="form-control form-select">
                                                    <option value="">Select Staff Type</option>
                                                    <option value="DOCTOR">Doctor</option>
                                                    <option value="NURSE">Nurse</option>
                                                    <option value="PHARMACIST">Pharmacist</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-6">
                                            <div class="form-group">
                                                <label for="licenseNumber" class="form-label">License Number</label>
                                                <input type="text" 
                                                       id="licenseNumber" 
                                                       name="licenseNumber" 
                                                       class="form-control"
                                                       placeholder="e.g., NMC-12345">
                                                <div class="form-text">Professional license number (if applicable)</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="form-group mt-4">
                                    <button type="submit" class="btn btn-primary btn-lg">
                                        Create User
                                    </button>
                                    <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-secondary btn-lg">
                                        Cancel
                                    </a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                
                <div class="col-4">
                    <div class="card">
                        <div class="card-header">
                            <h6 class="mb-0">Role Descriptions</h6>
                        </div>
                        <div class="card-body">
                            <h6 class="text-danger">👤 Administrator</h6>
                            <ul class="mb-3">
                                <li>Full system control</li>
                                <li>User management</li>
                                <li>System configuration</li>
                                <li>Report generation</li>
                                <li>Data backup & restore</li>
                            </ul>
                            
                            <h6 class="text-success">🧑‍⚕️ Medical Staff</h6>
                            <ul class="mb-3">
                                <li>Patient record management</li>
                                <li>Medical history updates</li>
                                <li>Prescription writing (Doctors)</li>
                                <li>Medication dispensing (Pharmacists)</li>
                                <li>Appointment scheduling</li>
                            </ul>
                            
                            <h6 class="text-info">👨‍👩‍👦 Family Member</h6>
                            <ul class="mb-3">
                                <li>Read-only patient access</li>
                                <li>View medical reports</li>
                                <li>Receive health alerts</li>
                                <li>Monitor appointments</li>
                                <li>Medication reminders</li>
                            </ul>
                        </div>
                    </div>
                    
                    <div class="card mt-3">
                        <div class="card-header">
                            <h6 class="mb-0">Security Guidelines</h6>
                        </div>
                        <div class="card-body">
                            <ul class="mb-0">
                                <li>Use strong, unique passwords</li>
                                <li>Verify user identity before creation</li>
                                <li>Assign minimum required permissions</li>
                                <li>Regular password updates recommended</li>
                                <li>Monitor user activity logs</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <%@ include file="../../common/footer.jsp" %>
    
    <script>
        function toggleStaffFields() {
            const role = document.getElementById('role').value;
            const staffFields = document.getElementById('medicalStaffFields');
            const staffType = document.getElementById('staffType');
            
            if (role === 'MEDICAL_STAFF') {
                staffFields.style.display = 'block';
                staffType.required = true;
            } else {
                staffFields.style.display = 'none';
                staffType.required = false;
                staffType.value = '';
                document.getElementById('licenseNumber').value = '';
            }
        }
        
        // Phone number formatting
        document.getElementById('phone').addEventListener('input', function() {
            this.value = this.value.replace(/\D/g, '').substring(0, 10);
        });
        
        // Form validation
        document.getElementById('userForm').addEventListener('submit', function(e) {
            const role = document.getElementById('role').value;
            const staffType = document.getElementById('staffType').value;
            
            if (role === 'MEDICAL_STAFF' && !staffType) {
                e.preventDefault();
                alert('Please select a staff type for medical staff users.');
                return false;
            }
        });
    </script>
</body>
</html>
