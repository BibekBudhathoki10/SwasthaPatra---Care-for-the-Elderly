<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Medical Record - Damak Medical System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <%@ include file="../common/header.jsp" %>
    
    <div class="main-content">
        <div class="container">
            <div class="page-header">
                <h1 class="page-title">Add Medical Record</h1>
                <p class="page-subtitle">
                    <c:if test="${not empty patient}">
                        For patient: <strong>${patient.fullName}</strong> (${patient.patientCode})
                    </c:if>
                </p>
            </div>
            
            <c:if test="${not empty error}">
                <div class="alert alert-danger">
                    ${error}
                </div>
            </c:if>
            
            <form action="${pageContext.request.contextPath}/medical-records" method="post" id="medicalRecordForm">
                <input type="hidden" name="action" value="create">
                <input type="hidden" name="patientId" value="${param.patientId}">
                
                <div class="row">
                    <div class="col-8">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="mb-0">Medical Record Details</h5>
                            </div>
                            <div class="card-body">
                                <!-- Patient Selection (if not pre-selected) -->
                                <c:if test="${empty param.patientId}">
                                    <div class="form-group">
                                        <label for="patientSearch" class="form-label required">Patient</label>
                                        <input type="text" 
                                               id="patientSearch" 
                                               class="form-control" 
                                               placeholder="Search patient by name or code..."
                                               autocomplete="off">
                                        <input type="hidden" name="patientId" id="selectedPatientId" required>
                                        <div id="patientSearchResults" class="search-results"></div>
                                    </div>
                                </c:if>
                                
                                <!-- Visit Information -->
                                <div class="row">
                                    <div class="col-6">
                                        <div class="form-group">
                                            <label for="visitDate" class="form-label required">Visit Date</label>
                                            <input type="date" 
                                                   id="visitDate" 
                                                   name="visitDate" 
                                                   class="form-control" 
                                                   value="${currentDate}"
                                                   required>
                                        </div>
                                    </div>
                                    <div class="col-6">
                                        <div class="form-group">
                                            <label for="visitType" class="form-label required">Visit Type</label>
                                            <select id="visitType" name="visitType" class="form-control form-select" required>
                                                <option value="">Select Visit Type</option>
                                                <option value="REGULAR_CHECKUP">Regular Checkup</option>
                                                <option value="EMERGENCY">Emergency</option>
                                                <option value="FOLLOW_UP">Follow-up</option>
                                                <option value="CONSULTATION">Consultation</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Chief Complaint -->
                                <div class="form-group">
                                    <label for="chiefComplaint" class="form-label required">Chief Complaint</label>
                                    <textarea id="chiefComplaint" 
                                              name="chiefComplaint" 
                                              class="form-control" 
                                              rows="3" 
                                              placeholder="Patient's main concern or reason for visit..."
                                              required></textarea>
                                </div>
                                
                                <!-- Symptoms -->
                                <div class="form-group">
                                    <label for="symptoms" class="form-label">Symptoms</label>
                                    <textarea id="symptoms" 
                                              name="symptoms" 
                                              class="form-control" 
                                              rows="3" 
                                              placeholder="Detailed symptoms observed or reported..."></textarea>
                                </div>
                                
                                <!-- Vital Signs -->
                                <h6 class="text-primary mt-4 mb-3">Vital Signs</h6>
                                <div class="row">
                                    <div class="col-3">
                                        <div class="form-group">
                                            <label for="bloodPressure" class="form-label">Blood Pressure</label>
                                            <input type="text" 
                                                   id="bloodPressure" 
                                                   name="bloodPressure" 
                                                   class="form-control" 
                                                   placeholder="120/80"
                                                   pattern="[0-9]{2,3}/[0-9]{2,3}">
                                            <div class="form-text">mmHg</div>
                                        </div>
                                    </div>
                                    <div class="col-3">
                                        <div class="form-group">
                                            <label for="pulse" class="form-label">Pulse Rate</label>
                                            <input type="number" 
                                                   id="pulse" 
                                                   name="pulse" 
                                                   class="form-control" 
                                                   placeholder="72"
                                                   min="40" 
                                                   max="200">
                                            <div class="form-text">bpm</div>
                                        </div>
                                    </div>
                                    <div class="col-3">
                                        <div class="form-group">
                                            <label for="temperature" class="form-label">Temperature</label>
                                            <input type="number" 
                                                   id="temperature" 
                                                   name="temperature" 
                                                   class="form-control" 
                                                   placeholder="98.6"
                                                   min="95" 
                                                   max="110" 
                                                   step="0.1">
                                            <div class="form-text">°F</div>
                                        </div>
                                    </div>
                                    <div class="col-3">
                                        <div class="form-group">
                                            <label for="weight" class="form-label">Weight</label>
                                            <input type="number" 
                                                   id="weight" 
                                                   name="weight" 
                                                   class="form-control" 
                                                   placeholder="65"
                                                   min="20" 
                                                   max="200" 
                                                   step="0.1">
                                            <div class="form-text">kg</div>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Diagnosis -->
                                <div class="form-group">
                                    <label for="diagnosis" class="form-label required">Diagnosis</label>
                                    <textarea id="diagnosis" 
                                              name="diagnosis" 
                                              class="form-control" 
                                              rows="3" 
                                              placeholder="Medical diagnosis based on examination..."
                                              required></textarea>
                                </div>
                                
                                <!-- Treatment Plan -->
                                <div class="form-group">
                                    <label for="treatmentPlan" class="form-label required">Treatment Plan</label>
                                    <textarea id="treatmentPlan" 
                                              name="treatmentPlan" 
                                              class="form-control" 
                                              rows="4" 
                                              placeholder="Recommended treatment, medications, follow-up instructions..."
                                              required></textarea>
                                </div>
                                
                                <!-- Doctor's Notes -->
                                <div class="form-group">
                                    <label for="doctorNotes" class="form-label">Doctor's Notes</label>
                                    <textarea id="doctorNotes" 
                                              name="doctorNotes" 
                                              class="form-control" 
                                              rows="3" 
                                              placeholder="Additional observations, recommendations, or notes..."></textarea>
                                </div>
                                
                                <!-- Next Visit -->
                                <div class="form-group">
                                    <label for="nextVisitDate" class="form-label">Next Visit Date</label>
                                    <input type="date" 
                                           id="nextVisitDate" 
                                           name="nextVisitDate" 
                                           class="form-control">
                                    <div class="form-text">Recommended date for follow-up visit</div>
                                </div>
                                
                                <div class="form-group mt-4">
                                    <button type="submit" class="btn btn-primary btn-lg">
                                        Save Medical Record
                                    </button>
                                    <a href="${pageContext.request.contextPath}/patients/${param.patientId}" 
                                       class="btn btn-secondary btn-lg">
                                        Cancel
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-4">
                        <!-- Patient Information (if selected) -->
                        <c:if test="${not empty patient}">
                            <div class="card">
                                <div class="card-header">
                                    <h6 class="mb-0">Patient Information</h6>
                                </div>
                                <div class="card-body">
                                    <div class="text-center mb-3">
                                        <div class="patient-avatar" style="width: 60px; height: 60px; margin: 0 auto;">
                                            ${patient.firstName.substring(0,1)}${patient.lastName.substring(0,1)}
                                        </div>
                                        <h6 class="mt-2 mb-0">${patient.fullName}</h6>
                                        <small class="text-muted">${patient.patientCode}</small>
                                    </div>
                                    
                                    <div class="row mb-2">
                                        <div class="col-4"><strong>Age:</strong></div>
                                        <div class="col-8">${patient.age} years</div>
                                    </div>
                                    <div class="row mb-2">
                                        <div class="col-4"><strong>Gender:</strong></div>
                                        <div class="col-8">${patient.gender}</div>
                                    </div>
                                    <div class="row mb-2">
                                        <div class="col-4"><strong>Blood Group:</strong></div>
                                        <div class="col-8">
                                            <c:choose>
                                                <c:when test="${not empty patient.bloodGroup}">
                                                    ${patient.bloodGroup}
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-muted">Not recorded</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                    <div class="row mb-2">
                                        <div class="col-4"><strong>Ward:</strong></div>
                                        <div class="col-8">Ward ${patient.wardNo}</div>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                        
                        <!-- Medical Record Guidelines -->
                        <div class="card mt-3">
                            <div class="card-header">
                                <h6 class="mb-0">Documentation Guidelines</h6>
                            </div>
                            <div class="card-body">
                                <h6 class="text-primary">Required Information:</h6>
                                <ul class="mb-3">
                                    <li>Chief complaint (patient's main concern)</li>
                                    <li>Clinical diagnosis</li>
                                    <li>Treatment plan and recommendations</li>
                                    <li>Visit date and type</li>
                                </ul>
                                
                                <h6 class="text-primary">Best Practices:</h6>
                                <ul class="mb-3">
                                    <li>Record vital signs accurately</li>
                                    <li>Use clear, professional language</li>
                                    <li>Include follow-up instructions</li>
                                    <li>Note any allergies or contraindications</li>
                                </ul>
                                
                                <h6 class="text-primary">Vital Signs Reference:</h6>
                                <ul class="mb-0">
                                    <li><strong>BP:</strong> Normal &lt; 120/80 mmHg</li>
                                    <li><strong>Pulse:</strong> 60-100 bpm (adults)</li>
                                    <li><strong>Temp:</strong> 97-99°F (36-37°C)</li>
                                    <li><strong>Weight:</strong> Monitor changes</li>
                                </ul>
                            </div>
                        </div>
                        
                        <!-- Quick Templates -->
                        <div class="card mt-3">
                            <div class="card-header">
                                <h6 class="mb-0">Quick Templates</h6>
                            </div>
                            <div class="card-body">
                                <div class="d-grid gap-2">
                                    <button type="button" class="btn btn-sm btn-outline-primary" onclick="useTemplate('checkup')">
                                        Regular Checkup
                                    </button>
                                    <button type="button" class="btn btn-sm btn-outline-primary" onclick="useTemplate('followup')">
                                        Follow-up Visit
                                    </button>
                                    <button type="button" class="btn btn-sm btn-outline-primary" onclick="useTemplate('emergency')">
                                        Emergency Visit
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
    
    <%@ include file="../common/footer.jsp" %>
    
    <style>
        .search-results {
            position: absolute;
            top: 100%;
            left: 0;
            right: 0;
            background: white;
            border: 1px solid var(--border-color);
            border-top: none;
            border-radius: 0 0 4px 4px;
            max-height: 200px;
            overflow-y: auto;
            z-index: 1000;
            display: none;
        }
        
        .search-result-item {
            padding: 0.75rem;
            border-bottom: 1px solid var(--border-color);
            cursor: pointer;
        }
        
        .search-result-item:hover {
            background-color: var(--light-color);
        }
        
        .search-result-item:last-child {
            border-bottom: none;
        }
        
        .patient-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: var(--primary-color);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
        }
    </style>
    
    <script>
        // Set current date as default
        document.getElementById('visitDate').value = new Date().toISOString().split('T')[0];
        
        // Patient search functionality (if patient not pre-selected)
        <c:if test="${empty param.patientId}">
        let searchTimeout;
        document.getElementById('patientSearch').addEventListener('input', function() {
            clearTimeout(searchTimeout);
            const query = this.value.trim();
            
            if (query.length < 2) {
                document.getElementById('patientSearchResults').style.display = 'none';
                return;
            }
            
            searchTimeout = setTimeout(() => {
                searchPatients(query);
            }, 300);
        });
        
        function searchPatients(query) {
            // Simulate patient search - replace with actual AJAX call
            const mockResults = [
                {id: 1, name: 'Ram Bahadur Thapa', code: 'DMK-2024-001', age: 84},
                {id: 2, name: 'Kamala Sharma', code: 'DMK-2024-002', age: 86},
                {id: 3, name: 'Bir Bahadur Rai', code: 'DMK-2024-003', age: 82}
            ];
            
            const results = mockResults.filter(p => 
                p.name.toLowerCase().includes(query.toLowerCase()) || 
                p.code.toLowerCase().includes(query.toLowerCase())
            );
            
            displaySearchResults(results);
        }
        
        function displaySearchResults(results) {
            const container = document.getElementById('patientSearchResults');
            
            if (results.length === 0) {
                container.innerHTML = '<div class="search-result-item text-muted">No patients found</div>';
            } else {
                container.innerHTML = results.map(patient => `
                    <div class="search-result-item" onclick="selectPatient(${patient.id}, '${patient.name}', '${patient.code}')">
                        <strong>${patient.name}</strong><br>
                        <small class="text-muted">${patient.code} • Age: ${patient.age}</small>
                    </div>
                `).join('');
            }
            
            container.style.display = 'block';
        }
        
        function selectPatient(id, name, code) {
            document.getElementById('patientSearch').value = `${name} (${code})`;
            document.getElementById('selectedPatientId').value = id;
            document.getElementById('patientSearchResults').style.display = 'none';
        }
        
        // Hide search results when clicking outside
        document.addEventListener('click', function(e) {
            if (!e.target.closest('#patientSearch')) {
                document.getElementById('patientSearchResults').style.display = 'none';
            }
        });
        </c:if>
        
        // Template functions
        function useTemplate(type) {
            switch(type) {
                case 'checkup':
                    document.getElementById('visitType').value = 'REGULAR_CHECKUP';
                    document.getElementById('chiefComplaint').value = 'Routine health assessment and medication review';
                    document.getElementById('treatmentPlan').value = 'Continue current medications as prescribed. Follow-up in 3 months or as needed.';
                    break;
                    
                case 'followup':
                    document.getElementById('visitType').value = 'FOLLOW_UP';
                    document.getElementById('chiefComplaint').value = 'Follow-up visit for previously diagnosed condition';
                    document.getElementById('treatmentPlan').value = 'Monitor current treatment response. Adjust medications if necessary.';
                    break;
                    
                case 'emergency':
                    document.getElementById('visitType').value = 'EMERGENCY';
                    document.getElementById('chiefComplaint').value = 'Urgent medical concern requiring immediate attention';
                    document.getElementById('treatmentPlan').value = 'Immediate treatment provided. Follow-up appointment scheduled.';
                    break;
            }
        }
        
        // Form validation
        document.getElementById('medicalRecordForm').addEventListener('submit', function(e) {
            const requiredFields = ['visitDate', 'visitType', 'chiefComplaint', 'diagnosis', 'treatmentPlan'];
            let isValid = true;
            
            requiredFields.forEach(fieldId => {
                const field = document.getElementById(fieldId);
                if (!field.value.trim()) {
                    field.classList.add('is-invalid');
                    isValid = false;
                } else {
                    field.classList.remove('is-invalid');
                }
            });
            
            <c:if test="${empty param.patientId}">
            if (!document.getElementById('selectedPatientId').value) {
                document.getElementById('patientSearch').classList.add('is-invalid');
                isValid = false;
            }
            </c:if>
            
            if (!isValid) {
                e.preventDefault();
                alert('Please fill in all required fields.');
            }
        });
    </script>
</body>
</html>
