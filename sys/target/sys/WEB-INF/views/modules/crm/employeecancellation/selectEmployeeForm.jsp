<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>单表管理</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(function () {
            $('a[name="btnSelect"]').click(function () {
                var id = $(this).attr('id');
                var tdsHtml = $(this).parent().parent().children('td:lt(4)').clone(true);
                var customerResourceName = $(this).parent().parent().find('input[type="hidden"][name="hdCustomerResourceName"]').val();
                var birthTime = $(this).parent().parent().find('input[type="hidden"][name="hdBirthTime"]').val();
                var trHtml = $('<tr id='+id+'></tr>').append(tdsHtml).append('<td>'+customerResourceName+'</td><td>'+birthTime+'</td>');
                var selectFlag = $(this).text();
                parent.window.frames["mainFrame"].selectEmployeeCallback(trHtml,selectFlag);
                if(selectFlag == '选择'){
                    var aHTML = $('a[name="btnSelect"]');
                    for(var i=0;i<aHTML.length;i++){
                        $(aHTML[i]).text("选择");
                    }
                    $(this).text('取消选择');
                }
                if(selectFlag == '取消选择'){
                    $(this).text('选择');
                }
            });

            var employeeId = '${employeeId}'
            $('table').find('tr[id='+employeeId+']').find('a').text('取消选择');
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
    <li class="active"><a href="${ctx}/crm/employeeCancellation/selectEmployee"></a></li>
</ul>
<form:form id="searchForm" modelAttribute="entry" action="${ctx}/crm/employeeCancellation/selectEmployeeInService" method="post" class="breadcrumb
form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <ul class="ul-form">
        <li><label>员工姓名：</label>
            <form:input path="employee.name" htmlEscape="false" maxlength="20" class="input-medium"/>
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
            <form:select path="type" class="input-medium">
                <form:option value="" label="------请选择------"/>
                <form:options items="${erp:employeeTypeList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
            </form:select>
        </li>
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
        <th>员工性质</th>
        <th>签约截止日期</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${page.list}" var="entry">
        <tr id="${entry.employee.id}">
            <input type="hidden" name="hdCustomerResourceName" value="${entry.employee.customerResource.customerName}">
            <input type="hidden" name="hdBirthTime" value='<fmt:formatDate value="${entry.employee.birthTime}" pattern="yyyy-MM-dd"/>'>

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
                    ${erp:employeeTypeName(entry.type)}
            </td>
            <td>
                <fmt:formatDate value="${entry.deadlineTime}" pattern="yyyy-MM-dd"/>
            </td>
            <td>
                <shiro:hasPermission name="crm:interview:selectEmployee"><a name="btnSelect" id="${entry.employee.id}" class="btn btn-primary" href="javascript:;">选择</a></shiro:hasPermission>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<div class="pagination">${page}</div>
</body>
</html>