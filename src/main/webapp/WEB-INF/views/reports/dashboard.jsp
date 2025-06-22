<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reports Dashboard - Damak Medical System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
    <%@ include file="../common/header.jsp" %>
    
    <div class="main-content">
        <div class="container">
            <div class="page-header">
                <div class="row">
                    <div class="col-8">
                        <h1 class="page-title">Reports & Analytics</h1>
                        <p class="page-subtitle">Comprehensive health statistics and system reports</p>
                    </div>
                    <div class="col-4 text-right">
                        <div class="dropdown" style="display: inline-block;">
                            <button class="btn btn-primary dropdown-toggle" onclick="toggleDropdown()">
                                Generate Report
                            </button>
                            <div class="dropdown-menu" id="reportDropdown">
                                <a class="dropdown-item" href="#" onclick="generateReport('patient-summary')">Patient Summary</a>
                                <a class="dropdown-item" href="#" onclick="generateReport('medical-records')">Medical Records</a>
                                <a class="dropdown-item" href="#" onclick="generateReport('medications')">Medication Report</a>
                                <a class="dropdown-item" href="#" onclick="generateReport('appointments')">Appointment Report</a>
                                <a class="dropdown-item" href="#" onclick="generateReport('ward-wise')">Ward-wise Report</a>
                            </div>
                        </div>
                        <button class="btn btn-info" onclick="exportData()">
                            Export Data
                        </button>
                    </div>
                </div>
            </div>
            
            <!-- Report Filters -->
            <div class="card mb-4">
                <div class="card-header">
                    <h6 class="mb-0">Report Filters</h6>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-3">
                            <div class="form-group">
                                <label for="dateFrom" class="form-label">From Date</label>
                                <input type="date" id="dateFrom" class="form-control" onchange="updateReports()">
                            </div>
                        </div>
                        <div class="col-3">
                            <div class="form-group">
                                <label for="dateTo" class="form-label">To Date</label>
                                <input type="date" id="dateTo" class="form-control" onchange="updateReports()">
                            </div>
                        </div>
                        <div class="col-3">
                            <div class="form-group">
                                <label for="wardFilter" class="form-label">Ward</label>
                                <select id="wardFilter" class="form-control form-select" onchange="updateReports()">
                                    <option value="">All Wards</option>
                                    <option value="1">Ward 1</option>
                                    <option value="2">Ward 2</option>
                                    <option value="3">Ward 3</option>
                                    <option value="4">Ward 4</option>
                                    <option value="5">Ward 5</option>
                                    <option value="6">Ward 6</option>
                                    <option value="7">Ward 7</option>
                                    <option value="8">Ward 8</option>
                                    <option value="9">Ward 9</option>
                                    <option value="10">Ward 10</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-3">
                            <div class="form-group">
                                <label for="ageGroup" class="form-label">Age Group</label>
                                <select id="ageGroup" class="form-control form-select" onchange="updateReports()">
                                    <option value="">All Ages</option>
                                    <option value="80-85">80-85 years</option>
                                    <option value="86-90">86-90 years</option>
                                    <option value="91-95">91-95 years</option>
                                    <option value="95+">95+ years</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Key Metrics -->
            <div class="dashboard-stats mb-4">
                <div class="stat-card">
                    <div class="stat-number" id="totalPatients">156</div>
                    <div class="stat-label">Total Patients</div>
                    <div class="stat-change text-success">+12 this month</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number" id="activePatients">142</div>
                    <div class="stat-label">Active Patients</div>
                    <div class="stat-change text-info">91% active rate</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number" id="totalVisits">1,248</div>
                    <div class="stat-label">Total Visits</div>
                    <div class="stat-change text-success">+89 this month</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number" id="avgAge">84.2</div>
                    <div class="stat-label">Average Age</div>
                    <div class="stat-change text-muted">years</div>
                </div>
            </div>
            
            <!-- Charts Row 1 -->
            <div class="row mb-4">
                <div class="col-6">
                    <div class="card">
                        <div class="card-header">
                            <h6 class="mb-0">Patient Registration Trend</h6>
                        </div>
                        <div class="card-body">
                            <canvas id="registrationChart" height="300"></canvas>
                        </div>
                    </div>
                </div>
                <div class="col-6">
                    <div class="card">
                        <div class="card-header">
                            <h6 class="mb-0">Ward-wise Patient Distribution</h6>
                        </div>
                        <div class="card-body">
                            <canvas id="wardChart" height="300"></canvas>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Charts Row 2 -->
            <div class="row mb-4">
                <div class="col-6">
                    <div class="card">
                        <div class="card-header">
                            <h6 class="mb-0">Age Group Distribution</h6>
                        </div>
                        <div class="card-body">
                            <canvas id="ageChart" height="300"></canvas>
                        </div>
                    </div>
                </div>
                <div class="col-6">
                    <div class="card">
                        <div class="card-header">
                            <h6 class="mb-0">Common Medical Conditions</h6>
                        </div>
                        <div class="card-body">
                            <canvas id="conditionsChart" height="300"></canvas>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Charts Row 3 -->
            <div class="row mb-4">
                <div class="col-6">
                    <div class="card">
                        <div class="card-header">
                            <h6 class="mb-0">Monthly Appointments</h6>
                        </div>
                        <div class="card-body">
                            <canvas id="appointmentsChart" height="300"></canvas>
                        </div>
                    </div>
                </div>
                <div class="col-6">
                    <div class="card">
                        <div class="card-header">
                            <h6 class="mb-0">Medication Distribution</h6>
                        </div>
                        <div class="card-body">
                            <canvas id="medicationChart" height="300"></canvas>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Detailed Reports Table -->
            <div class="card">
                <div class="card-header">
                    <div class="d-flex justify-content-between align-items-center">
                        <h6 class="mb-0">Detailed Patient Reports</h6>
                        <div>
                            <button class="btn btn-sm btn-outline-primary" onclick="printTable()">
                                Print Table
                            </button>
                            <button class="btn btn-sm btn-outline-success" onclick="exportTableToCSV()">
                                Export CSV
                            </button>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover" id="patientsReportTable">
                            <thead>
                                <tr>
                                    <th>Patient Code</th>
                                    <th>Name</th>
                                    <th>Age</th>
                                    <th>Gender</th>
                                    <th>Ward</th>
                                    <th>Last Visit</th>
                                    <th>Conditions</th>
                                    <th>Active Medications</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>DMK-2024-001</td>
                                    <td>Ram Bahadur Thapa</td>
                                    <td>84</td>
                                    <td>Male</td>
                                    <td>5</td>
                                    <td>Jan 15, 2024</td>
                                    <td>
                                        <span class="badge badge-warning">Hypertension</span>
                                        <span class="badge badge-info">Diabetes</span>
                                    </td>
                                    <td>3</td>
                                    <td><span class="badge badge-success">Active</span></td>
                                </tr>
                                <tr>
                                    <td>DMK-2024-002</td>
                                    <td>Kamala Sharma</td>
                                    <td>86</td>
                                    <td>Female</td>
                                    <td>3</td>
                                    <td>Jan 16, 2024</td>
                                    <td>
                                        <span class="badge badge-danger">Arthritis</span>
                                    </td>
                                    <td>2</td>
                                    <td><span class="badge badge-success">Active</span></td>
                                </tr>
                                <tr>
                                    <td>DMK-2024-003</td>
                                    <td>Bir Bahadur Rai</td>
                                    <td>82</td>
                                    <td>Male</td>
                                    <td>7</td>
                                    <td>Jan 18, 2024</td>
                                    <td>
                                        <span class="badge badge-warning">Heart Disease</span>
                                    </td>
                                    <td>4</td>
                                    <td><span class="badge badge-success">Active</span></td>
                                </tr>
                                <tr>
                                    <td>DMK-2024-004</td>
                                    <td>Devi Limbu</td>
                                    <td>85</td>
                                    <td>Female</td>
                                    <td>2</td>
                                    <td>Jan 12, 2024</td>
                                    <td>
                                        <span class="badge badge-info">Osteoporosis</span>
                                    </td>
                                    <td>2</td>
                                    <td><span class="badge badge-success">Active</span></td>
                                </tr>
                                <tr>
                                    <td>DMK-2024-005</td>
                                    <td>Krishna Tamang</td>
                                    <td>88</td>
                                    <td>Male</td>
                                    <td>6</td>
                                    <td>Jan 10, 2024</td>
                                    <td>
                                        <span class="badge badge-warning">COPD</span>
                                        <span class="badge badge-info">Diabetes</span>
                                    </td>
                                    <td>5</td>
                                    <td><span class="badge badge-warning">Monitoring</span></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    
                    <!-- Pagination -->
                    <div class="d-flex justify-content-between align-items-center mt-3">
                        <div class="text-muted">
                            Showing 1-5 of 156 patients
                        </div>
                        <div class="pagination">
                            <button class="btn btn-sm btn-outline-primary" disabled>Previous</button>
                            <button class="btn btn-sm btn-primary">1</button>
                            <button class="btn btn-sm btn-outline-primary">2</button>
                            <button class="btn btn-sm btn-outline-primary">3</button>
                            <button class="btn btn-sm btn-outline-primary">Next</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <%@ include file="../common/footer.jsp" %>
    
    <style>
        .dropdown {
            position: relative;
        }
        
        .dropdown-menu {
            position: absolute;
            top: 100%;
            right: 0;
            background: white;
            border: 1px solid var(--border-color);
            border-radius: 4px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            min-width: 200px;
            z-index: 1000;
            display: none;
        }
        
        .dropdown-menu.show {
            display: block;
        }
        
        .dropdown-item {
            display: block;
            padding: 0.5rem 1rem;
            color: var(--dark-color);
            text-decoration: none;
            border-bottom: 1px solid var(--border-color);
        }
        
        .dropdown-item:last-child {
            border-bottom: none;
        }
        
        .dropdown-item:hover {
            background-color: var(--light-color);
        }
        
        .stat-change {
            font-size: 0.8rem;
            margin-top: 0.25rem;
        }
        
        .pagination {
            display: flex;
            gap: 0.25rem;
        }
        
        .pagination .btn {
            min-width: 40px;
        }
        
        @media print {
            .page-header,
            .card-header button,
            .btn {
                display: none !important;
            }
            
            .card {
                border: none !important;
                box-shadow: none !important;
            }
        }
    </style>
    
    <script>
        // Initialize charts when page loads
        document.addEventListener('DOMContentLoaded', function() {
            initializeCharts();
            setDefaultDates();
        });
        
        function setDefaultDates() {
            const today = new Date();
            const thirtyDaysAgo = new Date(today.getTime() - (30 * 24 * 60 * 60 * 1000));
            
            document.getElementById('dateFrom').value = thirtyDaysAgo.toISOString().split('T')[0];
            document.getElementById('dateTo').value = today.toISOString().split('T')[0];
        }
        
        function initializeCharts() {
            // Patient Registration Trend Chart
            const registrationCtx = document.getElementById('registrationChart').getContext('2d');
            new Chart(registrationCtx, {
                type: 'line',
                data: {
                    labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                    datasets: [{
                        label: 'New Registrations',
                        data: [12, 15, 18, 14, 16, 20, 22, 18, 25, 19, 23, 21],
                        borderColor: '#007bff',
                        backgroundColor: 'rgba(0, 123, 255, 0.1)',
                        tension: 0.4
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
            
            // Ward Distribution Chart
            const wardCtx = document.getElementById('wardChart').getContext('2d');
            new Chart(wardCtx, {
                type: 'bar',
                data: {
                    labels: ['Ward 1', 'Ward 2', 'Ward 3', 'Ward 4', 'Ward 5', 'Ward 6', 'Ward 7', 'Ward 8', 'Ward 9', 'Ward 10'],
                    datasets: [{
                        label: 'Patients',
                        data: [18, 22, 15, 19, 25, 16, 20, 14, 17, 21],
                        backgroundColor: [
                            '#FF6384', '#36A2EB', '#FFCE56', '#4BC0C0', '#9966FF',
                            '#FF9F40', '#FF6384', '#C9CBCF', '#4BC0C0', '#36A2EB'
                        ]
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
            
            // Age Group Distribution Chart
            const ageCtx = document.getElementById('ageChart').getContext('2d');
            new Chart(ageCtx, {
                type: 'doughnut',
                data: {
                    labels: ['80-85 years', '86-90 years', '91-95 years', '95+ years'],
                    datasets: [{
                        data: [45, 38, 22, 8],
                        backgroundColor: ['#36A2EB', '#FFCE56', '#FF6384', '#4BC0C0']
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            position: 'bottom'
                        }
                    }
                }
            });
            
            // Common Conditions Chart
            const conditionsCtx = document.getElementById('conditionsChart').getContext('2d');
            new Chart(conditionsCtx, {
                type: 'horizontalBar',
                data: {
                    labels: ['Hypertension', 'Diabetes', 'Arthritis', 'Heart Disease', 'COPD', 'Osteoporosis'],
                    datasets: [{
                        label: 'Number of Patients',
                        data: [78, 65, 52, 48, 35, 28],
                        backgroundColor: '#FF6384'
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    scales: {
                        x: {
                            beginAtZero: true
                        }
                    }
                }
            });
            
            // Monthly Appointments Chart
            const appointmentsCtx = document.getElementById('appointmentsChart').getContext('2d');
            new Chart(appointmentsCtx, {
                type: 'bar',
                data: {
                    labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                    datasets: [{
                        label: 'Scheduled',
                        data: [120, 135, 148, 132, 156, 142, 168, 155, 172, 148, 165, 158],
                        backgroundColor: '#36A2EB'
                    }, {
                        label: 'Completed',
                        data: [115, 128, 142, 125, 148, 135, 160, 148, 165, 142, 158, 152],
                        backgroundColor: '#4BC0C0'
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
            
            // Medication Distribution Chart
            const medicationCtx = document.getElementById('medicationChart').getContext('2d');
            new Chart(medicationCtx, {
                type: 'pie',
                data: {
                    labels: ['Hypertension Meds', 'Diabetes Meds', 'Pain Relief', 'Heart Medications', 'Others'],
                    datasets: [{
                        data: [35, 28, 18, 12, 7],
                        backgroundColor: ['#FF6384', '#36A2EB', '#FFCE56', '#4BC0C0', '#9966FF']
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            position: 'bottom'
                        }
                    }
                }
            });
        }
        
        function toggleDropdown() {
            const dropdown = document.getElementById('reportDropdown');
            dropdown.classList.toggle('show');
        }
        
        // Close dropdown when clicking outside
        document.addEventListener('click', function(e) {
            if (!e.target.closest('.dropdown')) {
                document.getElementById('reportDropdown').classList.remove('show');
            }
        });
        
        function generateReport(reportType) {
            document.getElementById('reportDropdown').classList.remove('show');
            
            switch(reportType) {
                case 'patient-summary':
                    alert('Generating Patient Summary Report...');
                    break;
                case 'medical-records':
                    alert('Generating Medical Records Report...');
                    break;
                case 'medications':
                    alert('Generating Medication Report...');
                    break;
                case 'appointments':
                    alert('Generating Appointment Report...');
                    break;
                case 'ward-wise':
                    alert('Generating Ward-wise Report...');
                    break;
            }
            
            // Here you would typically make an AJAX call to generate the report
            // and then download or display it
        }
        
        function exportData() {
            alert('Exporting data to Excel...');
            // Here you would implement the export functionality
        }
        
        function updateReports() {
            // This function would be called when filters change
            // It would update the charts and statistics based on the selected filters
            console.log('Updating reports with new filters...');
            
            // Update statistics
            updateStatistics();
        }
        
        function updateStatistics() {
            // Mock update of statistics based on filters
            const dateFrom = document.getElementById('dateFrom').value;
            const dateTo = document.getElementById('dateTo').value;
            const ward = document.getElementById('wardFilter').value;
            const ageGroup = document.getElementById('ageGroup').value;
            
            // Here you would make an AJAX call to get updated statistics
            // For now, we'll just show that the function is working
            console.log('Filters:', { dateFrom, dateTo, ward, ageGroup });
        }
        
        function printTable() {
            window.print();
        }
        
        function exportTableToCSV() {
            const table = document.getElementById('patientsReportTable');
            const rows = table.querySelectorAll('tr');
            let csv = [];
            
            for (let i = 0; i < rows.length; i++) {
                const row = rows[i];
                const cols = row.querySelectorAll('td, th');
                let csvRow = [];
                
                for (let j = 0; j < cols.length; j++) {
                    let cellText = cols[j].innerText.replace(/"/g, '""');
                    csvRow.push('"' + cellText + '"');
                }
                
                csv.push(csvRow.join(','));
            }
            
            const csvContent = csv.join('\n');
            const blob = new Blob([csvContent], { type: 'text/csv' });
            const url = window.URL.createObjectURL(blob);
            const a = document.createElement('a');
            a.href = url;
            a.download = 'patients_report.csv';
            a.click();
            window.URL.revokeObjectURL(url);
        }
    </script>
</body>
</html>
