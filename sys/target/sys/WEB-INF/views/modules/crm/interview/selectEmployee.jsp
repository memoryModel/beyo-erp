<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>单表管理</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(function () {
            $('a[name="btnSelect"]').each(function () {

                $(this).click(function () {
                    var id = $(this).attr('id');
                    var tdsHtml = $(this).parent().parent().children('td:lt(5)').clone(true);
                    var trHtml = $('<tr id='+id+'></tr>').append(tdsHtml).append('<td><input type="button" class="btn btn-primary" value="删除"></td>');
                    var selectFlag = $(this).text();
                    parent.window.frames["mainFrame"].selectEmployeeCallback(trHtml,selectFlag);
                    if(selectFlag == '选择'){
                        $(this).text('取消选择');
                    }
                    if(selectFlag == '取消选择'){
                        $(this).text('选择');
                    }
                    //top.$.jBox.close(true);
                })
            })



            var employeeIds = '${employeeIds}'
            var employeeIdArray = employeeIds.split(',');
            for(var i = 0;i<employeeIdArray.length;i++){

                $('table').find('tr[id='+employeeIdArray[i]+']').find('a').text('取消选择');
            }
        })
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
    <li class="active"><a href="${ctx}/crm/interview/selectEmployee"></a></li>
</ul>
<form:form id="searchForm" modelAttribute="employee" action="${ctx}/crm/interview/selectEmployee" method="post" class="breadcrumb
form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <ul class="ul-form">
        <li><label>员工姓名：</label>
            <form:input path="name" htmlEscape="false" maxlength="20" class="input-medium"/>
        </li>
        <li><label>手机号码：</label>
            <form:input path="phone" htmlEscape="false" maxlength="20" class="input-medium"/>
        </li>
        <li class="clearfix"></li>
        <li><label>性别：</label>
            <form:select path="sex" class="input-medium ">
                <form:option value="" label="------请选择------"/>
                <form:options items="${erp:sexStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
            </form:select>
        </li>

        <li><label>工种：</label>
            <form:select path="profession" class="input-medium">
                <form:option value="" label="------请选择------"/>
                <form:options items="${erp:getCommonsTypeList(21)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
            </form:select>
        </li>
        <li>
            <label>来源：</label>
            <sys:treeselect id="customerResource" name="customerResource.id" value="${employee.customerResource.id}"
                            labelName="customerResource.customerName" labelValue="${employee.customerResource.customerName}"
                            title="来源名称" url="/erp/customerResource/treeData" cssClass="required" allowClear="true" />
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
        <th>姓名</th>
        <th>性别</th>
        <th>手机号码</th>
        <th>工种</th>
        <th>来源</th>
        <th>签约状态</th>
       <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${page.list}" var="employee">
        <tr id="${employee.id}">
            <td>
                    ${employee.name}
            </td>
            <td>
                    ${erp:sexStatusName(employee.sex)}
            </td>
            <td>
                    ${employee.phone}
            </td>
            <td>
                <c:forEach items="${employee.getProfessionList()}" var="occId" varStatus="length">
                    <c:if test="${length.index!=0}">
                        ,
                    </c:if>
                    ${erp:getCommonsTypeName(occId)}
                </c:forEach>
            </td>
            </td>
            <td>
                    ${employee.customerResource.customerName}
            </td>
            <td>
                    ${erp:contractSignStatusName(employee.status)}
            </td>
            <td>
                <shiro:hasPermission name="crm:interview:selectEmployee"><a name="btnSelect" id="${employee.id}" class="btn btn-primary" href="javascript:;">选择</a></shiro:hasPermission>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<div class="pagination">${page}</div>
</body>
</html>