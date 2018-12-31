<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>退费申请详情</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			if(n) $("#pageNo").val(n);
			if(s) $("#pageSize").val(s);
			$("#searchForm").submit();
	    	return false;
	    }
	</script>
</head>
<body>
<div>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/erp/orderRefund/list">退费申请查询</a></li>
		<li class="active"><a href="${ctx}/erp/orderRefund/info?id=${orderRefund.id}">退费详情</a></li>
	</ul></div><br/>

<form:form id="inputForm" modelAttribute="orderrefund" class="form-horizontal">

	<table width="100%">
		<tr align="center">
			<td>
				学号：${orderRefund.erpStudentEnroll.studentNumber}
			</td>
			<td>
				姓名:${orderRefund.erpStudentEnroll.name}
			</td>
			<td>
				性别:${fns:getDictLabel(orderRefund.erpStudentEnroll.sex, 'sex', '')}
			</td>
		</tr>
		<tr align="center">
			<td>
				手机号:${orderRefund.erpStudentEnroll.phone}
			</td>
		</tr>
	</table>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
		<tr>
			<th>班级名称</th>
			<th>课程</th>
			<th>班主任</th>
			<th>学费</th>
			<th>付款类型</th>
			<th>学费优惠</th>
			<th>开班日期</th>
			<th>报名日期</th>
		</tr>
		</thead>
		<tbody>
		<tr>
			<td>
				${orderRefund.schoolClass.className}
			</td>
			<td>
				${orderRefund.schoolClassLesson.lessonName}<br/>
			</td>
			<td>
				${orderRefund.employee.name}
			</td>
			<td>
				${orderRefund.schoolClass.tuitionAmount}
			</td>
			<td>
				${orderRefund.erpStudentEnroll.paymentType}
			</td>
			<td>
				${orderRefund.erpOrder.discountsAmount}
			</td>
			<td>
				<fmt:formatDate value="${orderRefund.erpStudentEnroll.practicalDate}" pattern="yyyy-MM-dd"/>
			</td>
			<td>
				<fmt:formatDate value="${orderRefund.erpStudentEnroll.applyTime}" pattern="yyyy-MM-dd"/>
			</td>
		</tr>
		</tbody>
	</table>
</form:form>
</body>
</html>