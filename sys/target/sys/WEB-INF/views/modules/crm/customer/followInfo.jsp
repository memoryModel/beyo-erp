<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>跟进记录</title>
	<meta name="decorator" content="default"/>

</head>

<body>
<ul class="nav nav-tabs">

		<li><a href="${ctx}/crm/customer/info?id=${customer.id}&&tagFlag=${tagFlag}">基本信息</a></li>
		<li><a href="${ctx}/crm/customer/informationInfo?id=${customer.id}&&tagFlag=${tagFlag}">扩展信息</a></li>
		<li><a href="${ctx}/crm/customer/delegateInfo?id=${customer.id}&&tagFlag=${tagFlag}">委派记录</a></li>
		<li class="active"><a href="${ctx}/crm/customer/followInfo?id=${customer.id}&&tagFlag=${tagFlag}">跟进记录</a></li>
		<li><a href="${ctx}/crm/customer/saleInfo?id=${customer.id}&&tagFlag=${tagFlag}">销售线索</a></li>
		<li><a href="${ctx}/crm/customer/orderInfo?id=${customer.id}&&tagFlag=${tagFlag}">订单信息</a></li>
		<li><a href="${ctx}/crm/customer/contractInfo?id=${customer.id}&&tagFlag=${tagFlag}">合同信息</a></li>
		<li><a href="">服务记录</a></li>

</ul><br/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
			<tr>
				<th>跟进人</th>
				<th>跟进时间</th>
				<th>跟进方式</th>
				<th>客户意向</th>
				<th>跟进主题</th>
				<th>下次跟进安排</th>
				<th>下次跟进方式</th>
				<th>下次跟进时间</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${followRecordList}" var="followRecord">
			<tr>
				<td>
						${followRecord.user.name}
				</td>
				<td>
						<fmt:formatDate value="${followRecord.createTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
						${erp:getCommonsTypeName(followRecord.type)}
				</td>
				<td>
						${erp:customerIntentionStatusName(followRecord.intent)}
				</td>
				<td>
						${followRecord.theme}
				</td>
				<td>
						${followRecord.nextLayout==1?"有":"无"}
				</td>
				<td>
						${erp:getCommonsTypeName(followRecord.nextType)}
				</td>
				<td>
					<fmt:formatDate value="${followRecord.nextTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
					<a href="${ctx}/crm/followRecord/followInfo?id=${followRecord.id}&customerId=${customer.id}">查看</a>
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