<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>招工沟通历史记录表管理</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(document).ready(function() {

        });

    </script>
</head>
<body>
<ul class="nav nav-tabs">
    <li><a href="${ctx}/erp/employee/view?id=${employee.id}">基本信息</a></li>
    <li><a href="${ctx}/erp/employee/findEmployeeAppointRecordList?id=${employee.id}">指派记录</a></li>
    <li class="active"><a href="${ctx}/erp/employee/findCommunicateHistoryList?id=${employee.id}">沟通记录</a></li>
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
        <th>沟通时间</th>
        <th>沟通方式</th>
        <th>签约意向</th>
        <th>联系主题</th>
        <th>下次沟通安排</th>
        <th>下次沟通方式</th>
        <th>下次沟通时间</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${list}" var="employeeCommunicationHistory">
        <tr>
            <td>
                    ${employeeCommunicationHistory.communicationName}
            </td>
            <td>
                <fmt:formatDate value="${employeeCommunicationHistory.communicationTime}" pattern="yyyy-MM-dd"/>
            </td>
            <td>
                    ${erp:communicationModeStatusName(employeeCommunicationHistory.communicationMode)}
            </td>
            <td>
                    ${erp:signingIntentionStatusName(employeeCommunicationHistory.signingIntention)}
            </td>
            <td>
                    ${employeeCommunicationHistory.theme}
            </td>
            <td>
                    ${erp:nextCommunicationArrangementStatusName(employeeCommunicationHistory.nextCommunicationArrangement)}
            </td>
            <td>
                <c:if test="${employeeCommunicationHistory.nextCommunicationMode == null || employeeCommunicationHistory.nextCommunicationMode == ''}">
                    无
                </c:if>
                <c:if test="${employeeCommunicationHistory.nextCommunicationMode != null}">
                    ${erp:communicationModeStatusName(employeeCommunicationHistory.nextCommunicationMode)}
                </c:if>
            </td>
            <td>
                <c:if test="${employeeCommunicationHistory.nextCommunicationTime == null}">
                    无
                </c:if>
                <c:if test="${employeeCommunicationHistory.nextCommunicationTime != null}">
                    <fmt:formatDate value="${employeeCommunicationHistory.nextCommunicationTime}" pattern="yyyy-MM-dd HH:mm"/>
                </c:if>
            </td>
                <%--<shiro:hasPermission name="erp:employee:list">--%>
                    <td>
                        <a name="view" href="javascript:;" id="${employeeCommunicationHistory.id}">查看</a>
                    </td>
                <%--</shiro:hasPermission>--%>
        </tr>
    </c:forEach>
    </tbody>
</table>
<input id="btnCancel" class="btn btn-primary" type="button" value="返 回" onclick="history.go(-1)">
</body>
</html>