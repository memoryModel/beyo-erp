<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>服务人员考勤管理</title>
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
		<li class="active"><a href="${ctx}/crm/employeework/list">服务确认</a></li>
		<li><a href="${ctx}/crm/employeeLeave/list">服务人员请假</a></li>
		<li><a href="${ctx}/crm/employeeOvertime/list">服务人员加班</a>
	</ul>
	<form:form id="searchForm" modelAttribute="employeeWork" action="${ctx}/crm/employeework/list" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li>
				<label>人员姓名：</label>
				<form:input path="dispatchEmployee.employee.name" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li>
				<label>人员手机号：</label>
				<form:input path="dispatchEmployee.employee.phone" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li>
				<label>服务客户：</label>
				<form:input path="dispatchEmployee.dispatch.customer.name" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li>
				<label>客户手机号：</label>
				<form:input path="dispatchEmployee.dispatch.customer.phone" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li>
				<label>服务订单：</label>
				<form:input path="dispatchEmployee.dispatch.order.orderCode" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li>
				<label>考勤类型：</label>
				<form:select path="type" class="input-medium">
					<form:option value="" label="------请选择------"/>
					<form:options items="${erp:dispatchTypeList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li>
				<label>人员类别：</label>
                    <form:select path="dispatchEmployee.employee.entry.type" class="input-medium">
                        <form:option value="" label="------请选择------"/>
                        <form:options items="${erp:employeeTypeList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
                    </form:select>
            </li>
			<li>
				<label>客户状态：</label>
				<form:select path="status" class="input-medium">
					<form:option value="" label="------请选择------"/>
					<form:options items="${erp:dispatchServiceForShowList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li>
				<label>创建时间：</label>
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
				<th>服务人员姓名</th>
				<th>手机号码</th>
				<th>服务人员类别</th>
				<th>客户</th>
				<th>客户手机号</th>
				<th>服务订单</th>
				<th>服务项目</th>
				<th>实际开始时间/实际结束时间</th>
				<th>申请时间</th>
				<th>驳回原因</th>
				<th>考勤类型</th>
				<th>客户确认状态</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="employeework">
			<tr>
				<td>
					${employeework.dispatchEmployee.employee.name}
				</td>
				<td>
					${employeework.dispatchEmployee.employee.phone}
				</td>
				<td>
					${erp:employeeTypeName(employeework.dispatchEmployee.employee.entry.type)}
				</td>
				<td>
					<a name="customerView" customerId="${employeework.dispatchEmployee.dispatch.customer.id}" href="javascript:;" >${employeework.dispatchEmployee.dispatch.customer.name}</a>
				</td>
				<td>
					${employeework.dispatchEmployee.dispatch.customer.phone}
				</td>
				<td>
					<a name="viewOrder" orderId="${employeework.dispatchEmployee.dispatch.order.id}" href="javascript:;">${employeework.dispatchEmployee.dispatch.order.orderCode}</a>
				</td>
				<td>
					${employeework.dispatchEmployee.dispatch.orderItem.productSku.skill.skillName}
				</td>
				<td>
					<fmt:formatDate value="${employeework.startTime}" pattern="yyyy-MM-dd HH:mm:ss"/>|
					<fmt:formatDate value="${employeework.endTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<fmt:formatDate value="${employeework.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${employeework.reason}
				</td>
				<td>
					${erp:dispatchTypeName(employeework.type)}
				</td>
				<td>
					 ${erp:dispatchServiceStatusName(employeework.status)}
				</td>
				<%--<shiro:hasPermission name="crm:employeework:edit"><td>
    				<a href="${ctx}/crm/employeework/form?id=${employeework.id}">修改</a>
					<a href="${ctx}/crm/employeework/delete?id=${employeework.id}" onclick="return confirmx('确认要删除该服务人员考勤吗？', this.href)">删除</a>
				</td></shiro:hasPermission>--%>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
	<script type="text/javascript">
        $(document).ready(function() {
            $(document).find("a[name='viewOrder']").each(function () {
                var orderId = $(this).attr("orderId");
                $(this).click(function () {
                    top.$.jBox("iframe:/erp/productOrder/view?id="+orderId,{
                        title:"查看订单",
                        width:1024,
                        height:768,
                        buttons:{}
                    });
                });
            });
        });
        $(document).find("a[name='customerView']").each(function () {
            var customerId = $(this).attr("customerId");
            $(this).click(function () {
                top.$.jBox("iframe:/crm/customer/info?id="+customerId+"&&tagFlag="+1,{
                    title:"客户信息 ",
                    width:1300,
                    height:768,
                    buttons:{}
                });
            });
        });
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
        function page(n,s){
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#searchForm").submit();
            return false;
        }
	</script>
</body>
</html>