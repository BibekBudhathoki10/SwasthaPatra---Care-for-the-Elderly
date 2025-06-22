<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Write Prescription - Damak Medical System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <%@ include file="../common/header.jsp" %>
    
    <div class="main-content">
        <div class="container">
            <div class="page-header">
                <h1 class="page-title">Write Prescription</h1>
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
            
            <form action="${pageContext.request.contextPath}/prescriptions" method="post" id="prescriptionForm">
                <input type="hidden" name="action" value="create">
                <input type="hidden" name="patientId" value="${param.patientId}">
                
                <div class="row">
                    <div class="col-8">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="mb-0">Prescription Details</h5>
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
                                
                                <!-- Prescription Information -->
                                <div class="row">
                                    <div class="col-6">
                                        <div class="form-group">
                                            <label for="prescriptionDate" class="form-label required">Prescription Date</label>
                                            <input type="date" 
                                                   id="prescriptionDate" 
                                                   name="prescriptionDate" 
                                                   class="form-control" 
                                                   value="${currentDate}"
                                                   required>
                                        </div>
                                    </div>
                                    <div class="col-6">
                                        <div class="form-group">
                                            <label for="prescriptionStatus" class="form-label">Status</label>
                                            <select id="prescriptionStatus" name="status" class="form-control form-select">
                                                <option value="ACTIVE" selected>Active</option>
                                                <option value="ON_HOLD">On Hold</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Medications Section -->
                                <h6 class="text-primary mt-4 mb-3">Medications</h6>
                                <div id="medicationsContainer">
                                    <div class="medication-item card mb-3" data-index="0">
                                        <div class="card-header d-flex justify-content-between align-items-center">
                                            <h6 class="mb-0">Medication #1</h6>
                                            <button type="button" class="btn btn-sm btn-danger" onclick="removeMedication(0)" style="display: none;">
                                                Remove
                                            </button>
                                        </div>
                                        <div class="card-body">
                                            <div class="row">
                                                <div class="col-6">
                                                    <div class="form-group">
                                                        <label class="form-label required">Medication</label>
                                                        <input type="text" 
                                                               name="medications[0].medicationName" 
                                                               class="form-control medication-search" 
                                                               placeholder="Search medication..."
                                                               required>
                                                        <input type="hidden" name="medications[0].medicationId" class="medication-id">
                                                        <div class="medication-search-results search-results"></div>
                                                    </div>
                                                </div>
                                                <div class="col-6">
                                                    <div class="form-group">
                                                        <label class="form-label required">Dosage</label>
                                                        <input type="text" 
                                                               name="medications[0].dosage" 
                                                               class="form-control" 
                                                               placeholder="e.g., 1 tablet, 5ml"
                                                               required>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <div class="row">
                                                <div class="col-4">
                                                    <div class="form-group">
                                                        <label class="form-label required">Frequency</label>
                                                        <select name="medications[0].frequency" class="form-control form-select" required>
                                                            <option value="">Select Frequency</option>
                                                            <option value="Once daily">Once daily</option>
                                                            <option value="Twice daily">Twice daily</option>
                                                            <option value="Three times daily">Three times daily</option>
                                                            <option value="Four times daily">Four times daily</option>
                                                            <option value="Every 4 hours">Every 4 hours</option>
                                                            <option value="Every 6 hours">Every 6 hours</option>
                                                            <option value="Every 8 hours">Every 8 hours</option>
                                                            <option value="Every 12 hours">Every 12 hours</option>
                                                            <option value="As needed">As needed</option>
                                                            <option value="Before meals">Before meals</option>
                                                            <option value="After meals">After meals</option>
                                                            <option value="At bedtime">At bedtime</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="col-4">
                                                    <div class="form-group">
                                                        <label class="form-label">Duration (Days)</label>
                                                        <input type="number" 
                                                               name="medications[0].durationDays" 
                                                               class="form-control" 
                                                               placeholder="30"
                                                               min="1" 
                                                               max="365">
                                                    </div>
                                                </div>
                                                <div class="col-4">
                                                    <div class="form-group">
                                                        <label class="form-label">Quantity</label>
                                                        <input type="number" 
                                                               name="medications[0].quantity" 
                                                               class="form-control" 
                                                               placeholder="30"
                                                               min="1">
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <div class="form-group">
                                                <label class="form-label">Special Instructions</label>
                                                <textarea name="medications[0].instructions" 
                                                          class="form-control" 
                                                          rows="2" 
                                                          placeholder="Take with food, avoid alcohol, etc."></textarea>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="text-center mb-4">
                                    <button type="button" class="btn btn-outline-primary" onclick="addMedication()">
                                        + Add Another Medication
                                    </button>
                                </div>
                                
                                <!-- General Notes -->
                                <div class="form-group">
                                    <label for="prescriptionNotes" class="form-label">Prescription Notes</label>
                                    <textarea id="prescriptionNotes" 
                                              name="notes" 
                                              class="form-control" 
                                              rows="3" 
                                              placeholder="General instructions, warnings, follow-up recommendations..."></textarea>
                                </div>
                                
                                <div class="form-group mt-4">
                                    <button type="submit" class="btn btn-primary btn-lg">
                                        Save Prescription
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
                        <!-- Patient Information -->
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
                                        <div class="col-4"><strong>Weight:</strong></div>
                                        <div class="col-8">
                                            <c:choose>
                                                <c:when test="${patient.weight > 0}">
                                                    ${patient.weight} kg
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-muted">Not recorded</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                    <div class="row mb-2">
                                        <div class="col-4"><strong>Allergies:</strong></div>
                                        <div class="col-8">
                                            <span class="badge badge-danger">Penicillin</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                        
                        <!-- Current Medications -->
                        <div class="card mt-3">
                            <div class="card-header">
                                <h6 class="mb-0">Current Medications</h6>
                            </div>
                            <div class="card-body">
                                <div class="list-group">
                                    <div class="list-group-item">
                                        <h6 class="mb-1">Amlodipine 5mg</h6>
                                        <p class="mb-1">Once daily</p>
                                        <small>For Hypertension</small>
                                    </div>
                                    <div class="list-group-item">
                                        <h6 class="mb-1">Metformin 500mg</h6>
                                        <p class="mb-1">Twice daily</p>
                                        <small>For Diabetes</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Prescription Guidelines -->
                        <div class="card mt-3">
                            <div class="card-header">
                                <h6 class="mb-0">Prescription Guidelines</h6>
                            </div>
                            <div class="card-body">
                                <h6 class="text-primary">Safety Checks:</h6>
                                <ul class="mb-3">
                                    <li>Verify patient allergies</li>
                                    <li>Check drug interactions</li>
                                    <li>Consider age-appropriate dosing</li>
                                    <li>Review current medications</li>
                                </ul>
                                
                                <h6 class="text-primary">Common Frequencies:</h6>
                                <ul class="mb-3">
                                    <li><strong>QD:</strong> Once daily</li>
                                    <li><strong>BID:</strong> Twice daily</li>
                                    <li><strong>TID:</strong> Three times daily</li>
                                    <li><strong>QID:</strong> Four times daily</li>
                                    <li><strong>PRN:</strong> As needed</li>
                                </ul>
                                
                                <h6 class="text-primary">Special Instructions:</h6>
                                <ul class="mb-0">
                                    <li>Take with/without food</li>
                                    <li>Avoid alcohol</li>
                                    <li>Monitor for side effects</li>
                                    <li>Follow-up appointments</li>
                                </ul>
                            </div>
                        </div>
                        
                        <!-- Available Medications -->
                        <div class="card mt-3">
                            <div class="card-header">
                                <h6 class="mb-0">Available Medications</h6>
                            </div>
                            <div class="card-body">
                                <div class="medication-category">
                                    <h6 class="text-success">Hypertension</h6>
                                    <small class="text-muted">Amlodipine, Lisinopril, Atenolol</small>
                                </div>
                                <div class="medication-category mt-2">
                                    <h6 class="text-info">Diabetes</h6>
                                    <small class="text-muted">Metformin, Glipizide, Insulin</small>
                                </div>
                                <div class="medication-category mt-2">
                                    <h6 class="text-warning">Pain Relief</h6>
                                    <small class="text-muted">Paracetamol, Ibuprofen, Aspirin</small>
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
        
        .medication-item {
            position: relative;
        }
        
        .medication-category {
            padding: 0.5rem 0;
            border-bottom: 1px solid var(--border-color);
        }
        
        .medication-category:last-child {
            border-bottom: none;
        }
    </style>
    
    <script>
        let medicationCount = 1;
        
        // Set current date as default
        document.getElementById('prescriptionDate').value = new Date().toISOString().split('T')[0];
        
        // Add medication function
        function addMedication() {
            const container = document.getElementById('medicationsContainer');
            const newMedication = document.createElement('div');
            newMedication.className = 'medication-item card mb-3';
            newMedication.setAttribute('data-index', medicationCount);
            
            newMedication.innerHTML = `
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h6 class="mb-0">Medication #${medicationCount + 1}</h6>
                    <button type="button" class="btn btn-sm btn-danger" onclick="removeMedication(${medicationCount})">
                        Remove
                    </button>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-6">
                            <div class="form-group">
                                <label class="form-label required">Medication</label>
                                <input type="text" 
                                       name="medications[${medicationCount}].medicationName" 
                                       class="form-control medication-search" 
                                       placeholder="Search medication..."
                                       required>
                                <input type="hidden" name="medications[${medicationCount}].medicationId" class="medication-id">
                                <div class="medication-search-results search-results"></div>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="form-group">
                                <label class="form-label required">Dosage</label>
                                <input type="text" 
                                       name="medications[${medicationCount}].dosage" 
                                       class="form-control" 
                                       placeholder="e.g., 1 tablet, 5ml"
                                       required>
                            </div>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-4">
                            <div class="form-group">
                                <label class="form-label required">Frequency</label>
                                <select name="medications[${medicationCount}].frequency" class="form-control form-select" required>
                                    <option value="">Select Frequency</option>
                                    <option value="Once daily">Once daily</option>
                                    <option value="Twice daily">Twice daily</option>
                                    <option value="Three times daily">Three times daily</option>
                                    <option value="Four times daily">Four times daily</option>
                                    <option value="Every 4 hours">Every 4 hours</option>
                                    <option value="Every 6 hours">Every 6 hours</option>
                                    <option value="Every 8 hours">Every 8 hours</option>
                                    <option value="Every 12 hours">Every 12 hours</option>
                                    <option value="As needed">As needed</option>
                                    <option value="Before meals">Before meals</option>
                                    <option value="After meals">After meals</option>
                                    <option value="At bedtime">At bedtime</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-4">
                            <div class="form-group">
                                <label class="form-label">Duration (Days)</label>
                                <input type="number" 
                                       name="medications[${medicationCount}].durationDays" 
                                       class="form-control" 
                                       placeholder="30"
                                       min="1" 
                                       max="365">
                            </div>
                        </div>
                        <div class="col-4">
                            <div class="form-group">
                                <label class="form-label">Quantity</label>
                                <input type="number" 
                                       name="medications[${medicationCount}].quantity" 
                                       class="form-control" 
                                       placeholder="30"
                                       min="1">
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Special Instructions</label>
                        <textarea name="medications[${medicationCount}].instructions" 
                                  class="form-control" 
                                  rows="2" 
                                  placeholder="Take with food, avoid alcohol, etc."></textarea>
                    </div>
                </div>
            `;
            
            container.appendChild(newMedication);
            medicationCount++;
            
            // Show remove button for first medication if more than one exists
            if (medicationCount > 1) {
                const firstRemoveBtn = document.querySelector('[data-index="0"] .btn-danger');
                if (firstRemoveBtn) {
                    firstRemoveBtn.style.display = 'inline-block';
                }
            }
            
            // Initialize medication search for new item
            initializeMedicationSearch(newMedication.querySelector('.medication-search'));
        }
        
        // Remove medication function
        function removeMedication(index) {
            const medicationItem = document.querySelector(`[data-index="${index}"]`);
            if (medicationItem) {
                medicationItem.remove();
                
                // Hide remove button for first medication if only one remains
                const remainingMedications = document.querySelectorAll('.medication-item');
                if (remainingMedications.length === 1) {
                    const firstRemoveBtn = remainingMedications[0].querySelector('.btn-danger');
                    if (firstRemoveBtn) {
                        firstRemoveBtn.style.display = 'none';
                    }
                }
            }
        }
        
        // Initialize medication search functionality
        function initializeMedicationSearch(input) {
            let searchTimeout;
            
            input.addEventListener('input', function() {
                clearTimeout(searchTimeout);
                const query = this.value.trim();
                const resultsContainer = this.parentNode.querySelector('.medication-search-results');
                
                if (query.length < 2) {
                    resultsContainer.style.display = 'none';
                    return;
                }
                
                searchTimeout = setTimeout(() => {
                    searchMedications(query, resultsContainer, this);
                }, 300);
            });
        }
        
        // Search medications function
        function searchMedications(query, resultsContainer, inputElement) {
            // Mock medication data - replace with actual AJAX call
            const mockMedications = [
                {id: 1, name: 'Amlodipine 5mg', category: 'Hypertension', strength: '5mg'},
                {id: 2, name: 'Metformin 500mg', category: 'Diabetes', strength: '500mg'},
                {id: 3, name: 'Lisinopril 10mg', category: 'Hypertension', strength: '10mg'},
                {id: 4, name: 'Aspirin 75mg', category: 'Cardiology', strength: '75mg'},
                {id: 5, name: 'Paracetamol 500mg', category: 'Pain Relief', strength: '500mg'},
                {id: 6, name: 'Atorvastatin 20mg', category: 'Cholesterol', strength: '20mg'}
            ];
            
            const results = mockMedications.filter(med => 
                med.name.toLowerCase().includes(query.toLowerCase()) || 
                med.category.toLowerCase().includes(query.toLowerCase())
            );
            
            if (results.length === 0) {
                resultsContainer.innerHTML = '<div class="search-result-item text-muted">No medications found</div>';
            } else {
                resultsContainer.innerHTML = results.map(med => `
                    <div class="search-result-item" onclick="selectMedication(${med.id}, '${med.name}', '${inputElement.name}')">
                        <strong>${med.name}</strong><br>
                        <small class="text-muted">${med.category}</small>
                    </div>
                `).join('');
            }
            
            resultsContainer.style.display = 'block';
        }
        
        // Select medication function
        function selectMedication(id, name, inputName) {
            const input = document.querySelector(`input[name="${inputName}"]`);
            const hiddenInput = input.parentNode.querySelector('.medication-id');
            const resultsContainer = input.parentNode.querySelector('.medication-search-results');
            
            input.value = name;
            hiddenInput.value = id;
            resultsContainer.style.display = 'none';
        }
        
        // Initialize search for existing medication inputs
        document.addEventListener('DOMContentLoaded', function() {
            document.querySelectorAll('.medication-search').forEach(input => {
                initializeMedicationSearch(input);
            });
        });
        
        // Hide search results when clicking outside
        document.addEventListener('click', function(e) {
            if (!e.target.closest('.medication-search')) {
                document.querySelectorAll('.medication-search-results').forEach(results => {
                    results.style.display = 'none';
                });
            }
        });
        
        // Form validation
        document.getElementById('prescriptionForm').addEventListener('submit', function(e) {
            let isValid = true;
            
            // Validate each medication
            document.querySelectorAll('.medication-item').forEach((item, index) => {
                const medicationName = item.querySelector(`input[name*="medicationName"]`);
                const dosage = item.querySelector(`input[name*="dosage"]`);
                const frequency = item.querySelector(`select[name*="frequency"]`);
                
                if (!medicationName.value.trim()) {
                    medicationName.classList.add('is-invalid');
                    isValid = false;
                } else {
                    medicationName.classList.remove('is-invalid');
                }
                
                if (!dosage.value.trim()) {
                    dosage.classList.add('is-invalid');
                    isValid = false;
                } else {
                    dosage.classList.remove('is-invalid');
                }
                
                if (!frequency.value) {
                    frequency.classList.add('is-invalid');
                    isValid = false;
                } else {
                    frequency.classList.remove('is-invalid');
                }
            });
            
            if (!isValid) {
                e.preventDefault();
                alert('Please fill in all required medication fields.');
            }
        });
    </script>
</body>
</html>
