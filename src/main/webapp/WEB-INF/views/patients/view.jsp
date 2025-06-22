<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Patient Profile - ${patient.fullName} - Damak Medical System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <%@ include file="../common/header.jsp" %>
    
    <div class="main-content">
        <div class="container">
            <!-- Patient Header -->
            <div class="card">
                <div class="patient-header">
                    <div class="row">
                        <div class="col-2">
                            <div class="patient-avatar">
                                ${patient.firstName.substring(0,1)}${patient.lastName.substring(0,1)}
                            </div>
                        </div>
                        <div class="col-6">
                            <h2 class="patient-name">${patient.fullName}</h2>
                            <div class="patient-info">
                                <div class="patient-detail">
                                    <div class="patient-detail-label">Patient Code</div>
                                    <div class="patient-detail-value">${patient.patientCode}</div>
                                </div>
                                <div class="patient-detail">
                                    <div class="patient-detail-label">Age</div>
                                    <div class="patient-detail-value">${patient.age} years</div>
                                </div>
                                <div class="patient-detail">
                                    <div class="patient-detail-label">Gender</div>
                                    <div class="patient-detail-value">${patient.gender}</div>
                                </div>
                                <div class="patient-detail">
                                    <div class="patient-detail-label">Ward</div>
                                    <div class="patient-detail-value">Ward ${patient.wardNo}</div>
                                </div>
                            </div>
                        </div>
                        <div class="col-4 text-right">
                            <c:if test="${sessionScope.currentUser.role == 'ADMIN' || sessionScope.currentUser.role == 'MEDICAL_STAFF'}">
                                <a href="${pageContext.request.contextPath}/patients/${patient.patientId}/edit" 
                                   class="btn btn-warning">
                                    Edit Patient
                                </a>
                                <a href="${pageContext.request.contextPath}/medical-records/new?patientId=${patient.patientId}" 
                                   class="btn btn-success">
                                    Add Medical Record
                                </a>
                                <a href="${pageContext.request.contextPath}/appointments/new?patientId=${patient.patientId}" 
                                   class="btn btn-info">
                                    Schedule Appointment
                                </a>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Messages -->
            <c:if test="${not empty param.message}">
                <div class="alert alert-success">
                    ${param.message}
                </div>
            </c:if>
            
            <!-- Patient Information Tabs -->
            <div class="row mt-4">
                <div class="col-4">
                    <!-- Personal Information -->
                    <div class="card">
                        <div class="card-header">
                            <h6 class="mb-0">Personal Information</h6>
                        </div>
                        <div class="card-body">
                            <div class="row mb-2">
                                <div class="col-5"><strong>Date of Birth:</strong></div>
                                <div class="col-7">
                                    <fmt:formatDate value="${patient.dateOfBirth}" pattern="MMM dd, yyyy"/>
                                </div>
                            </div>
                            <div class="row mb-2">
                                <div class="col-5"><strong>Blood Group:</strong></div>
                                <div class="col-7">
                                    <c:choose>
                                        <c:when test="${not empty patient.bloodGroup}">
                                            <span class="badge badge-info">${patient.bloodGroup}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted">Not recorded</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                            <div class="row mb-2">
                                <div class="col-5"><strong>Height:</strong></div>
                                <div class="col-7">
                                    <c:choose>
                                        <c:when test="${patient.height > 0}">
                                            ${patient.height} cm
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted">Not recorded</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                            <div class="row mb-2">
                                <div class="col-5"><strong>Weight:</strong></div>
                                <div class="col-7">
                                    <c:choose>
                                        <c:when test="${patient.weight > 0}">
                                            ${patient.weight} kg
                                            <c:if test="${patient.BMI > 0}">
                                                <br><small class="text-muted">BMI: ${patient.BMI} (${patient.BMICategory})</small>
                                            </c:if>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted">Not recorded</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                            <div class="row mb-2">
                                <div class="col-5"><strong>Phone:</strong></div>
                                <div class="col-7">
                                    <c:choose>
                                        <c:when test="${not empty patient.phone}">
                                            <a href="tel:${patient.phone}" class="text-primary">${patient.phone}</a>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted">Not provided</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                            <div class="row mb-2">
                                <div class="col-5"><strong>Address:</strong></div>
                                <div class="col-7">${patient.address}</div>
                            </div>
                            <div class="row mb-2">
                                <div class="col-5"><strong>Registered:</strong></div>
                                <div class="col-7">
                                    <fmt:formatDate value="${patient.registrationDate}" pattern="MMM dd, yyyy"/>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Guardian Information -->
                    <div class="card mt-3">
                        <div class="card-header">
                            <h6 class="mb-0">Guardian/Caregiver</h6>
                        </div>
                        <div class="card-body">
                            <c:choose>
                                <c:when test="${not empty patient.guardianName}">
                                    <div class="row mb-2">
                                        <div class="col-4"><strong>Name:</strong></div>
                                        <div class="col-8">${patient.guardianName}</div>
                                    </div>
                                    <c:if test="${not empty patient.guardianRelation}">
                                        <div class="row mb-2">
                                            <div class="col-4"><strong>Relation:</strong></div>
                                            <div class="col-8">${patient.guardianRelation}</div>
                                        </div>
                                    </c:if>
                                    <c:if test="${not empty patient.guardianPhone}">
                                        <div class="row mb-2">
                                            <div class="col-4"><strong>Phone:</strong></div>
                                            <div class="col-8">
                                                <a href="tel:${patient.guardianPhone}" class="text-primary">
                                                    ${patient.guardianPhone}
                                                </a>
                                            </div>
                                        </div>
                                    </c:if>
                                </c:when>
                                <c:otherwise>
                                    <p class="text-muted mb-0">No guardian information recorded</p>
                                </c:otherwise>
                            </c:choose>
                            
                            <c:if test="${not empty patient.emergencyContact}">
                                <hr>
                                <div class="row">
                                    <div class="col-4"><strong>Emergency:</strong></div>
                                    <div class="col-8">
                                        <a href="tel:${patient.emergencyContact}" class="text-danger">
                                            ${patient.emergencyContact}
                                        </a>
                                    </div>
                                </div>
                            </c:if>
                        </div>
                    </div>
                    
                    <!-- Quick Actions -->
                    <c:if test="${sessionScope.currentUser.role == 'ADMIN' || sessionScope.currentUser.role == 'MEDICAL_STAFF'}">
                        <div class="card mt-3">
                            <div class="card-header">
                                <h6 class="mb-0">Quick Actions</h6>
                            </div>
                            <div class="card-body">
                                <div class="d-grid gap-2">
                                    <a href="${pageContext.request.contextPath}/medical-records/new?patientId=${patient.patientId}" 
                                       class="btn btn-success btn-sm">
                                        📝 Add Medical Record
                                    </a>
                                    <a href="${pageContext.request.contextPath}/prescriptions/new?patientId=${patient.patientId}" 
                                       class="btn btn-primary btn-sm">
                                        💊 Write Prescription
                                    </a>
                                    <a href="${pageContext.request.contextPath}/appointments/new?patientId=${patient.patientId}" 
                                       class="btn btn-info btn-sm">
                                        📅 Schedule Appointment
                                    </a>
                                    <a href="${pageContext.request.contextPath}/lab-reports/new?patientId=${patient.patientId}" 
                                       class="btn btn-warning btn-sm">
                                        🧪 Add Lab Report
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </div>
                
                <div class="col-8">
                    <!-- Tab Navigation -->
                    <div class="card">
                        <div class="card-header">
                            <ul class="nav nav-tabs card-header-tabs" id="patientTabs">
                                <li class="nav-item">
                                    <a class="nav-link active" href="#medical-records" data-tab="medical-records">
                                        Medical Records
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="#medications" data-tab="medications">
                                        Medications
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="#appointments" data-tab="appointments">
                                        Appointments
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="#lab-reports" data-tab="lab-reports">
                                        Lab Reports
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="#conditions" data-tab="conditions">
                                        Conditions
                                    </a>
                                </li>
                            </ul>
                        </div>
                        
                        <div class="card-body">
                            <!-- Medical Records Tab -->
                            <div id="medical-records" class="tab-content active">
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <h6 class="mb-0">Recent Medical Records</h6>
                                    <c:if test="${sessionScope.currentUser.role == 'ADMIN' || sessionScope.currentUser.role == 'MEDICAL_STAFF'}">
                                        <a href="${pageContext.request.contextPath}/medical-records/new?patientId=${patient.patientId}" 
                                           class="btn btn-sm btn-success">
                                            Add Record
                                        </a>
                                    </c:if>
                                </div>
                                
                                <div class="medical-timeline">
                                    <!-- Sample medical record - replace with actual data -->
                                    <div class="timeline-item">
                                        <div class="timeline-date">January 15, 2024</div>
                                        <div class="timeline-title">Regular Checkup</div>
                                        <div class="row">
                                            <div class="col-6">
                                                <strong>Chief Complaint:</strong> Routine health assessment<br>
                                                <strong>Diagnosis:</strong> Stable hypertension, well-controlled diabetes
                                            </div>
                                            <div class="col-6">
                                                <strong>Vital Signs:</strong><br>
                                                BP: 130/85 mmHg | Pulse: 78 bpm<br>
                                                Temp: 98.2°F | Weight: 68 kg
                                            </div>
                                        </div>
                                        <div class="mt-2">
                                            <strong>Treatment Plan:</strong> Continue current medications, follow-up in 3 months
                                        </div>
                                    </div>
                                    
                                    <div class="timeline-item">
                                        <div class="timeline-date">December 10, 2023</div>
                                        <div class="timeline-title">Follow-up Visit</div>
                                        <div class="row">
                                            <div class="col-6">
                                                <strong>Chief Complaint:</strong> Joint pain and stiffness<br>
                                                <strong>Diagnosis:</strong> Osteoarthritis flare-up
                                            </div>
                                            <div class="col-6">
                                                <strong>Vital Signs:</strong><br>
                                                BP: 125/80 mmHg | Pulse: 72 bpm<br>
                                                Temp: 98.6°F | Weight: 67 kg
                                            </div>
                                        </div>
                                        <div class="mt-2">
                                            <strong>Treatment Plan:</strong> Prescribed pain medication, physiotherapy recommended
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="text-center mt-3">
                                    <a href="${pageContext.request.contextPath}/medical-records?patientId=${patient.patientId}" 
                                       class="btn btn-outline-primary">
                                        View All Medical Records
                                    </a>
                                </div>
                            </div>
                            
                            <!-- Medications Tab -->
                            <div id="medications" class="tab-content">
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <h6 class="mb-0">Current Medications</h6>
                                    <c:if test="${sessionScope.currentUser.role == 'ADMIN' || sessionScope.currentUser.role == 'MEDICAL_STAFF'}">
                                        <a href="${pageContext.request.contextPath}/prescriptions/new?patientId=${patient.patientId}" 
                                           class="btn btn-sm btn-success">
                                            Add Prescription
                                        </a>
                                    </c:if>
                                </div>
                                
                                <div class="table-responsive">
                                    <table class="table table-sm">
                                        <thead>
                                            <tr>
                                                <th>Medication</th>
                                                <th>Dosage</th>
                                                <th>Frequency</th>
                                                <th>Start Date</th>
                                                <th>Status</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>
                                                    <strong>Amlodipine 5mg</strong><br>
                                                    <small class="text-muted">For Hypertension</small>
                                                </td>
                                                <td>1 tablet</td>
                                                <td>Once daily</td>
                                                <td>Jan 2024</td>
                                                <td><span class="badge badge-success">Active</span></td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <strong>Metformin 500mg</strong><br>
                                                    <small class="text-muted">For Diabetes</small>
                                                </td>
                                                <td>1 tablet</td>
                                                <td>Twice daily</td>
                                                <td>Jan 2024</td>
                                                <td><span class="badge badge-success">Active</span></td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <strong>Aspirin 75mg</strong><br>
                                                    <small class="text-muted">For Heart Health</small>
                                                </td>
                                                <td>1 tablet</td>
                                                <td>Once daily</td>
                                                <td>Dec 2023</td>
                                                <td><span class="badge badge-success">Active</span></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            
                            <!-- Appointments Tab -->
                            <div id="appointments" class="tab-content">
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <h6 class="mb-0">Appointments</h6>
                                    <c:if test="${sessionScope.currentUser.role == 'ADMIN' || sessionScope.currentUser.role == 'MEDICAL_STAFF'}">
                                        <a href="${pageContext.request.contextPath}/appointments/new?patientId=${patient.patientId}" 
                                           class="btn btn-sm btn-success">
                                            Schedule Appointment
                                        </a>
                                    </c:if>
                                </div>
                                
                                <div class="row">
                                    <div class="col-6">
                                        <h6 class="text-primary">Upcoming Appointments</h6>
                                        <div class="list-group">
                                            <div class="list-group-item">
                                                <div class="d-flex justify-content-between">
                                                    <h6 class="mb-1">Regular Checkup</h6>
                                                    <small class="text-success">Scheduled</small>
                                                </div>
                                                <p class="mb-1">January 25, 2024 at 10:00 AM</p>
                                                <small>Dr. Rajesh Sharma</small>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="col-6">
                                        <h6 class="text-primary">Recent Appointments</h6>
                                        <div class="list-group">
                                            <div class="list-group-item">
                                                <div class="d-flex justify-content-between">
                                                    <h6 class="mb-1">Follow-up Visit</h6>
                                                    <small class="text-success">Completed</small>
                                                </div>
                                                <p class="mb-1">January 15, 2024 at 9:00 AM</p>
                                                <small>Dr. Rajesh Sharma</small>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Lab Reports Tab -->
                            <div id="lab-reports" class="tab-content">
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <h6 class="mb-0">Lab Reports</h6>
                                    <c:if test="${sessionScope.currentUser.role == 'ADMIN' || sessionScope.currentUser.role == 'MEDICAL_STAFF'}">
                                        <a href="${pageContext.request.contextPath}/lab-reports/new?patientId=${patient.patientId}" 
                                           class="btn btn-sm btn-success">
                                            Add Lab Report
                                        </a>
                                    </c:if>
                                </div>
                                
                                <div class="table-responsive">
                                    <table class="table table-sm">
                                        <thead>
                                            <tr>
                                                <th>Test Name</th>
                                                <th>Date</th>
                                                <th>Results</th>
                                                <th>Status</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>Complete Blood Count</td>
                                                <td>Jan 10, 2024</td>
                                                <td>
                                                    Hb: 12.5 g/dL<br>
                                                    WBC: 7,200/μL
                                                </td>
                                                <td><span class="badge badge-success">Normal</span></td>
                                                <td>
                                                    <a href="#" class="btn btn-sm btn-outline-primary">View</a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>HbA1c</td>
                                                <td>Jan 10, 2024</td>
                                                <td>7.2%</td>
                                                <td><span class="badge badge-warning">High</span></td>
                                                <td>
                                                    <a href="#" class="btn btn-sm btn-outline-primary">View</a>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            
                            <!-- Conditions Tab -->
                            <div id="conditions" class="tab-content">
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <h6 class="mb-0">Medical Conditions</h6>
                                    <c:if test="${sessionScope.currentUser.role == 'ADMIN' || sessionScope.currentUser.role == 'MEDICAL_STAFF'}">
                                        <a href="${pageContext.request.contextPath}/conditions/new?patientId=${patient.patientId}" 
                                           class="btn btn-sm btn-success">
                                            Add Condition
                                        </a>
                                    </c:if>
                                </div>
                                
                                <div class="row">
                                    <div class="col-6">
                                        <h6 class="text-danger">Chronic Conditions</h6>
                                        <div class="list-group">
                                            <div class="list-group-item">
                                                <div class="d-flex justify-content-between">
                                                    <h6 class="mb-1">Hypertension</h6>
                                                    <span class="badge badge-warning">Moderate</span>
                                                </div>
                                                <p class="mb-1">Diagnosed: March 2020</p>
                                                <small>Well controlled with medication</small>
                                            </div>
                                            <div class="list-group-item">
                                                <div class="d-flex justify-content-between">
                                                    <h6 class="mb-1">Type 2 Diabetes</h6>
                                                    <span class="badge badge-info">Mild</span>
                                                </div>
                                                <p class="mb-1">Diagnosed: July 2021</p>
                                                <small>Diet and medication controlled</small>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="col-6">
                                        <h6 class="text-warning">Allergies</h6>
                                        <div class="list-group">
                                            <div class="list-group-item">
                                                <div class="d-flex justify-content-between">
                                                    <h6 class="mb-1">Penicillin</h6>
                                                    <span class="badge badge-danger">Severe</span>
                                                </div>
                                                <small>Severe allergic reaction - avoid all penicillin-based antibiotics</small>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <%@ include file="../common/footer.jsp" %>
    
    <style>
        .nav-tabs .nav-link {
            border: none;
            color: var(--muted-color);
            padding: 0.75rem 1rem;
        }
        
        .nav-tabs .nav-link.active {
            background-color: transparent;
            border-bottom: 2px solid var(--primary-color);
            color: var(--primary-color);
            font-weight: 600;
        }
        
        .tab-content {
            display: none;
        }
        
        .tab-content.active {
            display: block;
        }
        
        .list-group-item {
            border: 1px solid var(--border-color);
            margin-bottom: 0.5rem;
            border-radius: 4px;
        }
        
        .d-grid {
            display: grid;
        }
        
        .gap-2 {
            gap: 0.5rem;
        }
    </style>
    
    <script>
        // Tab functionality
        document.addEventListener('DOMContentLoaded', function() {
            const tabLinks = document.querySelectorAll('.nav-link[data-tab]');
            const tabContents = document.querySelectorAll('.tab-content');
            
            tabLinks.forEach(link => {
                link.addEventListener('click', function(e) {
                    e.preventDefault();
                    
                    // Remove active class from all tabs and contents
                    tabLinks.forEach(l => l.classList.remove('active'));
                    tabContents.forEach(c => c.classList.remove('active'));
                    
                    // Add active class to clicked tab
                    this.classList.add('active');
                    
                    // Show corresponding content
                    const targetTab = this.getAttribute('data-tab');
                    document.getElementById(targetTab).classList.add('active');
                });
            });
        });
    </script>
</body>
</html>
