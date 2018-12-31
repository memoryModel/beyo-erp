<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>员工列表<%--母婴-员工管理 员工列表--%></title>
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
    <li class="active"><a href="${ctx}/crm/employeeEntry/employeeList">员工列表</a></li>
</ul>
<form:form id="searchForm" modelAttribute="entry" action="${ctx}/crm/employeeEntry/employeeList" method="post" class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <ul class="ul-form">
        <li><label>员工编号：</label>
            <form:input path="employee.code" htmlEscape="false" maxlength="20" class="input-medium"/>
        </li>
        <li><label>员工姓名：</label>
            <form:input path="employee.name" htmlEscape="false" maxlength="20" class="input-medium"/>
        </li>
        <li>
            <label>性别：</label>
            <form:select path="employee.sex"  class="input-large">
                <form:option value="" label="------请选择------"/>
                <form:options items="${erp:sexStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
            </form:select>
        </li>
        <li><label>联系方式：</label>
            <form:input path="employee.phone" htmlEscape="false" maxlength="20" class="input-medium"/>
        </li>
        <li><label>工种：</label>
            <form:select path="employee.profession" class="input-medium">
                <form:option value="" label="------请选择------"/>
                <form:options items="${erp:getCommonsTypeList(21)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
            </form:select>
        </li>
        <li>
            <label>薪资结构：</label>
            <form:select path="basePayStatus"  class="input-large">
                <form:option value="" label="------请选择------"/>
                <form:options items="${erp:basePayStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
            </form:select>
        </li>
        <li>
            <label>员工性质：</label>
            <form:select path="type"  class="input-large">
                <form:option value="" label="------请选择------"/>
                <form:options items="${erp:employeeTypeList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
            </form:select>
        </li>
        <li><label>创建时间：</label>
            <input name="startTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
                   value="<fmt:formatDate value="${employee.startTime}" pattern="yyyy-MM-dd"/>"
                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>至
            <input name="endTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
                   value="<fmt:formatDate value="${employee.endTime}" pattern="yyyy-MM-dd"/>"
                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
        </li>

        <li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
        <li class="clearfix"></li>
    </ul>
</form:form>
<sys:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <thead>
    <tr>
        <th>员工编号</th>
        <th>员工姓名</th>
        <th>性别</th>
        <th>联系电话</th>
        <th>员工性质</th>
        <th>工种</th>
        <th>签约截止时间</th>
        <%--<th>级别</th>--%>
        <th>服务状态</th>
        <th>员工状态</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${page.list}" var="entry">
        <tr>
            <td>
                ${entry.employee.code}
            </td>
            <td>
                ${entry.employee.name}
            </td>
            <td>
                ${erp:sexStatusName(entry.employee.sex)}
            </td>
            <td>
                ${entry.employee.phone}
            </td>
            <td>
                ${erp:employeeTypeName(entry.type)}
            </td>
            <td>
                <c:forEach items="${entry.employee.getProfessionList()}" var="occId" varStatus="length">
                    <c:if test="${length.index!=0}">
                        ,
                    </c:if>
                    ${erp:getCommonsTypeName(occId)}
                </c:forEach>
            </td>
            <%--<td>
                ${erpEmployee.serviceLevel.name}
            </td>--%>
            <td>
                <fmt:formatDate value="${entry.deadlineTime}" pattern="yyyy-MM-dd HH:mm"/>
            </td>

           <td>
                   ${erp:employeeListStatusName(entry.servingStatus)}
            </td>
            <td>
                    ${erp:employeeStatusName(entry.approveStatus)}
            </td>
            <td>
                <c:if test="${entry.approveStatus == 6}"><%--在职--%>
                    <shiro:hasPermission name="erp:employee:list"><a href="${ctx}/erp/employee/view?id=${entry.employee.id}">查看</a></shiro:hasPermission>
                    <shiro:hasPermission name="erp:employee:form"><a href="${ctx}/erp/employee/employeeForm?id=${entry.employee.id}">修改</a></shiro:hasPermission>
                </c:if>
                <c:if test="${entry.approveStatus == 2}"><%--已离职--%>
                    <shiro:hasPermission name="erp:employee:list"><a href="${ctx}/erp/employee/view?id=${entry.id}">查看</a></shiro:hasPermission>
                </c:if>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<div class="pagination">${page}</div>
</body>
</html>