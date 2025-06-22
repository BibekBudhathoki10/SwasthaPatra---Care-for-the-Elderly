<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Notifications Panel - Damak Medical System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <%@ include file="../common/header.jsp" %>
    
    <div class="main-content">
        <div class="container">
            <div class="page-header">
                <div class="row">
                    <div class="col-8">
                        <h1 class="page-title">Notifications & Alerts</h1>
                        <p class="page-subtitle">System alerts, reminders, and important notifications</p>
                    </div>
                    <div class="col-4 text-right">
                        <button class="btn btn-primary" onclick="markAllAsRead()">
                            Mark All as Read
                        </button>
                        <button class="btn btn-info" onclick="refreshNotifications()">
                            Refresh
                        </button>
                    </div>
                </div>
            </div>
            
            <!-- Notification Statistics -->
            <div class="dashboard-stats mb-4">
                <div class="stat-card">
                    <div class="stat-number text-danger" id="criticalAlerts">3</div>
                    <div class="stat-label">Critical Alerts</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number text-warning" id="pendingReminders">12</div>
                    <div class="stat-label">Pending Reminders</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number text-info" id="todayAppointments">8</div>
                    <div class="stat-label">Today's Appointments</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number text-success" id="systemStatus">Online</div>
                    <div class="stat-label">System Status</div>
                </div>
            </div>
            
            <!-- Notification Filters -->
            <div class="card mb-4">
                <div class="card-body">
                    <div class="row align-items-center">
                        <div class="col-3">
                            <select id="notificationFilter" class="form-control form-select" onchange="filterNotifications()">
                                <option value="all">All Notifications</option>
                                <option value="critical">Critical Alerts</option>
                                <option value="appointments">Appointments</option>
                                <option value="medications">Medications</option>
                                <option value="system">System</option>
                                <option value="unread">Unread Only</option>
                            </select>
                        </div>
                        <div class="col-3">
                            <select id="priorityFilter" class="form-control form-select" onchange="filterNotifications()">
                                <option value="all">All Priorities</option>
                                <option value="high">High Priority</option>
                                <option value="medium">Medium Priority</option>
                                <option value="low">Low Priority</option>
                            </select>
                        </div>
                        <div class="col-3">
                            <input type="date" id="dateFilter" class="form-control" onchange="filterNotifications()">
                        </div>
                        <div class="col-3">
                            <button class="btn btn-outline-secondary" onclick="clearFilters()">
                                Clear Filters
                            </button>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Notifications List -->
            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-header">
                            <h6 class="mb-0">Recent Notifications</h6>
                        </div>
                        <div class="card-body">
                            <div id="notificationsList">
                                <!-- Critical Alerts -->
                                <div class="notification-item critical unread" data-type="critical" data-priority="high" data-date="2024-01-20">
                                    <div class="notification-icon">
                                        <div class="alert-icon critical">⚠️</div>
                                    </div>
                                    <div class="notification-content">
                                        <div class="notification-header">
                                            <h6 class="notification-title">Critical: Patient Emergency Alert</h6>
                                            <div class="notification-meta">
                                                <span class="badge badge-danger">Critical</span>
                                                <span class="notification-time">2 minutes ago</span>
                                            </div>
                                        </div>
                                        <div class="notification-message">
                                            Patient Ram Bahadur Thapa (DMK-2024-001) requires immediate medical attention. 
                                            Blood pressure reading: 180/110 mmHg
                                        </div>
                                        <div class="notification-actions">
                                            <button class="btn btn-sm btn-danger" onclick="handleEmergency(1)">
                                                Handle Emergency
                                            </button>
                                            <button class="btn btn-sm btn-outline-primary" onclick="viewPatient(1)">
                                                View Patient
                                            </button>
                                        </div>
                                    </div>
                                    <div class="notification-controls">
                                        <button class="btn btn-sm btn-outline-secondary" onclick="markAsRead(this)">
                                            Mark Read
                                        </button>
                                        <button class="btn btn-sm btn-outline-danger" onclick="dismissNotification(this)">
                                            Dismiss
                                        </button>
                                    </div>
                                </div>
                                
                                <!-- Appointment Reminders -->
                                <div class="notification-item appointment unread" data-type="appointments" data-priority="medium" data-date="2024-01-20">
                                    <div class="notification-icon">
                                        <div class="alert-icon appointment">📅</div>
                                    </div>
                                    <div class="notification-content">
                                        <div class="notification-header">
                                            <h6 class="notification-title">Upcoming Appointment Reminder</h6>
                                            <div class="notification-meta">
                                                <span class="badge badge-info">Appointment</span>
                                                <span class="notification-time">15 minutes ago</span>
                                            </div>
                                        </div>
                                        <div class="notification-message">
                                            Appointment scheduled for Kamala Sharma (DMK-2024-002) at 10:30 AM today. 
                                            Type: Follow-up consultation
                                        </div>
                                        <div class="notification-actions">
                                            <button class="btn btn-sm btn-info" onclick="viewAppointment(2)">
                                                View Appointment
                                            </button>
                                            <button class="btn btn-sm btn-outline-warning" onclick="rescheduleAppointment(2)">
                                                Reschedule
                                            </button>
                                        </div>
                                    </div>
                                    <div class="notification-controls">
                                        <button class="btn btn-sm btn-outline-secondary" onclick="markAsRead(this)">
                                            Mark Read
                                        </button>
                                        <button class="btn btn-sm btn-outline-danger" onclick="dismissNotification(this)">
                                            Dismiss
                                        </button>
                                    </div>
                                </div>
                                
                                <!-- Medication Alerts -->
                                <div class="notification-item medication unread" data-type="medications" data-priority="high" data-date="2024-01-20">
                                    <div class="notification-icon">
                                        <div class="alert-icon medication">💊</div>
                                    </div>
                                    <div class="notification-content">
                                        <div class="notification-header">
                                            <h6 class="notification-title">Medication Refill Required</h6>
                                            <div class="notification-meta">
                                                <span class="badge badge-warning">Medication</span>
                                                <span class="notification-time">1 hour ago</span>
                                            </div>
                                        </div>
                                        <div class="notification-message">
                                            Patient Bir Bahadur Rai (DMK-2024-003) needs medication refill for Amlodipine 5mg. 
                                            Current supply expires in 3 days.
                                        </div>
                                        <div class="notification-actions">
                                            <button class="btn btn-sm btn-success" onclick="processMedicationRefill(3)">
                                                Process Refill
                                            </button>
                                            <button class="btn btn-sm btn-outline-primary" onclick="viewMedications(3)">
                                                View Medications
                                            </button>
                                        </div>
                                    </div>
                                    <div class="notification-controls">
                                        <button class="btn btn-sm btn-outline-secondary" onclick="markAsRead(this)">
                                            Mark Read
                                        </button>
                                        <button class="btn btn-sm btn-outline-danger" onclick="dismissNotification(this)">
                                            Dismiss
                                        </button>
                                    </div>
                                </div>
                                
                                <!-- System Notifications -->
                                <div class="notification-item system read" data-type="system" data-priority="low" data-date="2024-01-20">
                                    <div class="notification-icon">
                                        <div class="alert-icon system">⚙️</div>
                                    </div>
                                    <div class="notification-content">
                                        <div class="notification-header">
                                            <h6 class="notification-title">System Backup Completed</h6>
                                            <div class="notification-meta">
                                                <span class="badge badge-success">System</span>
                                                <span class="notification-time">2 hours ago</span>
                                            </div>
                                        </div>
                                        <div class="notification-message">
                                            Daily system backup completed successfully. All patient data has been securely backed up.
                                        </div>
                                    </div>
                                    <div class="notification-controls">
                                        <button class="btn btn-sm btn-outline-danger" onclick="dismissNotification(this)">
                                            Dismiss
                                        </button>
                                    </div>
                                </div>
                                
                                <!-- Lab Results -->
                                <div class="notification-item lab unread" data-type="lab" data-priority="medium" data-date="2024-01-19">
                                    <div class="notification-icon">
                                        <div class="alert-icon lab">🧪</div>
                                    </div>
                                    <div class="notification-content">
                                        <div class="notification-header">
                                            <h6 class="notification-title">Lab Results Available</h6>
                                            <div class="notification-meta">
                                                <span class="badge badge-info">Lab Results</span>
                                                <span class="notification-time">Yesterday</span>
                                            </div>
                                        </div>
                                        <div class="notification-message">
                                            Lab results for Devi Limbu (DMK-2024-004) are now available. 
                                            HbA1c: 7.2% (High) - Review recommended.
                                        </div>
                                        <div class="notification-actions">
                                            <button class="btn btn-sm btn-primary" onclick="viewLabResults(4)">
                                                View Results
                                            </button>
                                            <button class="btn btn-sm btn-outline-success" onclick="scheduleFollowUp(4)">
                                                Schedule Follow-up
                                            </button>
                                        </div>
                                    </div>
                                    <div class="notification-controls">
                                        <button class="btn btn-sm btn-outline-secondary" onclick="markAsRead(this)">
                                            Mark Read
                                        </button>
                                        <button class="btn btn-sm btn-outline-danger" onclick="dismissNotification(this)">
                                            Dismiss
                                        </button>
                                    </div>
                                </div>
                                
                                <!-- Birthday Reminders -->
                                <div class="notification-item birthday read" data-type="birthday" data-priority="low" data-date="2024-01-19">
                                    <div class="notification-icon">
                                        <div class="alert-icon birthday">🎂</div>
                                    </div>
                                    <div class="notification-content">
                                        <div class="notification-header">
                                            <h6 class="notification-title">Patient Birthday</h6>
                                            <div class="notification-meta">
                                                <span class="badge badge-primary">Birthday</span>
                                                <span class="notification-time">Yesterday</span>
                                            </div>
                                        </div>
                                        <div class="notification-message">
                                            Krishna Tamang (DMK-2024-005) celebrated their 89th birthday yesterday. 
                                            Consider sending birthday wishes!
                                        </div>
                                    </div>
                                    <div class="notification-controls">
                                        <button class="btn btn-sm btn-outline-danger" onclick="dismissNotification(this)">
                                            Dismiss
                                        </button>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Load More Button -->
                            <div class="text-center mt-4">
                                <button class="btn btn-outline-primary" onclick="loadMoreNotifications()">
                                    Load More Notifications
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <%@ include file="../common/footer.jsp" %>
    
    <style>
        .notification-item {
            display: flex;
            padding: 1rem;
            margin-bottom: 1rem;
            border-radius: 8px;
            border: 1px solid var(--border-color);
            transition: all 0.3s;
        }
        
        .notification-item.unread {
            background-color: #f8f9ff;
            border-left: 4px solid var(--primary-color);
        }
        
        .notification-item.read {
            background-color: #f8f9fa;
            opacity: 0.8;
        }
        
        .notification-item.critical {
            border-left-color: var(--danger-color);
            background-color: #fff5f5;
        }
        
        .notification-icon {
            margin-right: 1rem;
            flex-shrink: 0;
        }
        
        .alert-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
        }
        
        .alert-icon.critical {
            background-color: #fee;
            color: var(--danger-color);
        }
        
        .alert-icon.appointment {
            background-color: #e3f2fd;
            color: var(--info-color);
        }
        
        .alert-icon.medication {
            background-color: #fff3e0;
            color: var(--warning-color);
        }
        
        .alert-icon.system {
            background-color: #e8f5e8;
            color: var(--success-color);
        }
        
        .alert-icon.lab {
            background-color: #f3e5f5;
            color: #9c27b0;
        }
        
        .alert-icon.birthday {
            background-color: #fff8e1;
            color: #ff9800;
        }
        
        .notification-content {
            flex: 1;
            margin-right: 1rem;
        }
        
        .notification-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 0.5rem;
        }
        
        .notification-title {
            margin-bottom: 0;
            color: var(--dark-color);
        }
        
        .notification-meta {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .notification-time {
            font-size: 0.8rem;
            color: var(--muted-color);
        }
        
        .notification-message {
            color: var(--muted-color);
            margin-bottom: 0.75rem;
            line-height: 1.4;
        }
        
        .notification-actions {
            display: flex;
            gap: 0.5rem;
            flex-wrap: wrap;
        }
        
        .notification-controls {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
            flex-shrink: 0;
        }
        
        .notification-controls .btn {
            min-width: 80px;
        }
        
        @media (max-width: 768px) {
            .notification-item {
                flex-direction: column;
            }
            
            .notification-icon {
                margin-right: 0;
                margin-bottom: 0.5rem;
                align-self: flex-start;
            }
            
            .notification-content {
                margin-right: 0;
                margin-bottom: 0.5rem;
            }
            
            .notification-controls {
                flex-direction: row;
                justify-content: flex-end;
            }
            
            .notification-actions {
                margin-top: 0.5rem;
            }
        }
    </style>
    
    <script>
        // Initialize notifications
        document.addEventListener('DOMContentLoaded', function() {
            updateNotificationCounts();
            
            // Set up auto-refresh every 30 seconds
            setInterval(refreshNotifications, 30000);
        });
        
        function updateNotificationCounts() {
            const notifications = document.querySelectorAll('.notification-item');
            let critical = 0, pending = 0, appointments = 0;
            
            notifications.forEach(notification => {
                if (notification.classList.contains('unread')) {
                    if (notification.dataset.type === 'critical') critical++;
                    if (notification.dataset.type === 'appointments') appointments++;
                    if (notification.dataset.priority === 'high' || notification.dataset.priority === 'medium') pending++;
                }
            });
            
            document.getElementById('criticalAlerts').textContent = critical;
            document.getElementById('pendingReminders').textContent = pending;
            document.getElementById('todayAppointments').textContent = appointments;
        }
        
        function markAsRead(button) {
            const notificationItem = button.closest('.notification-item');
            notificationItem.classList.remove('unread');
            notificationItem.classList.add('read');
            
            // Remove the "Mark Read" button
            button.remove();
            
            updateNotificationCounts();
            
            // Here you would make an AJAX call to mark the notification as read in the database
        }
        
        function dismissNotification(button) {
            const notificationItem = button.closest('.notification-item');
            notificationItem.style.opacity = '0';
            notificationItem.style.transform = 'translateX(100%)';
            
            setTimeout(() => {
                notificationItem.remove();
                updateNotificationCounts();
            }, 300);
            
            // Here you would make an AJAX call to dismiss the notification in the database
        }
        
        function markAllAsRead() {
            const unreadNotifications = document.querySelectorAll('.notification-item.unread');
            
            unreadNotifications.forEach(notification => {
                notification.classList.remove('unread');
                notification.classList.add('read');
                
                const markReadBtn = notification.querySelector('.notification-controls .btn-outline-secondary');
                if (markReadBtn && markReadBtn.textContent.includes('Mark Read')) {
                    markReadBtn.remove();
                }
            });
            
            updateNotificationCounts();
            
            // Here you would make an AJAX call to mark all notifications as read
        }
        
        function refreshNotifications() {
            // Here you would make an AJAX call to fetch new notifications
            console.log('Refreshing notifications...');
            
            // For demo purposes, we'll just update the counts
            updateNotificationCounts();
        }
        
        function filterNotifications() {
            const typeFilter = document.getElementById('notificationFilter').value;
            const priorityFilter = document.getElementById('priorityFilter').value;
            const dateFilter = document.getElementById('dateFilter').value;
            
            const notifications = document.querySelectorAll('.notification-item');
            
            notifications.forEach(notification => {
                let show = true;
                
                // Type filter
                if (typeFilter !== 'all') {
                    if (typeFilter === 'unread' && !notification.classList.contains('unread')) {
                        show = false;
                    } else if (typeFilter !== 'unread' && notification.dataset.type !== typeFilter) {
                        show = false;
                    }
                }
                
                // Priority filter
                if (priorityFilter !== 'all' && notification.dataset.priority !== priorityFilter) {
                    show = false;
                }
                
                // Date filter
                if (dateFilter && notification.dataset.date !== dateFilter) {
                    show = false;
                }
                
                notification.style.display = show ? 'flex' : 'none';
            });
        }
        
        function clearFilters() {
            document.getElementById('notificationFilter').value = 'all';
            document.getElementById('priorityFilter').value = 'all';
            document.getElementById('dateFilter').value = '';
            
            const notifications = document.querySelectorAll('.notification-item');
            notifications.forEach(notification => {
                notification.style.display = 'flex';
            });
        }
        
        function loadMoreNotifications() {
            // Here you would make an AJAX call to load more notifications
            alert('Loading more notifications...');
        }
        
        // Action handlers
        function handleEmergency(patientId) {
            if (confirm('This will create an emergency alert and notify all medical staff. Continue?')) {
                alert('Emergency alert sent to all medical staff');
                // Here you would implement the emergency handling logic
            }
        }
        
        function viewPatient(patientId) {
            window.location.href = `${contextPath}/patients/${patientId}`;
        }
        
        function viewAppointment(appointmentId) {
            window.location.href = `${contextPath}/appointments/${appointmentId}`;
        }
        
        function rescheduleAppointment(appointmentId) {
            window.location.href = `${contextPath}/appointments/${appointmentId}/reschedule`;
        }
        
        function processMedicationRefill(patientId) {
            window.location.href = `${contextPath}/prescriptions/new?patientId=${patientId}`;
        }
        
        function viewMedications(patientId) {
            window.location.href = `${contextPath}/patients/${patientId}#medications`;
        }
        
        function viewLabResults(patientId) {
            window.location.href = `${contextPath}/lab-reports?patientId=${patientId}`;
        }
        
        function scheduleFollowUp(patientId) {
            window.location.href = `${contextPath}/appointments/new?patientId=${patientId}`;
        }
        
        // Real-time notifications (using WebSocket or Server-Sent Events)
        function initializeRealTimeNotifications() {
            // This would typically connect to a WebSocket or use Server-Sent Events
            // For demo purposes, we'll simulate new notifications
            
            setInterval(() => {
                if (Math.random() > 0.95) { // 5% chance every 30 seconds
                    addNewNotification();
                }
            }, 30000);
        }
        
        function addNewNotification() {
            const notifications = [
                {
                    type: 'appointment',
                    priority: 'medium',
                    title: 'New Appointment Scheduled',
                    message: 'A new appointment has been scheduled for tomorrow.',
                    icon: '📅'
                },
                {
                    type: 'medication',
                    priority: 'high',
                    title: 'Medication Alert',
                    message: 'Patient requires medication review.',
                    icon: '💊'
                }
            ];
            
            const notification = notifications[Math.floor(Math.random() * notifications.length)];
            
            // Add notification to the top of the list
            const notificationsList = document.getElementById('notificationsList');
            const newNotificationHTML = `
                <div class="notification-item ${notification.type} unread" data-type="${notification.type}" data-priority="${notification.priority}" data-date="${new Date().toISOString().split('T')[0]}">
                    <div class="notification-icon">
                        <div class="alert-icon ${notification.type}">${notification.icon}</div>
                    </div>
                    <div class="notification-content">
                        <div class="notification-header">
                            <h6 class="notification-title">${notification.title}</h6>
                            <div class="notification-meta">
                                <span class="badge badge-${notification.priority === 'high' ? 'danger' : 'info'}">${notification.type}</span>
                                <span class="notification-time">Just now</span>
                            </div>
                        </div>
                        <div class="notification-message">${notification.message}</div>
                    </div>
                    <div class="notification-controls">
                        <button class="btn btn-sm btn-outline-secondary" onclick="markAsRead(this)">Mark Read</button>
                        <button class="btn btn-sm btn-outline-danger" onclick="dismissNotification(this)">Dismiss</button>
                    </div>
                </div>
            `;
            
            notificationsList.insertAdjacentHTML('afterbegin', newNotificationHTML);
            updateNotificationCounts();
            
            // Show a toast notification
            showToast('New notification received!');
        }
        
        function showToast(message) {
            // Simple toast notification
            const toast = document.createElement('div');
            toast.className = 'toast';
            toast.textContent = message;
            toast.style.cssText = `
                position: fixed;
                top: 20px;
                right: 20px;
                background: var(--primary-color);
                color: white;
                padding: 1rem;
                border-radius: 4px;
                z-index: 9999;
                opacity: 0;
                transition: opacity 0.3s;
            `;
            
            document.body.appendChild(toast);
            
            setTimeout(() => toast.style.opacity = '1', 100);
            setTimeout(() => {
                toast.style.opacity = '0';
                setTimeout(() => document.body.removeChild(toast), 300);
            }, 3000);
        }
        
        // Initialize real-time notifications
        initializeRealTimeNotifications();
    </script>
</body>
</html>
