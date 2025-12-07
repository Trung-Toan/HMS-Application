<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <aside class="sidebar">
            <div class="sidebar-brand">
                <i class="bi bi-building-fill"></i>
                <span>HMS Hotel</span>
            </div>

            <ul class="sidebar-nav">
                <c:choose>
                    <%-- Manager Role (ID: 6) --%>
                        <c:when test="${sessionScope.currentUser.roleId == 6}">
                            <li class="nav-item">
                                <a href="<c:url value='/manager/dashboard'/>"
                                    class="nav-link ${pageContext.request.servletPath.endsWith('Dashboard.jsp') ? 'active' : ''}">
                                    <i class="bi bi-speedometer2"></i>
                                    <span>Dashboard</span>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="<c:url value='/manager/bookings'/>"
                                    class="nav-link ${pageContext.request.servletPath.endsWith('BookingList.jsp') ? 'active' : ''}">
                                    <i class="bi bi-calendar-check"></i>
                                    <span>Bookings</span>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="<c:url value='/manager/issues'/>"
                                    class="nav-link ${pageContext.request.servletPath.endsWith('IssueList.jsp') ? 'active' : ''}">
                                    <i class="bi bi-exclamation-triangle"></i>
                                    <span>Issues</span>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="<c:url value='/manager/replenishment-requests'/>"
                                    class="nav-link ${pageContext.request.servletPath.endsWith('ReplenishmentRequests.jsp') ? 'active' : ''}">
                                    <i class="bi bi-box-seam"></i>
                                    <span>Replenishment</span>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="<c:url value='/manager/inspections'/>"
                                    class="nav-link ${pageContext.request.servletPath.endsWith('InspectionList.jsp') ? 'active' : ''}">
                                    <i class="bi bi-clipboard-check"></i>
                                    <span>Inspections</span>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="<c:url value='/manager/rooms'/>"
                                    class="nav-link ${pageContext.request.servletPath.endsWith('RoomList.jsp') ? 'active' : ''}">
                                    <i class="bi bi-door-open"></i>
                                    <span>Rooms</span>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="<c:url value='/manager/staff'/>"
                                    class="nav-link ${pageContext.request.servletPath.endsWith('StaffList.jsp') ? 'active' : ''}">
                                    <i class="bi bi-people"></i>
                                    <span>Staff</span>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="<c:url value='/manager/create-inspection'/>"
                                    class="nav-link ${pageContext.request.servletPath.endsWith('CreateInspection.jsp') ? 'active' : ''}">
                                    <i class="bi bi-plus-circle"></i>
                                    <span>Create Inspection</span>
                                </a>
                            </li>
                        </c:when>

                        <%-- Housekeeping Role (ID: 3) --%>
                            <c:otherwise>
                                <li class="nav-item">
                                    <a href="<c:url value='/housekeeping/dashboard'/>"
                                        class="nav-link ${pageContext.request.servletPath.endsWith('Dashboard.jsp') ? 'active' : ''}">
                                        <i class="bi bi-grid-1x2-fill"></i>
                                        <span>Dashboard</span>
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a href="<c:url value='/housekeeping/tasks'><c:param name='type' value='CLEANING'/></c:url>"
                                        class="nav-link ${param.type == 'CLEANING' ? 'active' : ''}">
                                        <i class="bi bi-bucket"></i>
                                        <span>Cleaning Tasks</span>
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a href="<c:url value='/housekeeping/tasks'><c:param name='type' value='INSPECTION'/></c:url>"
                                        class="nav-link ${param.type == 'INSPECTION' ? 'active' : ''}">
                                        <i class="bi bi-clipboard-check"></i>
                                        <span>Inspection Tasks</span>
                                    </a>
                                </li>

                                <a href="<c:url value='/housekeeping/issue-report'/>"
                                    class="nav-link ${pageContext.request.servletPath.endsWith('IssueReport.jsp') ? 'active' : ''}">
                                    <i class="bi bi-exclamation-triangle"></i>
                                    <span>Report Issue</span>
                                </a>
                                </li>
                                <li class="nav-item">
                                    <a href="<c:url value='/housekeeping/inspection-history'/>"
                                        class="nav-link ${pageContext.request.servletPath.endsWith('InspectionHistory.jsp') ? 'active' : ''}">
                                        <i class="bi bi-clipboard-check"></i>
                                        <span>Inspections</span>
                                    </a>
                                </li>
                            </c:otherwise>
                </c:choose>
            </ul>

            <div class="sidebar-footer">
                <a href="<c:url value='/logout'/>" class="nav-link text-danger">
                    <i class="bi bi-box-arrow-right"></i>
                    <span>Logout</span>
                </a>
            </div>
        </aside>