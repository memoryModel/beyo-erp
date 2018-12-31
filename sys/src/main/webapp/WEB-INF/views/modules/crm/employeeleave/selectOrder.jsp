<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>选择订单</title>
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
        function selectOrder(orderid,orderCode,cunNames,cunPhone,skillName){
            console.log("#btnSelect"+orderid,orderCode,cunNames,cunPhone,skillName);
            top.$.jBox.confirm('确认要选择添加该订单吗？','系统提示',function(v,h,f) {
                if (v == 'ok') {
                    parent.window.frames["mainFrame"].selectOrderCallback(orderid,orderCode,cunNames,cunPhone,skillName);
                    top.$.jBox.close(true);
                }
            },{buttonsFocus:1, closed:function(){
                if (typeof closed == 'function') {
                    closed();
                }
            }});
            //close
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/crm/dispatch/findServiceOrderList/">单表列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="dispatch" action="${ctx}/crm/dispatch/findServiceOrderList" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>订单编号</th>
				<th>客户姓名</th>
				<th>客户手机号</th>
				<th>服务项目</th>
				<th>服务人员</th>
				<th>服务人员手机号码</th>
				<th>开始服务时间</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="dispatch">
			<tr>
				<td>
					${dispatch.order.orderCode}
				</td>
				<td>
					${dispatch.customer.name}
				</td>
				<td>
					${dispatch.customer.phone}
				</td>
				<td>
					${dispatch.skill.skillName}
				</td>
				<td>
					${dispatch.dispatchEmployee.employee.name}
				</td>
				<td>
					${dispatch.dispatchEmployee.employee.phone}
				</td>
				<td>
					<fmt:formatDate value="${dispatch.createTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
					<a id="btnSelect" class="btn btn-primary" onclick="selectOrder('${dispatch.id}','${dispatch.order.orderCode}','${dispatch.customer.name}','${dispatch.customer.phone}','${dispatch.skill.skillName}')" href="javascript:; ">添加订单</a>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>