<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register New Patient - Damak Municipality Medical System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <%@ include file="../common/header.jsp" %>
    
    <div class="main-content">
        <div class="container">
            <div class="page-header">
                <h1 class="page-title">Register New Patient</h1>
                <p class="page-subtitle">Add a new senior citizen (80+ years) to the medical management system</p>
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
                            <h5 class="mb-0">Patient Information</h5>
                        </div>
                        <div class="card-body">
                            <form action="${pageContext.request.contextPath}/patients" method="post" id="patientForm">
                                <input type="hidden" name="action" value="create">
                                
                                <!-- Patient Code -->
                                <div class="form-group">
                                    <label for="patientCode" class="form-label required">Patient Code</label>
                                    <input type="text" 
                                           id="patientCode" 
                                           name="patientCode" 
                                           class="form-control" 
                                           value="${nextPatientCode}"
                                           readonly>
                                    <div class="form-text">Auto-generated unique patient identifier</div>
                                </div>
                                
                                <!-- Personal Information -->
                                <div class="row">
                                    <div class="col-6">
                                        <div class="form-group">
                                            <label for="firstName" class="form-label required">First Name</label>
                                            <input type="text" 
                                                   id="firstName" 
                                                   name="firstName" 
                                                   class="form-control" 
                                                   value="${patient.firstName}"
                                                   required>
                                        </div>
                                    </div>
                                    <div class="col-6">
                                        <div class="form-group">
                                            <label for="lastName" class="form-label required">Last Name</label>
                                            <input type="text" 
                                                   id="lastName" 
                                                   name="lastName" 
                                                   class="form-control" 
                                                   value="${patient.lastName}"
                                                   required>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="row">
                                    <div class="col-4">
                                        <div class="form-group">
                                            <label for="dateOfBirth" class="form-label required">Date of Birth</label>
                                            <input type="date" 
                                                   id="dateOfBirth" 
                                                   name="dateOfBirth" 
                                                   class="form-control" 
                                                   value="${patient.dateOfBirth}"
                                                   max="1944-12-31"
                                                   required>
                                            <div class="form-text">Must be 80 years or older</div>
                                        </div>
                                    </div>
                                    <div class="col-4">
                                        <div class="form-group">
                                            <label for="gender" class="form-label required">Gender</label>
                                            <select id="gender" name="gender" class="form-control form-select" required>
                                                <option value="">Select Gender</option>
                                                <option value="MALE" ${patient.gender == 'MALE' ? 'selected' : ''}>Male</option>
                                                <option value="FEMALE" ${patient.gender == 'FEMALE' ? 'selected' : ''}>Female</option>
                                                <option value="OTHER" ${patient.gender == 'OTHER' ? 'selected' : ''}>Other</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-4">
                                        <div class="form-group">
                                            <label for="bloodGroup" class="form-label">Blood Group</label>
                                            <select id="bloodGroup" name="bloodGroup" class="form-control form-select">
                                                <option value="">Select Blood Group</option>
                                                <option value="A+" ${patient.bloodGroup == 'A+' ? 'selected' : ''}>A+</option>
                                                <option value="A-" ${patient.bloodGroup == 'A-' ? 'selected' : ''}>A-</option>
                                                <option value="B+" ${patient.bloodGroup == 'B+' ? 'selected' : ''}>B+</option>
                                                <option value="B-" ${patient.bloodGroup == 'B-' ? 'selected' : ''}>B-</option>
                                                <option value="AB+" ${patient.bloodGroup == 'AB+' ? 'selected' : ''}>AB+</option>
                                                <option value="AB-" ${patient.bloodGroup == 'AB-' ? 'selected' : ''}>AB-</option>
                                                <option value="O+" ${patient.bloodGroup == 'O+' ? 'selected' : ''}>O+</option>
                                                <option value="O-" ${patient.bloodGroup == 'O-' ? 'selected' : ''}>O-</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Address Information -->
                                <div class="form-group">
                                    <label for="address" class="form-label required">Address</label>
                                    <textarea id="address" 
                                              name="address" 
                                              class="form-control" 
                                              rows="2" 
                                              required>${patient.address}</textarea>
                                </div>
                                
                                <div class="row">
                                    <div class="col-6">
                                        <div class="form-group">
                                            <label for="wardNo" class="form-label required">Ward Number</label>
                                            <select id="wardNo" name="wardNo" class="form-control form-select" required>
                                                <option value="">Select Ward</option>
                                                <c:forEach begin="1" end="15" var="ward">
                                                    <option value="${ward}" ${patient.wardNo == ward ? 'selected' : ''}>
                                                        Ward ${ward}
                                                    </option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-6">
                                        <div class="form-group">
                                            <label for="phone" class="form-label">Phone Number</label>
                                            <input type="tel" 
                                                   id="phone" 
                                                   name="phone" 
                                                   class="form-control" 
                                                   value="${patient.phone}"
                                                   pattern="[0-9]{10}"
                                                   placeholder="9841234567">
                                            <div class="form-text">10-digit mobile number</div>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Guardian Information -->
                                <h6 class="mt-4 mb-3">Guardian/Caregiver Information</h6>
                                <div class="row">
                                    <div class="col-4">
                                        <div class="form-group">
                                            <label for="guardianName" class="form-label">Guardian Name</label>
                                            <input type="text" 
                                                   id="guardianName" 
                                                   name="guardianName" 
                                                   class="form-control" 
                                                   value="${patient.guardianName}">
                                        </div>
                                    </div>
                                    <div class="col-4">
                                        <div class="form-group">
                                            <label for="guardianPhone" class="form-label">Guardian Phone</label>
                                            <input type="tel" 
                                                   id="guardianPhone" 
                                                   name="guardianPhone" 
                                                   class="form-control" 
                                                   value="${patient.guardianPhone}"
                                                   pattern="[0-9]{10}">
                                        </div>
                                    </div>
                                    <div class="col-4">
                                        <div class="form-group">
                                            <label for="guardianRelation" class="form-label">Relationship</label>
                                            <select id="guardianRelation" name="guardianRelation" class="form-control form-select">
                                                <option value="">Select Relationship</option>
                                                <option value="Son" ${patient.guardianRelation == 'Son' ? 'selected' : ''}>Son</option>
                                                <option value="Daughter" ${patient.guardianRelation == 'Daughter' ? 'selected' : ''}>Daughter</option>
                                                <option value="Daughter-in-law" ${patient.guardianRelation == 'Daughter-in-law' ? 'selected' : ''}>Daughter-in-law</option>
                                                <option value="Son-in-law" ${patient.guardianRelation == 'Son-in-law' ? 'selected' : ''}>Son-in-law</option>
                                                <option value="Grandson" ${patient.guardianRelation == 'Grandson' ? 'selected' : ''}>Grandson</option>
                                                <option value="Granddaughter" ${patient.guardianRelation == 'Granddaughter' ? 'selected' : ''}>Granddaughter</option>
                                                <option value="Nephew" ${patient.guardianRelation == 'Nephew' ? 'selected' : ''}>Nephew</option>
                                                <option value="Niece" ${patient.guardianRelation == 'Niece' ? 'selected' : ''}>Niece</option>
                                                <option value="Other" ${patient.guardianRelation == 'Other' ? 'selected' : ''}>Other</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="form-group">
                                    <label for="emergencyContact" class="form-label">Emergency Contact</label>
                                    <input type="tel" 
                                           id="emergencyContact" 
                                           name="emergencyContact" 
                                           class="form-control" 
                                           value="${patient.emergencyContact}"
                                           pattern="[0-9]{10}"
                                           placeholder="Emergency contact number">
                                </div>
                                
                                <!-- Physical Information -->
                                <h6 class="mt-4 mb-3">Physical Information (Optional)</h6>
                                <div class="row">
                                    <div class="col-6">
                                        <div class="form-group">
                                            <label for="height" class="form-label">Height (cm)</label>
                                            <input type="number" 
                                                   id="height" 
                                                   name="height" 
                                                   class="form-control" 
                                                   value="${patient.height > 0 ? patient.height : ''}"
                                                   min="100" 
                                                   max="250"
                                                   step="0.1">
                                        </div>
                                    </div>
                                    <div class="col-6">
                                        <div class="form-group">
                                            <label for="weight" class="form-label">Weight (kg)</label>
                                            <input type="number" 
                                                   id="weight" 
                                                   name="weight" 
                                                   class="form-control" 
                                                   value="${patient.weight > 0 ? patient.weight : ''}"
                                                   min="20" 
                                                   max="200"
                                                   step="0.1">
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="form-group mt-4">
                                    <button type="submit" class="btn btn-primary btn-lg">
                                        Register Patient
                                    </button>
                                    <a href="${pageContext.request.contextPath}/patients" class="btn btn-secondary btn-lg">
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
                            <h6 class="mb-0">Registration Guidelines</h6>
                        </div>
                        <div class="card-body">
                            <h6 class="text-primary">Eligibility Requirements:</h6>
                            <ul class="mb-3">
                                <li>Patient must be 80 years or older</li>
                                <li>Must be a resident of Damak Municipality</li>
                                <li>Valid identification required</li>
                            </ul>
                            
                            <h6 class="text-primary">Required Information:</h6>
                            <ul class="mb-3">
                                <li>Full name and date of birth</li>
                                <li>Current address and ward number</li>
                                <li>Guardian/caregiver details</li>
                            </ul>
                            
                            <h6 class="text-primary">Next Steps:</h6>
                            <ul>
                                <li>Medical history will be recorded</li>
                                <li>QR code will be generated</li>
                                <li>Appointment can be scheduled</li>
                                <li>Family members can be added</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <%@ include file="../common/footer.jsp" %>
    
    <script>
        // Form validation
        document.getElementById('patientForm').addEventListener('submit', function(e) {
            const dateOfBirth = new Date(document.getElementById('dateOfBirth').value);
            const today = new Date();
            const age = today.getFullYear() - dateOfBirth.getFullYear();
            
            if (age < 80) {
                e.preventDefault();
                alert('Patient must be 80 years or older to be registered in this system.');
                return false;
            }
        });
        
        // Auto-calculate age display
        document.getElementById('dateOfBirth').addEventListener('change', function() {
            const dateOfBirth = new Date(this.value);
            const today = new Date();
            const age = today.getFullYear() - dateOfBirth.getFullYear();
            
            if (age >= 0) {
                const ageDisplay = document.getElementById('ageDisplay');
                if (!ageDisplay) {
                    const ageSpan = document.createElement('span');
                    ageSpan.id = 'ageDisplay';
                    ageSpan.className = 'form-text';
                    this.parentNode.appendChild(ageSpan);
                }
                document.getElementById('ageDisplay').textContent = `Age: ${age} years`;
                
                if (age < 80) {
                    document.getElementById('ageDisplay').className = 'form-text text-danger';
                    document.getElementById('ageDisplay').textContent += ' (Must be 80+)';
                } else {
                    document.getElementById('ageDisplay').className = 'form-text text-success';
                    document.getElementById('ageDisplay').textContent += ' ✓';
                }
            }
        });
        
        // Phone number formatting
        function formatPhoneNumber(input) {
            input.addEventListener('input', function() {
                this.value = this.value.replace(/\D/g, '').substring(0, 10);
            });
        }
        
        formatPhoneNumber(document.getElementById('phone'));
        formatPhoneNumber(document.getElementById('guardianPhone'));
        formatPhoneNumber(document.getElementById('emergencyContact'));
    </script>
</body>
</html>
