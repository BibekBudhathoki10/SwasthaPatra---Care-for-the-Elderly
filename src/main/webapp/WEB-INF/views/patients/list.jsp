<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Patient Management - Damak Municipality Medical System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <%@ include file="../common/header.jsp" %>
    
    <div class="main-content">
        <div class="container">
            <div class="page-header">
                <div class="row">
                    <div class="col-8">
                        <h1 class="page-title">Patient Management</h1>
                        <p class="page-subtitle">
                            <c:choose>
                                <c:when test="${isSearchResult}">
                                    Search results for "${searchTerm}" 
                                    <c:if test="${not empty searchType}">in ${searchType}</c:if>
                                    (${patients.size()} found)
                                </c:when>
                                <c:otherwise>
                                    Manage senior citizens (80+ years) registered in the system
                                </c:otherwise>
                            </c:choose>
                        </p>
                    </div>
                    <div class="col-4 text-right">
                        <c:if test="${sessionScope.currentUser.role == 'ADMIN' || sessionScope.currentUser.role == 'MEDICAL_STAFF'}">
                            <a href="${pageContext.request.contextPath}/patients/new" class="btn btn-primary">
                                Add New Patient
                            </a>
                        </c:if>
                    </div>
                </div>
            </div>
            
            <!-- Search Section -->
            <div class="card mb-4">
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/patients" method="get" class="row">
                        <input type="hidden" name="action" value="search">
                        <div class="col-4">
                            <select name="type" class="form-control form-select">
                                <option value="name" ${searchType == 'name' ? 'selected' : ''}>Search by Name</option>
                                <option value="code" ${searchType == 'code' ? 'selected' : ''}>Search by Patient Code</option>
                                <option value="ward" ${searchType == 'ward' ? 'selected' : ''}>Search by Ward</option>
                                <option value="phone" ${searchType == 'phone' ? 'selected' : ''}>Search by Phone</option>
                            </select>
                        </div>
                        <div class="col-6">
                            <input type="text" 
                                   name="q" 
                                   class="form-control" 
                                   placeholder="Enter search term..."
                                   value="${searchTerm}">
                        </div>
                        <div class="col-2">
                            <button type="submit" class="btn btn-info w-100">Search</button>
                        </div>
                    </form>
                    <c:if test="${isSearchResult}">
                        <div class="mt-3">
                            <a href="${pageContext.request.contextPath}/patients" class="btn btn-light btn-sm">
                                Clear Search & Show All
                            </a>
                        </div>
                    </c:if>
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
            
            <!-- Patients Table -->
            <div class="card">
                <div class="card-header">
                    <h5 class="mb-0">
                        <c:choose>
                            <c:when test="${isSearchResult}">
                                Search Results (${patients.size()} patients)
                            </c:when>
                            <c:otherwise>
                                Registered Patients (${totalRecords} total)
                            </c:otherwise>
                        </c:choose>
                    </h5>
                </div>
                <div class="card-body">
                    <c:choose>
                        <c:when test="${empty patients}">
                            <div class="text-center text-muted">
                                <p>No patients found.</p>
                                <c:if test="${sessionScope.currentUser.role == 'ADMIN' || sessionScope.currentUser.role == 'MEDICAL_STAFF'}">
                                    <a href="${pageContext.request.contextPath}/patients/new" class="btn btn-primary">
                                        Register First Patient
                                    </a>
                                </c:if>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="table-responsive">
                                <table class="table table-striped table-hover">
                                    <thead>
                                        <tr>
                                            <th>Patient Code</th>
                                            <th>Name</th>
                                            <th>Age</th>
                                            <th>Gender</th>
                                            <th>Ward</th>
                                            <th>Phone</th>
                                            <th>Guardian</th>
                                            <th>Registration Date</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="patient" items="${patients}">
                                            <tr>
                                                <td>
                                                    <strong class="text-primary">${patient.patientCode}</strong>
                                                </td>
                                                <td>
                                                    <a href="${pageContext.request.contextPath}/patients/${patient.patientId}" 
                                                       class="text-decoration-none">
                                                        ${patient.fullName}
                                                    </a>
                                                </td>
                                                <td>
                                                    <span class="badge badge-info">${patient.age} years</span>
                                                </td>
                                                <td>${patient.gender}</td>
                                                <td>Ward ${patient.wardNo}</td>
                                                <td>${patient.phone}</td>
                                                <td>
                                                    <c:if test="${not empty patient.guardianName}">
                                                        ${patient.guardianName}
                                                        <c:if test="${not empty patient.guardianRelation}">
                                                            <br><small class="text-muted">(${patient.guardianRelation})</small>
                                                        </c:if>
                                                    </c:if>
                                                </td>
                                                <td>
                                                    <fmt:formatDate value="${patient.registrationDate}" pattern="MMM dd, yyyy"/>
                                                </td>
                                                <td>
                                                    <div class="btn-group">
                                                        <a href="${pageContext.request.contextPath}/patients/${patient.patientId}" 
                                                           class="btn btn-sm btn-info" title="View Details">
                                                            View
                                                        </a>
                                                        <c:if test="${sessionScope.currentUser.role == 'ADMIN' || sessionScope.currentUser.role == 'MEDICAL_STAFF'}">
                                                            <a href="${pageContext.request.contextPath}/patients/${patient.patientId}/edit" 
                                                               class="btn btn-sm btn-warning" title="Edit Patient">
                                                                Edit
                                                            </a>
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
                
                <!-- Pagination -->
                <c:if test="${not isSearchResult && totalPages > 1}">
                    <div class="card-footer">
                        <nav aria-label="Patient pagination">
                            <ul class="pagination">
                                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                    <a class="page-link" href="?page=${currentPage - 1}">Previous</a>
                                </li>
                                
                                <c:forEach begin="1" end="${totalPages}" var="page">
                                    <li class="page-item ${currentPage == page ? 'active' : ''}">
                                        <a class="page-link" href="?page=${page}">${page}</a>
                                    </li>
                                </c:forEach>
                                
                                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                    <a class="page-link" href="?page=${currentPage + 1}">Next</a>
                                </li>
                            </ul>
                        </nav>
                        
                        <div class="text-center text-muted mt-2">
                            Showing page ${currentPage} of ${totalPages} 
                            (${totalRecords} total patients)
                        </div>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
    
    <%@ include file="../common/footer.jsp" %>
</body>
</html>
