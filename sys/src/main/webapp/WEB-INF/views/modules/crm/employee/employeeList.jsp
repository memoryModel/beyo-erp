<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>招工管理</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(document).ready(function() {
            $("#btnImport").click(function(){
                $.jBox($("#importBox").html(), {title:"导入数据", buttons:{"关闭":true},
                    bottomText:"导入文件不能超过5M，仅允许导入“xls”或“xlsx”格式文件！"});
            });
        });
        function page(n,s){
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#searchForm").submit();
            return false;
        }
        /*function checkedSelectIds() {
            var checkedEmployeeIds = '';
            var elements = $("[name='checkbox']:checked");


        }*/
    </script>
</head>
<body>
<div id="importBox" class="hide">
    <form id="importForm" action="${ctx}/erp/employee/import" method="post" enctype="multipart/form-data"
          class="form-search" style="padding-left:20px;text-align:center;" onsubmit="loading('正在导入，请稍等...');"><br/>
        <input id="uploadFile" name="file" type="file" style="width:330px"/><br/><br/>　　
        <input id="btnImportSubmit" class="btn btn-primary" type="submit" value="   导    入   "/>
    </form>
</div>
<ul class="nav nav-tabs">
    <li class="active"><a href="${ctx}/erp/employee/list">招工管理列表</a></li>
<%--
    <shiro:hasPermission name="erp:employee:form"><li><a href="${ctx}/erp/employee/form">招工管理添加</a></li></shiro:hasPermission>
--%>
</ul>


<form:form id="searchForm" modelAttribute="employee" action="${ctx}/erp/employee/list" method="post" class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <ul class="ul-form">
        <li><label>员工姓名：</label>
            <form:input path="name" htmlEscape="false" maxlength="20" class="input-medium"/>
        </li>
        <li>
            <label>来源：</label>
            <sys:treeselect id="customerResource" name="customerResource.id" value="${employee.customerResource.id}"
                            labelName="customerResource.customerName" labelValue="${employee.customerResource.customerName}"
                            title="来源名称" url="/erp/customerResource/treeData" allowClear="true"/>
        </li>
        <li>
            <label>性别：</label>
            <form:select path="sex"  class="input-large">
                <form:option value="" label="------请选择------"/>
                <form:options items="${erp:sexStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
            </form:select>
        </li>
        <li>
            <label>工种：</label>
            <form:select path="profession"  class="input-large">
                <form:option value="" label="------请选择------"/>
                <form:options items="${erp:getCommonsTypeList(21)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
            </form:select>
        </li>

        <li><label>签约状态：</label>
            <form:select path="signStatus"  class="input-large">
                <form:option value="-1" label="------请选择------"/>
                <form:options items="${erp:contractSignStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
            </form:select>
        </li>
        <li><label>指派状态：</label>
            <form:select path="assignStatus" class="input-large">
                <form:option value="-1" label="------请选择------"/>
                <form:options items="${erp:getAssignStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
            </form:select>
        </li>
        <li><label>添加时间：</label>
            <input name="startTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
                   value="<fmt:formatDate value="${employee.startTime}" pattern="yyyy-MM-dd"/>"
                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>至
            <input name="endTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
                   value="<fmt:formatDate value="${employee.endTime}" pattern="yyyy-MM-dd"/>"
                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
        </li>

        <li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
            <input id="btnExport" class="btn btn-primary" type="button" value="导出"/>
            <input id="btnImport" class="btn btn-primary" type="button" value="导入"/>
        </li>
        <li class="clearfix"></li>
    </ul>
</form:form>
<%--部门名称--%>

<sys:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <thead>
    <tr>
        <%--<th><input type="checkbox" name="checkboxs"></th>--%>
        <th>姓名</th>
        <th>性别</th>
        <th>手机号码</th>
        <th>工种</th>
        <th>来源</th>
        <th>指派状态</th>
        <th>签约状态</th>
        <%--<th>职位状态</th>--%>
        <th>信息获取人</th>
        <th>信息添加人</th>
        <th>添加时间</th>
       <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${page.list}" var="erpEmployee">
        <tr>
            <%--<td><input type="checkbox" name="checkbox" value="${erpEmployee.id}" onclick="checkedSelectIds()"></td>--%>
            <td>
                ${erpEmployee.name}
            </td>
            <td>
                ${erp:sexStatusName(erpEmployee.sex)}
            </td>
            <td>
                ${erpEmployee.phone}
            </td>
            <td>
                <c:forEach items="${erpEmployee.getProfessionList()}" var="occId" varStatus="length">
                    <c:if test="${length.index!=0}">
                        ,
                    </c:if>
                    ${erp:getCommonsTypeName(occId)}
                </c:forEach>
            </td>
            <td>
                ${erpEmployee.customerResource.customerName}
            </td>
            <td>
                    ${erp:getAssginStatusName(erpEmployee.assignStatus)}
            </td>
            <td>
                 ${erp:contractSignStatusName(erpEmployee.signStatus)}

            </td>
            <%--<td>
                 ${erp:employeeStatusName(erpEmployee.employeeStatus)}
            </td>--%>
            <td>
                ${erpEmployee.creater.name}
            </td>
            <td>
                    ${erpEmployee.infoCollectId.name}
            </td>
            <td>
                <fmt:formatDate value="${erpEmployee.createTime}" pattern="yyyy-MM-dd"/>
            </td>
           <td>
               <c:if test="${erpEmployee.assignStatus == 0}">
                   <shiro:hasPermission name="erp:employee:form"><a href="${ctx}/erp/employee/form?id=${erpEmployee.id}">修改</a></shiro:hasPermission>
                   <shiro:hasPermission name="erp:employee:form"><a href="${ctx}/erp/employee/view?id=${erpEmployee.id}">查看</a></shiro:hasPermission>
               </c:if>
               <c:if test="${erpEmployee.assignStatus == 1}">
                   <shiro:hasPermission name="erp:employee:form"><a href="${ctx}/erp/employee/view?id=${erpEmployee.id}">查看</a></shiro:hasPermission>
               </c:if>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<div class="pagination">${page}</div>
</body>
</html>