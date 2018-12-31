<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>委派记录表</title>
	<meta name="decorator" content="default"/>

</head>

<body>
<ul class="nav nav-tabs">

		<li><a href="${ctx}/crm/customer/info?id=${customer.id}&&tagFlag=${tagFlag}">基本信息</a></li>
		<li><a href="${ctx}/crm/customer/informationInfo?id=${customer.id}&&tagFlag=${tagFlag}">扩展信息</a></li>
		<li class="active"><a href="${ctx}/crm/customer/delegateInfo?id=${customer.id}&&tagFlag=${tagFlag}">委派记录</a></li>
		<li><a href="${ctx}/crm/customer/followInfo?id=${customer.id}&&tagFlag=${tagFlag}">跟进记录</a></li>
		<li><a href="${ctx}/crm/customer/saleInfo?id=${customer.id}&&tagFlag=${tagFlag}">销售线索</a></li>
		<li><a href="${ctx}/crm/customer/orderInfo?id=${customer.id}&&tagFlag=${tagFlag}">订单信息</a></li>
		<li><a href="${ctx}/crm/customer/contractInfo?id=${customer.id}&&tagFlag=${tagFlag}">合同信息</a></li>
		<li><a href="">服务记录</a></li>

</ul><br/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
			<tr>
				<th>销售顾问</th>
				<th>委派时间</th>
				<th>委派操作人</th>
				<th>撤回时间</th>
				<th>撤回类型</th>
				<th>撤回原因</th>
				<th>撤回操作人</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${customerDelegateRecordList}" var="delegateRecord">
			<tr>
				<td>
						${delegateRecord.saleAdviserName.name}
				</td>
				<td>
						<fmt:formatDate value="${delegateRecord.delegateTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
						${delegateRecord.delegtatePersonName.name}
				</td>
				<td>
						<fmt:formatDate value="${delegateRecord.cancelTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
						${erp:getCancelTypeName(delegateRecord.cancelType)}
				</td>
				<td>
						${delegateRecord.cancelReason}
				</td>
				<td>
						${delegateRecord.cancelPersonName.name}
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="form-actions">
		<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
	</div>
	<script type="text/javascript">

	</script>
</body>
</html>