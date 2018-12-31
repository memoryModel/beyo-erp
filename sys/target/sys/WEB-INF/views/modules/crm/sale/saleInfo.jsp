<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>销售线索管理</title>
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
		<c:if test="${tagFlag == 1}">
			<ul class="nav nav-tabs">
				<li class="active"><a href="${ctx}/crm/sale/saleInfo?id=${crmSale.id}&&tagFlag=${tagFlag}">线索信息</a></li>
				<li><a href="${ctx}/crm/saleFollow/saleFollowList?saleId=${crmSale.id}&&tagFlag=${tagFlag}">跟进记录</a></li>
				<li><a href="${ctx}/erp/productOrder/saleOrderList?status=1&customerId=${crmSale.customer.id}&&saleId=${crmSale.id}&&tagFlag=${tagFlag}">预定订单</a></li>
				<li><a href="${ctx}/crm/saleDelegateRecord/list?saleId=${crmSale.id}&&tagFlag=${tagFlag}">历史分配</a></li>
			</ul>
		</c:if>
		<c:if test="${tagFlag == 2}">
			<ul class="nav nav-tabs">
				<li class="active"><a href="${ctx}/crm/sale/saleInfo?id=${crmSale.id}&&tagFlag=${tagFlag}">线索信息</a></li>
				<li><a href="${ctx}/crm/saleFollow/view?saleId=${crmSale.id}&&saleDelegateRecordId=${crmSale.saleDelegateRecord.id}&&tagFlag=${tagFlag}">跟进记录</a></li>
				<li><a href="${ctx}/crm/saleFollow/findAllListBySaleId?saleId=${crmSale.id}">跟进计划</a></li>
				<li><a href="${ctx}/erp/productOrder/saleOrderList?status=1&customerId=${crmSale.customer.id}">预定订单</a></li>
			</ul>
		</c:if>
		<c:if test="${tagFlag == 3}">
			<ul class="nav nav-tabs">
				<li class="active"><a href="${ctx}/crm/sale/saleInfo?id=${crmSale.id}&&tagFlag=${tagFlag}">销售线索信息</a></li>
			</ul>
		</c:if>

	<form:form id="inputForm" modelAttribute="crmSale" action="${ctx}/crm/sale/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<c:if test="${crmSale.delegateStatus == 2}">
			<div class="alert alert-info">撤回原因</div>
			<table class="table table-striped table-bordered table-condensed">
				<thead>
				<tr>
					<th>撤回类型</th>
					<th>撤回原因</th>
					<th>操作人</th>
					<th>撤回时间</th>
				</tr>
				</thead>
				<tbody>
				<c:forEach items="${saleDelegateRecordList}" var="saleDelegateRecord">
					<tr>
						<td>${erp:getCancelTypeName(saleDelegateRecord.cancelType)}</td>
						<td>${saleDelegateRecord.cancelReason}</td>
						<td>${saleDelegateRecord.cancelPersonName}</td>
						<td>
							<fmt:formatDate value="${saleDelegateRecord.cancelTime}" pattern="yyyy-MM-dd HH:mm"/>
						</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</c:if>
		<table>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">客户姓名：</label>
						<div class="controls">
							<form:input path="customer.name" readonly="true" class="input-large " value="${crmSale.customer.name}"/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">手机号码：</label>
						<div class="controls">
							<form:input path="customer.phone" readonly="true" class="input-large " value="${crmSale.customer.phone}"/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">业务意向：</label>
						<div class="controls">
							<form:select path="serviceTypeId"  class="input-large " disabled="true">
								<form:options items="${erp:getCommonsTypeList(59)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
							</form:select>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">重要程度：</label>
						<div class="controls">
							<form:select path="importantDegree"  class=" input-large " disabled="true">
								<form:options items="${erp:getCommonsTypeList(54)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
							</form:select>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">意向门店：</label>
						<div class="controls">

						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">预计消费时间：</label>
						<div class="controls">
							<input name="planConsumptionTime" type="text" readonly="readonly"  maxlength="20" class="required input-medium Wdate "
								   value="<fmt:formatDate value="${crmSale.planConsumptionTime}" pattern="yyyy-MM-dd HH:mm"/>"
								   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});"/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">获取人：</label>
						<div class="controls">
							<form:input path="clueAccessName.name" readonly="true"  class="input-large " value="${crmSale.clueAccessName.name}" />
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<div class="controls">
								<input type="checkbox" name="vipFlag" id="vipFlag" value="0" <c:if test="${crmSale.vipFlag == 0}"> checked="checked"</c:if>>VIP客户
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">线索来源：</label>
						<div class="controls">
							<input type="text" value="${crmSale.customerResource.customerName}" id="customerName" readonly="readonly" class="input-large ">
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<div class="control-group">
						<label class="control-label">线索描述：</label>
						<div class="controls">
							<form:textarea path="clueDescription" name="clueDescription" rows="3" style="width:709px;" maxlength="1024" value="${crmSale.clueDescription}" readonly="true"></form:textarea>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<div class="control-group">
						<label class="control-label">备注信息：</label>
						<div class="controls">
							<form:textarea path="remark" name="remark" rows="3" style="width:709px;" maxlength="1024" value="${crmSale.remark}" readonly="true"></form:textarea>
						</div>
					</div>
				</td>
			</tr>
		</table>
		<div>
			<input type="button" class="btn btn-primary" onclick="history.go(-1)" value="返回">
		</div>
	</form:form>
</body>
</html>