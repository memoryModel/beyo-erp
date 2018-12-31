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
		<li class="active"><a href="${ctx}/erp/orderRefund/list">退费申请列表</a></li>
		<%--<li class=""><a href="${ctx}/orderRefund/info">退费申请查询</a></li>--%>
		<li class=""><a href="${ctx}/erp/orderRefund/applyList">退费申请查询列表</a></li>
		<%--<shiro:hasPermission name="erp:orderRefund:refundAudit"><li class=""><a href="${ctx}/erp/orderRefund/refundAudit">退费申请审核</a></li></shiro:hasPermission>--%>
		<li class=""><a href="${ctx}/erp/orderRefund/auditList">退费申请审核列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="order" action="${ctx}/erp/orderRefund/list" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>学生姓名：</label>
				<form:input path="student.name" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>学生学号：</label>
				<form:input path="student.studentNumber" htmlEscape="false" maxlength="20" class="input-medium"/>
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
				<th>订单编号</th>
				<th>班级名称</th>
				<th>班主任</th>
				<th>学费</th>
				<th>付款类型</th>
				<th>学费优惠</th>
				<th>开班日期</th>
				<th>报名日期</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="order">
			<tr createUser="${order.createUser}" id="${order.id}">
				<td>
					${order.student.name}
				</td>
				<td>
						${order.student.studentNumber}
				</td>
				<td>
					${order.orderCode}
				</td>
				<td>
					${order.schoolClass.className}
				</td>
				<td>
					${order.teacher.name}
				</td>
				<td>
					${order.overallAmount}
				</td>
				<td>
					${erp:getCommonsTypeName(order.payType)}
				</td>
				<td>
					${order.favorableAmount}
				</td>
				<td>
					<fmt:formatDate value="${order.schoolClass.realBeginTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
					<fmt:formatDate value="${order.classStudents.applyTime}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
					<c:if test="${order.status == 5}">
						<shiro:hasPermission name="erp:orderRefund:refundBill"><a href="${ctx}/erp/orderRefund/refundBill?orderId=${order.id}">添加退费</a></shiro:hasPermission>
					</c:if>
					<c:if test="${order.status != 5}">
						${erp:orderStatusName(order.status)}
					</c:if>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
<script src="${ctxStatic}/officeNames/officeNames.js" type="text/javascript"></script>
</body>
</html>