<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>招工管理</title>
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
        function selectServicePeople(servicePeopleId,name){
            console.log("#btnSelect"+servicePeopleId+name);
            top.$.jBox.confirm('确认要选择添加该员工吗？','系统提示',function(v,h,f) {
                if (v == 'ok') {
                    parent.window.frames["mainFrame"].selectServicePeopleCallback(servicePeopleId,name);
                    top.$.jBox.close(true);
                }
            },{buttonsFocus:1, closed:function(){
                if (typeof closed == 'function') {
                    closed();
                }
            }});
        }
    </script>
</head>
<body>
<form:form id="searchForm" modelAttribute="employee" action="${ctx}/erp/employee/selectServicePeople" method="post" class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <ul class="ul-form">
        <li><label>姓名：</label>
            <form:input path="name" htmlEscape="false" maxlength="20" class="input-medium"/>
        </li>
        <li>
            <label>工种：</label>
            <form:select path="profession" class="input-large">
                <form:option value="" label="------请选择------"/>
                <form:options items="${erp:getCommonsTypeList(21)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
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
        <th>编号</th>
        <th>服务人员名称</th>
        <th>工种</th>
       <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${page.list}" var="employee">
        <tr>
            <td>
                    ${employee.code}
            </td>
            <td>
                ${employee.name}
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
               <shiro:hasPermission name="erp:employee:list"><a id="btnSelect" class="btn btn-primary" onclick="selectServicePeople('${employee.id}'
                       ,'${employee.name}')" href="javascript:; ">选择服务人员</a></shiro:hasPermission>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<div class="pagination">${page}</div>
</body>
</html>