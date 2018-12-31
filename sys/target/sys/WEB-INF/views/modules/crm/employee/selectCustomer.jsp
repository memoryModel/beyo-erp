<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>客户管理</title>
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
        function selectCustomer(customerId,name){
            console.log("#btnSelect"+customerId,name);
            top.$.jBox.confirm('确认要选择该客户吗？','系统提示',function(v,h,f) {
                if (v == 'ok') {
                    parent.window.frames["mainFrame"].selectCustomerCallback(customerId,name);
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
<form:form id="searchForm" modelAttribute="customer" action="${ctx}/erp/employee/selectCustomer" method="post" class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <ul class="ul-form">
        <li><label>客户姓名：</label>
            <form:input path="name" htmlEscape="false" maxlength="20" class="input-medium"/>
        </li>

        <li><label>手机号码：</label>
            <form:input path="phone" htmlEscape="false" maxlength="20" class="input-medium"/>
        </li>
        <li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
        <li class="clearfix"></li>
    </ul>
</form:form>
<sys:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <thead>
    <tr>
        <th>客户编号</th>
        <th>客户姓名</th>
        <th>客户性别</th>
        <th>手机号码</th>
        <th>城市</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${page.list}" var="customer">
        <tr>
            <td>
                    ${customer.code}

            </td>
            <td>
                ${customer.name}

            </td>
            <td>
                ${erp:sexStatusName(customer.sex)}
            </td>
            <td>
                    ${customer.phone}
            </td>
            <td>
                    ${customer.area.name}
            </td>
            <td>
                <shiro:hasPermission name="erp:employee:list"><a id="btnSelect" class="btn btn-primary" onclick="selectCustomer('${customer.id}','${customer.name}')"
                                                                                href="javascript:; ">选择客户</a></shiro:hasPermission>
            </td>

        </tr>
    </c:forEach>
    </tbody>
</table>
<div class="pagination">${page}</div>
</body>
</html>