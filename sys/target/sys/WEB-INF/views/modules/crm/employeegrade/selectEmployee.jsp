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
                    var tdsHtml = $(this).parent().parent().children('td:lt(5)').clone(true);
                    var trHtml = $('<tr id='+id+'></tr>').append(tdsHtml);
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
    <li class="active"><a href="${ctx}/crm/employeeGrade/selectEmployee"></a></li>
</ul>
<form:form id="searchForm" modelAttribute="entry" action="${ctx}/crm/employeeGrade/selectEmployee" method="post" class="breadcrumb
form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <ul class="ul-form">
        <li><label>员工姓名：</label>
            <form:input path="employee.name" htmlEscape="false" maxlength="20" class="input-medium"/>
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
        <li><label>薪资结构：</label>
            <form:select path="basePayStatus" class="input-medium">
                <form:option value="" label="------请选择------"/>
                <form:options items="${erp:basePayStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
            </form:select>
        </li>
        <li><label>状态：</label>
            <form:select path="entryStatus" class="input-medium">
                <form:option value="-1" label="------请选择------"/>
                <form:options items="${erp:entryStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
            </form:select>
        </li>
        <li><label>创建时间：</label>
            <input name="startTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
                   value="<fmt:formatDate value="${interview.startTime}" pattern="yyyy-MM-dd"/>"
                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>至
            <input name="endTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
                   value="<fmt:formatDate value="${interview.endTime}" pattern="yyyy-MM-dd"/>"
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
        <th>员工姓名</th>
        <th>性别</th>
        <th>手机号码</th>
        <th>工种</th>
        <th>来源</th>
        <th>提交状态</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${page.list}" var="entry">
        <tr id="${entry.employee.id}">
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
                    ${erp:entryStatusName(entry.entryStatus)}
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