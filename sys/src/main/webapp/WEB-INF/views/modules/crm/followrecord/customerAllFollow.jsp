<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>客户跟进记录管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<br/>
		<font size="5">&nbsp;&nbsp;&nbsp;&nbsp;我的跟进记录</font>
	</ul>
	<form:form id="inputForm" modelAttribute="followRecord" action="${ctx}/crm/followRecord/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<table>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">客户编号：</label>
						<div class="controls">
								${customer.code}
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">客户姓名：</label>
						<div class="controls">
								${customer.name}
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">手机号码：</label>
						<div class="controls">
								${customer.phone}
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">客户性别：</label>
						<div class="controls">
								${erp:sexStatusName(customer.sex)}
						</div>
					</div>
				</td>
			</tr>
		</table>

		<table id="contentTable" class="table table-striped table-bordered table-condensed">
			<thead>
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
					<td>${followRecord.user.name}</td>
					<td><fmt:formatDate value="${followRecord.createTime}" pattern="yyyy-MM-dd HH:mm"/></td>
					<td>${erp:getCommonsTypeName(followRecord.type)}</td>
					<td>${erp:customerIntentionStatusName(followRecord.intent)}</td>
					<td>${followRecord.theme}</td>
					<td>${followRecord.nextLayout==1?"有":"无"}</td>
					<td>${erp:getCommonsTypeName(followRecord.nextType)}</td>
					<td><fmt:formatDate value="${followRecord.nextTime}" pattern="yyyy-MM-dd HH:mm"/></td>
					<td>
						<a href="${ctx}/crm/followRecord/followInfo?id=${followRecord.id}&customerId=${customer.id}">查看</a>
						<a href="${ctx}/crm/followRecord/form?id=${followRecord.id}&customerId=${customer.id}&followFlag=1">修改</a>
					</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		<div class="form-actions">
			<input id="btnCancel" class="btn" type="button" style="width:130px;height:40px;" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>