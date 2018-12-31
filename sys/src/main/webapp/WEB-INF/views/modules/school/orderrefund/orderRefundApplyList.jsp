<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>退费列表</title>
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
		<li class=""><a href="${ctx}/erp/orderRefund/list">退费申请列表</a></li>
		<li class="active"><a href="${ctx}/erp/orderRefund/applyList">退费申请查询列表</a></li>
		<li class=""><a href="${ctx}/erp/orderRefund/auditList">退费申请审核列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="orderRefund" action="${ctx}/erp/orderRefund/applyList" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>学生姓名：</label>
				<form:input path="order.student.name" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>申请时间：</label>
				<input name="createTimeStart" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   value="<fmt:formatDate value="${orderRefund.createTimeStart}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>-
				<input name="createTimeEnd" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   value="<fmt:formatDate value="${orderRefund.createTimeEnd}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
			</li>
			<li><label>状态：</label>
				<form:select path="applyQueryStatus" class="input-large " style="width:180px;">
					<form:option value="-1">请选择</form:option>
					<form:options items="${erp:refundStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
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
				<th>姓名</th>
				<th>学号</th>
				<th>手机号</th>
				<th>订单编号</th>
				<th>班级</th>
				<th>申请时间</th>
				<th>退款金额</th>
				<th>状态</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="orderRefund">
			<tr>
				<td>${orderRefund.order.student.name}</td>
				<td>${orderRefund.order.student.studentNumber}</td>
				<td>${orderRefund.order.student.phone}</td>
				<td>${orderRefund.order.orderCode}</td>
				<td>${orderRefund.order.student.schoolClassStudents.schoolClass.className}</td>
				<td><fmt:formatDate value="${orderRefund.createTime}" pattern="yyyy-MM-dd HH:mm"/></td>
				<td>${orderRefund.grossAmount}</td>
				<td>${erp:refundStatusName(orderRefund.status)}</td>
				<td>
					<shiro:hasPermission name="erp:orderRefund:toAudit">
					<a href="${ctx}/erp/orderRefund/toAudit?readOnly=y&id=${orderRefund.id}">查看</a>
					</shiro:hasPermission>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>