<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Task List | HMS Housekeeping</title>
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap"
                rel="stylesheet">
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
            <link rel="stylesheet" href="<c:url value='/CSS/housekeeping.css'/>">
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
        </head>

        <body>

            <div class="layout-wrapper">
                <jsp:include page="../Shared/Sidebar.jsp" />

                <div class="main-content">
                    <jsp:include page="../Shared/Header.jsp" />

                    <div class="container-fluid py-4 px-4">
                        <div class="card">
                            <div class="card-header bg-white py-3">
                                <div class="row align-items-center w-100">
                                    <div class="col-md-6">
                                        <h4 class="mb-0"><i class="bi bi-list-task me-2 text-primary"></i>Task List</h4>
                                    </div>
                                    <div class="col-md-6">
                                        <form action="<c:url value='/housekeeping/tasks'/>" method="get"
                                            class="d-flex gap-2 justify-content-md-end">
                                            <input type="date" name="date" class="form-control form-control-sm"
                                                value="${filterDate}" style="max-width: 150px;">
                                            <select name="status" class="form-select form-select-sm"
                                                style="max-width: 150px;">
                                                <option value="">All Status</option>
                                                <option value="NEW" ${filterStatus=='NEW' ? 'selected' : '' }>New
                                                </option>
                                                <option value="IN_PROGRESS" ${filterStatus=='IN_PROGRESS' ? 'selected'
                                                    : '' }>In Progress</option>
                                                <option value="DONE" ${filterStatus=='DONE' ? 'selected' : '' }>Done
                                                </option>
                                            </select>
                                            <button type="submit" class="btn btn-sm btn-primary">Filter</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                            <div class="card-body p-0">
                                <div class="table-responsive">
                                    <table class="table table-hover align-middle mb-0">
                                        <thead class="bg-light">
                                            <tr>
                                                <th>#</th>
                                                <th>Room ID</th>
                                                <th>Date</th>
                                                <th>Type</th>
                                                <th>Status</th>
                                                <th>Note</th>
                                                <th class="text-end">Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:if test="${empty tasks}">
                                                <tr>
                                                    <td colspan="7" class="text-center py-5 text-muted">
                                                        <i class="bi bi-inbox fs-1 d-block mb-2"></i>
                                                        No tasks found matching your criteria.
                                                    </td>
                                                </tr>
                                            </c:if>
                                            <c:forEach items="${tasks}" var="t" varStatus="st">
                                                <tr>
                                                    <td>${st.index + 1}</td>
                                                    <td class="fw-bold text-primary">#${t.roomId}</td>
                                                    <td>${t.taskDate}</td>
                                                    <td>
                                                        <span class="badge bg-light text-dark border">
                                                            ${t.taskType}
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <span
                                                            class="badge ${t.status == 'NEW' ? 'bg-info' : (t.status == 'DONE' ? 'bg-success' : 'bg-warning')}">
                                                            ${t.status}
                                                        </span>
                                                    </td>
                                                    <td class="text-muted small text-truncate"
                                                        style="max-width: 200px;">${t.note}</td>
                                                    <td class="text-end">
                                                        <a href="<c:url value='/housekeeping/task-detail'><c:param name='id' value='${t.taskId}'/></c:url>"
                                                            class="btn btn-sm btn-outline-primary">
                                                            Details
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