<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>User Accounts | HMS Admin</title>
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap"
                rel="stylesheet">
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
            <link rel="stylesheet" href="<c:url value='/CSS/housekeeping.css'/>">
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
        </head>

        <body>

            <div class="layout-wrapper">
                <jsp:include page="../Shared/AdminSidebar.jsp" />

                <div class="main-content">
                    <jsp:include page="../Shared/Header.jsp" />

                    <div class="container-fluid py-4 px-4">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <div>
                                <h2 class="mb-1">User Accounts</h2>
                                <p class="text-muted mb-0">Manage all system users.</p>
                            </div>
                        </div>

                        <div class="card shadow-sm">
                            <div class="card-header bg-white py-3">
                                <div class="row align-items-center">
                                    <div class="col-md-6">
                                        <form class="d-flex">
                                            <input type="search" class="form-control form-control-sm me-2"
                                                placeholder="Search users...">
                                            <button class="btn btn-sm btn-outline-primary" type="submit">Search</button>
                                        </form>
                                    </div>
                                    <div class="col-md-6 text-end">
                                        <div class="btn-group btn-group-sm">
                                            <button type="button" class="btn btn-outline-secondary active">All</button>
                                            <button type="button" class="btn btn-outline-secondary">Admins</button>
                                            <button type="button" class="btn btn-outline-secondary">Staff</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="card-body p-0">
                                <div class="table-responsive">
                                    <table class="table table-hover align-middle mb-0">
                                        <thead class="bg-light">
                                            <tr>
                                                <th class="ps-4">ID</th>
                                                <th>Username</th>
                                                <th>Full Name</th>
                                                <th>Role</th>
                                                <th>Status</th>
                                                <th class="text-end pe-4">Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${users}" var="u">
                                                <tr>
                                                    <td class="ps-4 text-muted">#${u.userId}</td>
                                                    <td class="fw-bold text-primary">${u.username}</td>
                                                    <td>${u.fullName}</td>
                                                    <td>
                                                        <span class="badge bg-light text-dark border">
                                                            ${u.roleId == 1 ? 'Guest' : (u.roleId == 2 ? 'Receptionist'
                                                            : (u.roleId == 3 ? 'Housekeeping' : (u.roleId == 4 ? 'Owner'
                                                            : 'Admin')))}
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <span class="badge ${u.active ? 'bg-success' : 'bg-danger'}">
                                                            ${u.active ? 'Active' : 'Locked'}
                                                        </span>
                                                    </td>
                                                    <td class="text-end pe-4">
                                                        <a href="<c:url value='/admin/user-detail'><c:param name='id' value='${u.userId}'/></c:url>"
                                                            class="btn btn-sm btn-outline-primary">
                                                            Manage
                                                        </a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                    <jsp:include page="../Shared/Footer.jsp" />
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>