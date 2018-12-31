<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>招工沟通管理指派记录表管理</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(document).ready(function() {

        });
        function page(n,s){
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#searchForm").submit();
            return false;
        }
    </script>
</head>
<body>
<ul class="nav nav-tabs">
        <li ><a href="${ctx}/erp/employee/view?id=${employee.id}">基本信息</a></li>
        <li class="active"><a href="${ctx}/erp/employee/findEmployeeAppointRecordList?id=${employee.id}">指派记录</a></li>
        <li><a href="${ctx}/erp/employee/findCommunicateHistoryList?id=${employee.id}">沟通记录</a></li>
        <li><a href="${ctx}/erp/employee/findInterviewRecordList?id=${employee.id}">面试记录</a></li>
        <li><a href="#">定级记录</a></li>
        <li><a href="#">服务技能</a></li>
        <li><a href="#">签约记录</a></li>
</ul>
<sys:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <thead>
    <tr>
        <th>沟通人</th>
        <th>指派时间</th>
        <th>指派操作人</th>
        <th>沟通状态</th>
        <th>备注/取消原因</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${list}" var="employeeAppointRecord">
        <tr>
            <td>${employeeAppointRecord.communicationName}</td>
            <td><fmt:formatDate value="${employeeAppointRecord.appointTime}" pattern="yyyy-MM-dd"/>
            </td>
            <td>${employeeAppointRecord.appointName}</td>
            <td>${erp:appointStatusName(employeeAppointRecord.appointStatus)}</td>
            <td>${employeeAppointRecord.remark}
                <c:if test="${employeeAppointRecord.cancelReason == null}">

                </c:if>
                <c:if test="${employeeAppointRecord.cancelReason != null}">
                    /${employeeAppointRecord.cancelReason != null}
                </c:if>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<input id="btnCancel" class="btn btn-primary" type="button" value="返 回" onclick="history.go(-1)">
</body>
</html>