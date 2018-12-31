<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>员工请假管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
            if(${tagflag==1}){
                $("#li2").attr("class","active");
            }
            if(${tagflag==2}){
                $("#li3").attr("class","active");
            }
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
	<li><a href="${ctx}/crm/employeework/list">服务确认</a></li>
	<shiro:hasPermission name="crm:employeeLeave:list"><li id="li2"><a href="${ctx}/crm/employeeLeave/list">服务人员请假</a></li></shiro:hasPermission>
	<shiro:hasPermission name="crm:employeeLeave:list"><li id="li3"><a href="${ctx}/crm/employeeOvertime/list">服务人员加班</a></li></shiro:hasPermission>
</ul>

	<form:form id="searchForm" modelAttribute="employeeLeave" action="${ctx}/crm/employeeLeave/list" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>人员姓名：</label>
				<form:input path="employee.name" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>人员手机号：</label>
				<form:input path="employee.phone" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>服务客户：</label>
				<form:input path="customer.name" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>服务订单：</label>
				<form:input path="order.orderCode" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>人员类别：</label>
				<form:select path="entry.type" class="input-medium">
					<form:option value="" label="------请选择------"/>
					<form:options items="${erp:employeeTypeList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>客户状态：</label>
				<form:select path="status" class="input-medium">
					<form:option value="" label="------请选择------"/>
					<form:options items="${erp:employeeLeaveStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>创建时间：</label>
				<input name="createTimeStart" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   value="<fmt:formatDate value="${employeeLeave.createTimeStart}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>-
				<input name="createTimeEnd" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   value="<fmt:formatDate value="${employeeLeave.createTimeEnd}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
<ul class="nav nav-tabs">
	<shiro:hasPermission name="crm:employeeLeave:form"><li>
			<a class="btn btn-primary" href="${ctx}/crm/employeeLeave/form">请假添加</a>
	</li></shiro:hasPermission>
</ul>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>服务人员</th>
				<th>服务人员手机号</th>
				<th>服务人员类别</th>
				<th>服务客户</th>
				<th>服务订单</th>
				<th>服务项目</th>
				<th>请假时长 /小时</th>
				<th>请假开始时间</th>
				<th>请假结束时间</th>
				<th>请假类型</th>
				<th>请假事由</th>
				<th>申请时间</th>
				<th>状态</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="employeeLeave">
			<tr>
				<td>
					${employeeLeave.employee.name}
				</td>
				<td>
					${employeeLeave.employee.phone}
				</td>
				<td>
					${erp:employeeTypeName(employeeLeave.employee.entry.type)}
				</td>
				<td>
					<a name="customerView" customerId="${employeeLeave.customer.id}" href="javascript:;" >
							${employeeLeave.customer.name}</a>
				</td>
				<td>
					<a name="viewOrder" orderId="${employeeLeave.order.id}" href="javascript:;">
							${employeeLeave.order.orderCode}</a>
				</td>
				<td>
					${employeeLeave.skill.skillName}
				</td>
				<td>
					${employeeLeave.hours}
				</td>
				<td>
					<fmt:formatDate value="${employeeLeave.startTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
					<fmt:formatDate value="${employeeLeave.endTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
					${erp:getCommonsTypeName(employeeLeave.type)}
				</td>
				<td>
					${employeeLeave.reason}
				</td>
				<td>
					<fmt:formatDate value="${employeeLeave.createTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
					${erp:employeeLeaveStatusName(employeeLeave.status)}</td>
				<td>

					<c:if test="${employeeLeave.status == 1}"><%--待客户确认--%>
						<shiro:hasPermission name="crm:employeeLeave:getEmployeeLeaveInfo"><a href="${ctx}/crm/employeeLeave/getEmployeeLeaveInfo?id=${employeeLeave.id}">查看</a></shiro:hasPermission>
					</c:if>
					<c:if test="${employeeLeave.status == 2}"><%--客户已驳回--%>
						<shiro:hasPermission name="crm:employeeLeave:getEmployeeLeaveInfo"><a href="${ctx}/crm/employeeLeave/getEmployeeLeaveInfo?id=${employeeLeave.id}">查看</a></shiro:hasPermission>
					</c:if>
					<c:if test="${employeeLeave.status == 3}"><%--待管理老师确认--%>
						<shiro:hasPermission name="crm:employeeLeave:getEmployeeLeaveInfo"><a href="${ctx}/crm/employeeLeave/getEmployeeLeaveAgree?id=${employeeLeave.id}">审批</a></shiro:hasPermission>
					</c:if>
					<c:if test="${employeeLeave.status == 4}"><%--已生效--%>
						<shiro:hasPermission name="crm:employeeLeave:getEmployeeLeaveInfo"><a href="${ctx}/crm/employeeLeave/getEmployeeLeaveInfo?id=${employeeLeave.id}">查看</a></shiro:hasPermission>
					</c:if>
					<c:if test="${employeeLeave.status == 5}"><%--已作废--%>
						<shiro:hasPermission name="crm:employeeLeave:getEmployeeLeaveInfo"><a href="${ctx}/crm/employeeLeave/getEmployeeLeaveInfo?id=${employeeLeave.id}">查看</a></shiro:hasPermission>
					</c:if>
				<%--	<shiro:hasPermission name="crm:employeeLeave:getEmployeeLeaveInfo"><a href="${ctx}/crm/employeeLeave/getEmployeeLeaveInfo?id=${employeeLeave.id}">查看</a></shiro:hasPermission>
					<shiro:hasPermission name="crm:employeeLeave:agree"><a href="${ctx}/crm/employeeLeave/agree?id=${employeeLeave.id}" onclick="return confirmx('确认要批准该员工的请假吗？', this.href)">批准</a></shiro:hasPermission>
					<shiro:hasPermission name="crm:employeeLeave:refuse"><a href="${ctx}/crm/employeeLeave/refuse?id=${employeeLeave.id}" onclick="return confirmx('确认要驳回该员工的请假吗？', this.href)">驳回</a></shiro:hasPermission>--%>
				</td>
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