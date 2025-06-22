<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Appointment Scheduler - Damak Medical System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <%@ include file="../common/header.jsp" %>
    
    <div class="main-content">
        <div class="container">
            <div class="page-header">
                <div class="row">
                    <div class="col-8">
                        <h1 class="page-title">Appointment Scheduler</h1>
                        <p class="page-subtitle">Schedule and manage patient appointments</p>
                    </div>
                    <div class="col-4 text-right">
                        <button class="btn btn-primary" onclick="showNewAppointmentModal()">
                            Schedule New Appointment
                        </button>
                        <button class="btn btn-info" onclick="toggleCalendarView()">
                            <span id="viewToggleText">Calendar View</span>
                        </button>
                    </div>
                </div>
            </div>
            
            <!-- Date Navigation -->
            <div class="card mb-4">
                <div class="card-body">
                    <div class="row align-items-center">
                        <div class="col-4">
                            <div class="d-flex align-items-center">
                                <button class="btn btn-outline-primary btn-sm" onclick="changeDate(-1)">
                                    ← Previous
                                </button>
                                <button class="btn btn-outline-primary btn-sm mx-2" onclick="goToToday()">
                                    Today
                                </button>
                                <button class="btn btn-outline-primary btn-sm" onclick="changeDate(1)">
                                    Next →
                                </button>
                            </div>
                        </div>
                        <div class="col-4 text-center">
                            <h5 class="mb-0" id="currentDateDisplay">
                                January 20, 2024
                            </h5>
                        </div>
                        <div class="col-4 text-right">
                            <input type="date" 
                                   id="datePicker" 
                                   class="form-control" 
                                   style="width: auto; display: inline-block;"
                                   onchange="goToDate(this.value)">
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Appointment Statistics -->
            <div class="dashboard-stats mb-4">
                <div class="stat-card">
                    <div class="stat-number" id="todayAppointments">8</div>
                    <div class="stat-label">Today's Appointments</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number" id="scheduledCount">6</div>
                    <div class="stat-label">Scheduled</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number" id="completedCount">2</div>
                    <div class="stat-label">Completed</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number" id="availableSlots">12</div>
                    <div class="stat-label">Available Slots</div>
                </div>
            </div>
            
            <!-- Schedule View -->
            <div id="scheduleView" class="row">
                <div class="col-3">
                    <!-- Time Slots -->
                    <div class="card">
                        <div class="card-header">
                            <h6 class="mb-0">Available Time Slots</h6>
                        </div>
                        <div class="card-body">
                            <div class="time-slots">
                                <div class="time-slot available" data-time="09:00">
                                    <div class="time">9:00 AM</div>
                                    <div class="status">Available</div>
                                </div>
                                <div class="time-slot booked" data-time="09:30">
                                    <div class="time">9:30 AM</div>
                                    <div class="status">Booked</div>
                                </div>
                                <div class="time-slot available" data-time="10:00">
                                    <div class="time">10:00 AM</div>
                                    <div class="status">Available</div>
                                </div>
                                <div class="time-slot booked" data-time="10:30">
                                    <div class="time">10:30 AM</div>
                                    <div class="status">Booked</div>
                                </div>
                                <div class="time-slot available" data-time="11:00">
                                    <div class="time">11:00 AM</div>
                                    <div class="status">Available</div>
                                </div>
                                <div class="time-slot available" data-time="11:30">
                                    <div class="time">11:30 AM</div>
                                    <div class="status">Available</div>
                                </div>
                                <div class="time-slot break" data-time="12:00">
                                    <div class="time">12:00 PM</div>
                                    <div class="status">Lunch Break</div>
                                </div>
                                <div class="time-slot available" data-time="13:00">
                                    <div class="time">1:00 PM</div>
                                    <div class="status">Available</div>
                                </div>
                                <div class="time-slot booked" data-time="13:30">
                                    <div class="time">1:30 PM</div>
                                    <div class="status">Booked</div>
                                </div>
                                <div class="time-slot available" data-time="14:00">
                                    <div class="time">2:00 PM</div>
                                    <div class="status">Available</div>
                                </div>
                                <div class="time-slot available" data-time="14:30">
                                    <div class="time">2:30 PM</div>
                                    <div class="status">Available</div>
                                </div>
                                <div class="time-slot available" data-time="15:00">
                                    <div class="time">3:00 PM</div>
                                    <div class="status">Available</div>
                                </div>
                                <div class="time-slot available" data-time="15:30">
                                    <div class="time">3:30 PM</div>
                                    <div class="status">Available</div>
                                </div>
                                <div class="time-slot available" data-time="16:00">
                                    <div class="time">4:00 PM</div>
                                    <div class="status">Available</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-9">
                    <!-- Appointments List -->
                    <div class="card">
                        <div class="card-header">
                            <h6 class="mb-0">Today's Appointments</h6>
                        </div>
                        <div class="card-body">
                            <div class="appointments-list">
                                <!-- Scheduled Appointments -->
                                <div class="appointment-item scheduled">
                                    <div class="appointment-time">9:30 AM</div>
                                    <div class="appointment-details">
                                        <div class="patient-info">
                                            <h6 class="patient-name">Ram Bahadur Thapa</h6>
                                            <div class="patient-meta">
                                                <span class="patient-code">DMK-2024-001</span> • 
                                                <span class="patient-age">84 years</span> • 
                                                <span class="patient-ward">Ward 5</span>
                                            </div>
                                        </div>
                                        <div class="appointment-info">
                                            <div class="appointment-type">
                                                <span class="badge badge-info">Regular Checkup</span>
                                            </div>
                                            <div class="appointment-staff">Dr. Rajesh Sharma</div>
                                        </div>
                                    </div>
                                    <div class="appointment-actions">
                                        <button class="btn btn-sm btn-success" onclick="markCompleted(1)">
                                            Complete
                                        </button>
                                        <button class="btn btn-sm btn-warning" onclick="rescheduleAppointment(1)">
                                            Reschedule
                                        </button>
                                        <button class="btn btn-sm btn-danger" onclick="cancelAppointment(1)">
                                            Cancel
                                        </button>
                                    </div>
                                </div>
                                
                                <div class="appointment-item scheduled">
                                    <div class="appointment-time">10:30 AM</div>
                                    <div class="appointment-details">
                                        <div class="patient-info">
                                            <h6 class="patient-name">Kamala Sharma</h6>
                                            <div class="patient-meta">
                                                <span class="patient-code">DMK-2024-002</span> • 
                                                <span class="patient-age">86 years</span> • 
                                                <span class="patient-ward">Ward 3</span>
                                            </div>
                                        </div>
                                        <div class="appointment-info">
                                            <div class="appointment-type">
                                                <span class="badge badge-warning">Follow-up</span>
                                            </div>
                                            <div class="appointment-staff">Dr. Rajesh Sharma</div>
                                        </div>
                                    </div>
                                    <div class="appointment-actions">
                                        <button class="btn btn-sm btn-success" onclick="markCompleted(2)">
                                            Complete
                                        </button>
                                        <button class="btn btn-sm btn-warning" onclick="rescheduleAppointment(2)">
                                            Reschedule
                                        </button>
                                        <button class="btn btn-sm btn-danger" onclick="cancelAppointment(2)">
                                            Cancel
                                        </button>
                                    </div>
                                </div>
                                
                                <div class="appointment-item completed">
                                    <div class="appointment-time">1:30 PM</div>
                                    <div class="appointment-details">
                                        <div class="patient-info">
                                            <h6 class="patient-name">Bir Bahadur Rai</h6>
                                            <div class="patient-meta">
                                                <span class="patient-code">DMK-2024-003</span> • 
                                                <span class="patient-age">82 years</span> • 
                                                <span class="patient-ward">Ward 7</span>
                                            </div>
                                        </div>
                                        <div class="appointment-info">
                                            <div class="appointment-type">
                                                <span class="badge badge-success">Consultation</span>
                                            </div>
                                            <div class="appointment-staff">Dr. Rajesh Sharma</div>
                                            <div class="appointment-outcome">
                                                <small class="text-success">✓ Completed - Prescription updated</small>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="appointment-actions">
                                        <button class="btn btn-sm btn-outline-primary" onclick="viewAppointmentDetails(3)">
                                            View Details
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Calendar View (Hidden by default) -->
            <div id="calendarView" class="card" style="display: none;">
                <div class="card-header">
                    <h6 class="mb-0">Monthly Calendar</h6>
                </div>
                <div class="card-body">
                    <div class="calendar-container">
                        <div class="calendar-header">
                            <button class="btn btn-sm btn-outline-primary" onclick="changeMonth(-1)">
                                ← Previous
                            </button>
                            <h5 id="calendarMonthYear">January 2024</h5>
                            <button class="btn btn-sm btn-outline-primary" onclick="changeMonth(1)">
                                Next →
                            </button>
                        </div>
                        
                        <div class="calendar-grid">
                            <div class="calendar-day-header">Sun</div>
                            <div class="calendar-day-header">Mon</div>
                            <div class="calendar-day-header">Tue</div>
                            <div class="calendar-day-header">Wed</div>
                            <div class="calendar-day-header">Thu</div>
                            <div class="calendar-day-header">Fri</div>
                            <div class="calendar-day-header">Sat</div>
                            
                            <!-- Calendar days will be generated by JavaScript -->
                            <div id="calendarDays"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- New Appointment Modal -->
    <div id="newAppointmentModal" class="modal" style="display: none;">
        <div class="modal-content">
            <div class="modal-header">
                <h5>Schedule New Appointment</h5>
                <button type="button" class="close" onclick="closeNewAppointmentModal()">×</button>
            </div>
            <form id="newAppointmentForm">
                <div class="modal-body">
                    <div class="form-group">
                        <label for="appointmentPatient" class="form-label required">Patient</label>
                        <input type="text" 
                               id="appointmentPatient" 
                               class="form-control" 
                               placeholder="Search patient by name or code..."
                               autocomplete="off">
                        <input type="hidden" id="selectedAppointmentPatientId">
                        <div id="appointmentPatientResults" class="search-results"></div>
                    </div>
                    
                    <div class="row">
                        <div class="col-6">
                            <div class="form-group">
                                <label for="appointmentDate" class="form-label required">Date</label>
                                <input type="date" 
                                       id="appointmentDate" 
                                       class="form-control" 
                                       required>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="form-group">
                                <label for="appointmentTime" class="form-label required">Time</label>
                                <select id="appointmentTime" class="form-control form-select" required>
                                    <option value="">Select Time</option>
                                    <option value="09:00">9:00 AM</option>
                                    <option value="09:30">9:30 AM</option>
                                    <option value="10:00">10:00 AM</option>
                                    <option value="10:30">10:30 AM</option>
                                    <option value="11:00">11:00 AM</option>
                                    <option value="11:30">11:30 AM</option>
                                    <option value="13:00">1:00 PM</option>
                                    <option value="13:30">1:30 PM</option>
                                    <option value="14:00">2:00 PM</option>
                                    <option value="14:30">2:30 PM</option>
                                    <option value="15:00">3:00 PM</option>
                                    <option value="15:30">3:30 PM</option>
                                    <option value="16:00">4:00 PM</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-6">
                            <div class="form-group">
                                <label for="appointmentType" class="form-label required">Appointment Type</label>
                                <select id="appointmentType" class="form-control form-select" required>
                                    <option value="">Select Type</option>
                                    <option value="REGULAR_CHECKUP">Regular Checkup</option>
                                    <option value="FOLLOW_UP">Follow-up</option>
                                    <option value="EMERGENCY">Emergency</option>
                                    <option value="CONSULTATION">Consultation</option>
                                    <option value="VACCINATION">Vaccination</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="form-group">
                                <label for="appointmentStaff" class="form-label">Assigned Staff</label>
                                <select id="appointmentStaff" class="form-control form-select">
                                    <option value="">Auto-assign</option>
                                    <option value="2">Dr. Rajesh Sharma</option>
                                    <option value="3">Maya Gurung (Nurse)</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="appointmentPurpose" class="form-label">Purpose/Notes</label>
                        <textarea id="appointmentPurpose" 
                                  class="form-control" 
                                  rows="3" 
                                  placeholder="Reason for appointment, special instructions..."></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" onclick="closeNewAppointmentModal()">
                        Cancel
                    </button>
                    <button type="submit" class="btn btn-primary">
                        Schedule Appointment
                    </button>
                </div>
            </form>
        </div>
    </div>
    
    <%@ include file="../common/footer.jsp" %>
    
    <style>
        .time-slots {
            max-height: 600px;
            overflow-y: auto;
        }
        
        .time-slot {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0.75rem;
            margin-bottom: 0.5rem;
            border-radius: 4px;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .time-slot.available {
            background-color: #d4edda;
            border: 1px solid #c3e6cb;
            color: #155724;
        }
        
        .time-slot.available:hover {
            background-color: #c3e6cb;
        }
        
        .time-slot.booked {
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
            color: #721c24;
            cursor: not-allowed;
        }
        
        .time-slot.break {
            background-color: #fff3cd;
            border: 1px solid #ffeaa7;
            color: #856404;
            cursor: not-allowed;
        }
        
        .time-slot .time {
            font-weight: 600;
        }
        
        .time-slot .status {
            font-size: 0.8rem;
        }
        
        .appointment-item {
            display: flex;
            align-items: center;
            padding: 1rem;
            margin-bottom: 1rem;
            border-radius: 8px;
            border-left: 4px solid;
        }
        
        .appointment-item.scheduled {
            background-color: #e3f2fd;
            border-left-color: #2196f3;
        }
        
        .appointment-item.completed {
            background-color: #e8f5e8;
            border-left-color: #4caf50;
        }
        
        .appointment-item.cancelled {
            background-color: #ffebee;
            border-left-color: #f44336;
        }
        
        .appointment-time {
            font-size: 1.1rem;
            font-weight: 600;
            min-width: 80px;
            color: var(--primary-color);
        }
        
        .appointment-details {
            flex: 1;
            margin: 0 1rem;
        }
        
        .patient-name {
            margin-bottom: 0.25rem;
            color: var(--dark-color);
        }
        
        .patient-meta {
            font-size: 0.85rem;
            color: var(--muted-color);
        }
        
        .appointment-info {
            margin-top: 0.5rem;
        }
        
        .appointment-staff {
            font-size: 0.9rem;
            color: var(--muted-color);
            margin-top: 0.25rem;
        }
        
        .appointment-actions {
            display: flex;
            gap: 0.5rem;
            flex-wrap: wrap;
        }
        
        .calendar-container {
            max-width: 100%;
        }
        
        .calendar-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
        }
        
        .calendar-grid {
            display: grid;
            grid-template-columns: repeat(7, 1fr);
            gap: 1px;
            background-color: var(--border-color);
            border: 1px solid var(--border-color);
        }
        
        .calendar-day-header {
            background-color: var(--light-color);
            padding: 0.75rem;
            text-align: center;
            font-weight: 600;
            color: var(--dark-color);
        }
        
        .calendar-day {
            background-color: white;
            padding: 0.5rem;
            min-height: 80px;
            position: relative;
            cursor: pointer;
        }
        
        .calendar-day:hover {
            background-color: var(--light-color);
        }
        
        .calendar-day.other-month {
            background-color: #f8f9fa;
            color: var(--muted-color);
        }
        
        .calendar-day.today {
            background-color: var(--primary-color);
            color: white;
        }
        
        .calendar-day.has-appointments {
            border-left: 4px solid var(--success-color);
        }
        
        .appointment-count {
            position: absolute;
            top: 0.25rem;
            right: 0.25rem;
            background-color: var(--primary-color);
            color: white;
            border-radius: 50%;
            width: 20px;
            height: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.7rem;
            font-weight: 600;
        }
        
        .modal {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 1000;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .modal-content {
            background: white;
            border-radius: 8px;
            width: 90%;
            max-width: 600px;
            max-height: 90vh;
            overflow-y: auto;
        }
        
        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem 1.5rem;
            border-bottom: 1px solid var(--border-color);
        }
        
        .modal-body {
            padding: 1.5rem;
        }
        
        .modal-footer {
            display: flex;
            justify-content: flex-end;
            gap: 0.5rem;
            padding: 1rem 1.5rem;
            border-top: 1px solid var(--border-color);
        }
        
        .close {
            background: none;
            border: none;
            font-size: 1.5rem;
            cursor: pointer;
            color: var(--muted-color);
        }
        
        .close:hover {
            color: var(--dark-color);
        }
        
        @media (max-width: 768px) {
            .appointment-item {
                flex-direction: column;
                align-items: flex-start;
            }
            
            .appointment-time {
                margin-bottom: 0.5rem;
            }
            
            .appointment-actions {
                margin-top: 0.5rem;
                width: 100%;
            }
            
            .appointment-actions .btn {
                flex: 1;
            }
        }
    </style>
    
    <script>
        let currentDate = new Date();
        let currentView = 'schedule';
        
        // Initialize the page
        document.addEventListener('DOMContentLoaded', function() {
            updateDateDisplay();
            document.getElementById('datePicker').value = formatDateForInput(currentDate);
            document.getElementById('appointmentDate').value = formatDateForInput(currentDate);
        });
        
        // Date navigation functions
        function changeDate(days) {
            currentDate.setDate(currentDate.getDate() + days);
            updateDateDisplay();
            document.getElementById('datePicker').value = formatDateForInput(currentDate);
            loadAppointments();
        }
        
        function goToToday() {
            currentDate = new Date();
            updateDateDisplay();
            document.getElementById('datePicker').value = formatDateForInput(currentDate);
            loadAppointments();
        }
        
        function goToDate(dateString) {
            currentDate = new Date(dateString);
            updateDateDisplay();
            loadAppointments();
        }
        
        function updateDateDisplay() {
            const options = { 
                weekday: 'long', 
                year: 'numeric', 
                month: 'long', 
                day: 'numeric' 
            };
            document.getElementById('currentDateDisplay').textContent = 
                currentDate.toLocaleDateString('en-US', options);
        }
        
        function formatDateForInput(date) {
            return date.toISOString().split('T')[0];
        }
        
        // View toggle functions
        function toggleCalendarView() {
            const scheduleView = document.getElementById('scheduleView');
            const calendarView = document.getElementById('calendarView');
            const toggleText = document.getElementById('viewToggleText');
            
            if (currentView === 'schedule') {
                scheduleView.style.display = 'none';
                calendarView.style.display = 'block';
                toggleText.textContent = 'Schedule View';
                currentView = 'calendar';
                generateCalendar();
            } else {
                scheduleView.style.display = 'block';
                calendarView.style.display = 'none';
                toggleText.textContent = 'Calendar View';
                currentView = 'schedule';
            }
        }
        
        // Calendar generation
        function generateCalendar() {
            const year = currentDate.getFullYear();
            const month = currentDate.getMonth();
            
            document.getElementById('calendarMonthYear').textContent = 
                new Date(year, month).toLocaleDateString('en-US', { month: 'long', year: 'numeric' });
            
            const firstDay = new Date(year, month, 1);
            const lastDay = new Date(year, month + 1, 0);
            const startDate = new Date(firstDay);
            startDate.setDate(startDate.getDate() - firstDay.getDay());
            
            const calendarDays = document.getElementById('calendarDays');
            calendarDays.innerHTML = '';
            
            for (let i = 0; i < 42; i++) {
                const date = new Date(startDate);
                date.setDate(startDate.getDate() + i);
                
                const dayElement = document.createElement('div');
                dayElement.className = 'calendar-day';
                dayElement.innerHTML = `
                    <div>${date.getDate()}</div>
                    <div class="appointment-count" style="display: none;">3</div>
                `;
                
                if (date.getMonth() !== month) {
                    dayElement.classList.add('other-month');
                }
                
                if (date.toDateString() === new Date().toDateString()) {
                    dayElement.classList.add('today');
                }
                
                // Mock appointment data
                if (Math.random() > 0.7) {
                    dayElement.classList.add('has-appointments');
                    dayElement.querySelector('.appointment-count').style.display = 'flex';
                    dayElement.querySelector('.appointment-count').textContent = Math.floor(Math.random() * 5) + 1;
                }
                
                dayElement.addEventListener('click', function() {
                    currentDate = new Date(date);
                    toggleCalendarView();
                    updateDateDisplay();
                    document.getElementById('datePicker').value = formatDateForInput(currentDate);
                    loadAppointments();
                });
                
                calendarDays.appendChild(dayElement);
            }
        }
        
        function changeMonth(months) {
            currentDate.setMonth(currentDate.getMonth() + months);
            generateCalendar();
        }
        
        // Appointment management functions
        function showNewAppointmentModal() {
            document.getElementById('newAppointmentModal').style.display = 'flex';
        }
        
        function closeNewAppointmentModal() {
            document.getElementById('newAppointmentModal').style.display = 'none';
            document.getElementById('newAppointmentForm').reset();
        }
        
        function markCompleted(appointmentId) {
            if (confirm('Mark this appointment as completed?')) {
                // Here you would make an AJAX call to update the appointment status
                alert('Appointment marked as completed');
                loadAppointments();
            }
        }
        
        function rescheduleAppointment(appointmentId) {
            // Open reschedule modal or redirect to reschedule page
            alert('Reschedule functionality would be implemented here');
        }
        
        function cancelAppointment(appointmentId) {
            if (confirm('Are you sure you want to cancel this appointment?')) {
                // Here you would make an AJAX call to cancel the appointment
                alert('Appointment cancelled');
                loadAppointments();
            }
        }
        
        function viewAppointmentDetails(appointmentId) {
            // Redirect to appointment details page or show modal
            window.location.href = `${contextPath}/appointments/${appointmentId}`;
        }
        
        function loadAppointments() {
            // This would typically make an AJAX call to load appointments for the selected date
            // For now, we'll just update the statistics
            updateStatistics();
        }
        
        function updateStatistics() {
            // Mock statistics update
            document.getElementById('todayAppointments').textContent = Math.floor(Math.random() * 15) + 5;
            document.getElementById('scheduledCount').textContent = Math.floor(Math.random() * 10) + 3;
            document.getElementById('completedCount').textContent = Math.floor(Math.random() * 5) + 1;
            document.getElementById('availableSlots').textContent = Math.floor(Math.random() * 20) + 5;
        }
        
        // Time slot selection
        document.addEventListener('click', function(e) {
            if (e.target.closest('.time-slot.available')) {
                const timeSlot = e.target.closest('.time-slot');
                const time = timeSlot.getAttribute('data-time');
                
                // Clear previous selections
                document.querySelectorAll('.time-slot').forEach(slot => {
                    slot.classList.remove('selected');
                });
                
                // Select clicked slot
                timeSlot.classList.add('selected');
                
                // Show new appointment modal with pre-selected time
                document.getElementById('appointmentTime').value = time;
                showNewAppointmentModal();
            }
        });
        
        // Patient search in appointment modal
        let appointmentSearchTimeout;
        document.getElementById('appointmentPatient').addEventListener('input', function() {
            clearTimeout(appointmentSearchTimeout);
            const query = this.value.trim();
            
            if (query.length < 2) {
                document.getElementById('appointmentPatientResults').style.display = 'none';
                return;
            }
            
            appointmentSearchTimeout = setTimeout(() => {
                searchPatientsForAppointment(query);
            }, 300);
        });
        
        function searchPatientsForAppointment(query) {
            // Mock patient search
            const mockResults = [
                {id: 1, name: 'Ram Bahadur Thapa', code: 'DMK-2024-001', age: 84},
                {id: 2, name: 'Kamala Sharma', code: 'DMK-2024-002', age: 86},
                {id: 3, name: 'Bir Bahadur Rai', code: 'DMK-2024-003', age: 82}
            ];
            
            const results = mockResults.filter(p => 
                p.name.toLowerCase().includes(query.toLowerCase()) || 
                p.code.toLowerCase().includes(query.toLowerCase())
            );
            
            const container = document.getElementById('appointmentPatientResults');
            
            if (results.length === 0) {
                container.innerHTML = '<div class="search-result-item text-muted">No patients found</div>';
            } else {
                container.innerHTML = results.map(patient => `
                    <div class="search-result-item" onclick="selectAppointmentPatient(${patient.id}, '${patient.name}', '${patient.code}')">
                        <strong>${patient.name}</strong><br>
                        <small class="text-muted">${patient.code} • Age: ${patient.age}</small>
                    </div>
                `).join('');
            }
            
            container.style.display = 'block';
        }
        
        function selectAppointmentPatient(id, name, code) {
            document.getElementById('appointmentPatient').value = `${name} (${code})`;
            document.getElementById('selectedAppointmentPatientId').value = id;
            document.getElementById('appointmentPatientResults').style.display = 'none';
        }
        
        // Form submission
        document.getElementById('newAppointmentForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            // Validate form
            const patientId = document.getElementById('selectedAppointmentPatientId').value;
            const date = document.getElementById('appointmentDate').value;
            const time = document.getElementById('appointmentTime').value;
            const type = document.getElementById('appointmentType').value;
            
            if (!patientId || !date || !time || !type) {
                alert('Please fill in all required fields');
                return;
            }
            
            // Here you would submit the form data via AJAX
            alert('Appointment scheduled successfully!');
            closeNewAppointmentModal();
            loadAppointments();
        });
        
        // Close modal when clicking outside
        document.getElementById('newAppointmentModal').addEventListener('click', function(e) {
            if (e.target === this) {
                closeNewAppointmentModal();
            }
        });
        
        // Hide search results when clicking outside
        document.addEventListener('click', function(e) {
            if (!e.target.closest('#appointmentPatient')) {
                document.getElementById('appointmentPatientResults').style.display = 'none';
            }
        });
        
        // Add selected style for time slots
        const style = document.createElement('style');
        style.textContent = `
            .time-slot.selected {
                background-color: var(--primary-color) !important;
                color: white !important;
                border-color: var(--primary-color) !important;
            }
        `;
        document.head.appendChild(style);
    </script>
</body>
</html>
