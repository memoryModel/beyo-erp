<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>待入职列表</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(document).ready(function() {
            $(document).find("a[name='entryForm']").each(function () {
                var entryId = $(this).attr("entryId");
                $(this).click(function () {
                    top.$.jBox("iframe:/crm/entry/info?id="+entryId,{
                        title:"员工信息",
                        width:976,
                        height:680,
                        buttons:{}
                    });
                });
            });
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
    <li class="active"><a href="${ctx}/crm/employeeResign/approveList">待入职列表</a></li>

</ul>
<form:form id="searchForm" modelAttribute="entry" action="${ctx}/crm/employeeResign/approveList" method="post" class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <ul class="ul-form">
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
        <li><label>手机号码：</label>
            <form:input path="employee.phone" htmlEscape="false" maxlength="20" class="input-medium"/>
        </li>
        <li><label>工种：</label>
            <form:select path="employee.profession" class="input-medium">
                <form:option value="" label="------请选择------"/>
                <form:options items="${erp:getCommonsTypeList(21)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
            </form:select>
        </li>
        <li><label>员工性质：</label>
            <form:select path="type" class="input-medium ">
                <form:option value="" label="------请选择------"/>
                <form:options items="${erp:employeeTypeList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
            </form:select>
        </li>
        <li><label>来源：</label>
            <sys:treeselect id="customerResource" name="customerResource.id" value="${entry.customerResource.id}"
                            labelName="customerResource.customerName" labelValue="${entry.customerResource.customerName}"
                            title="来源名称" url="/erp/customerResource/treeData" allowClear="true"/>
        </li>
        <li><label>创建时间：</label>
            <input name="startTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
                   value="<fmt:formatDate value="${employee.startTime}" pattern="yyyy-MM-dd"/>"
                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>至
            <input name="endTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
                   value="<fmt:formatDate value="${employee.endTime}" pattern="yyyy-MM-dd"/>"
                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
        </li>
        <%--<li><label>状态：</label>
            <form:select path="employeeStatus" class="input-medium">
                <form:option value="" label="------请选择------"/>
                <form:options items="${erp:employeeStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
            </form:select>
        </li>--%>
        <li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
        <li class="clearfix"></li>
    </ul>
</form:form>
<sys:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <thead>
    <tr>
        <th>员工姓名</th>
        <th>性别</th>
        <th>手机号码</th>
        <th>工种</th>
        <th>来源</th>
        <th>员工性质</th>
        <th>提交入职时间</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${page.list}" var="entry">
        <tr>
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
                <c:forEach items="${entry.employee.getProfessionList()}" var="occId" varStatus="length">
                    <c:if test="${length.index!=0}">
                        ,
                    </c:if>
                    ${erp:getCommonsTypeName(occId)}
                </c:forEach>
            </td>
            <td>
                    ${entry.employee.customerResource.customerName}
            </td>
            <td>
                    ${erp:employeeTypeName(entry.type)}
            </td>
            <td>
                    <fmt:formatDate value="${entry.approveTime}" pattern="yyyy-MM-dd HH:mm"/>
            </td>
            <td>
                <%--<c:if test="${employee.employeeStatus == 0}">&lt;%&ndash;待岗&ndash;%&gt;
                    <shiro:hasPermission name="crm:employeeResign:delete"><a href="${ctx}/crm/employeeResign/delete?id=${employee.id}" onclick="return confirmx('确认要解约该员工吗？', this.href)">解约</a></shiro:hasPermission>
                    <shiro:hasPermission name="crm:employeeResign:getEmployeeInfo"><a href="javascript:;" name="entryForm" entryId="${employee.entry.id}">查看</a></shiro:hasPermission>
                </c:if>--%>
                <c:if test="${entry.approveStatus == 5}">
                    <shiro:hasPermission name="crm:employeeResign:getEmployeeInfo"><a href="${ctx}/crm/employeeResign/approveForm?id=${entry.id}">审批</a></shiro:hasPermission>
                </c:if>
<%--
                <shiro:hasPermission name="crm:employeeResign:delete"><a href="${ctx}/crm/employeeResign/delete?id=${employee.id}" onclick="return confirmx('确认要解约该员工吗？', this.href)">解约</a></shiro:hasPermission>
--%>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<div class="pagination">${page}</div>
</body>
</html>