<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>派工详情信息</title>
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
		<li><a href="${ctx}/crm/dispatch/list">预约列表</a></li>
		<li class="active"><a href="${ctx}/crm/dispatch/info?id=${dispatch.id}">预约详情</a></li>
	</ul><br/>
	<%--<form:form id="inputForm" modelAttribute="dispatch" class="form-horizontal">--%>
	<form:form id="inputForm" modelAttribute="dispatch" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="alert alert-info">客户信息</div>
		<div class="control-group">
			<table>
				<tr>
					<td>
						<div class="control-group">
							<label class="control-label">客户姓名：</label>
							<div class="controls">
								<form:input path="customer.name" disabled="true" htmlEscape="false" maxlength="20" class="input-medium"/>
							</div>
						</div>
					</td>
					<td>
						<div class="control-group">
							<label class="control-label">手机号：</label>
							<div class="controls">
								<form:input path="customer.phone" disabled="true" htmlEscape="false" maxlength="20" class="input-medium  digits"/>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="control-group">
							<label class="control-label">性别：</label>
							<div class="controls">
								<form:input path="customer.sex" value="${erp:sexStatusName(dispatch.customer.sex)}" disabled="true" htmlEscape="false" maxlength="20" class="input-medium"/>
							</div>
						</div>
					</td>
					<td>
						<div class="control-group">
							<label class="control-label">出生日期：</label>
							<div class="controls">
								<input name="customer.birthTime" disabled="disabled" type="text" readonly="readonly" maxlength="20"
									   class="input-medium Wdate "
									   value="<fmt:formatDate value="${dispatch.customer.birthTime}" pattern="yyyy-MM-dd HH:mm"/>"/>
							</div>
						</div>
					</td>
				</tr>
			</table>
		</div>

		<div class="alert alert-info">服务项目</div>
		<div class="control-group">
			<table  class="table table-striped table-bordered table-condensed" style="width:90%;">
				<thead>
				<tr>
					<th>订单编号</th>
					<th>商品名称</th>
					<th>服务项目</th>
					<th>购买数量</th>
					<th>服务次数</th>
				</tr>
				</thead>
				<tbody>
					<tr>
						<td>
								${dispatch.order.orderCode}
						</td>
						<td>
								${dispatch.skill.skillName}
						</td>
						<td>
								${dispatch.skill.skillName}
						</td>
					  	<td>
								${dispatch.orderItem.product.measureWay==2 ? dispatch.orderItem.num*dispatch.orderItem.productSku.minStock:dispatch.orderItem.num}
								${dispatch.skill.category == 1 ? '次':'天'}
					   	</td>
						<td>
								<%--基础服务--%>
								<c:if test="${dispatch.skill.category == 2}">
									${dispatch.skillNum != dispatch.usedNum ? 0:1}/1
								</c:if>
								<%--单项服务--%>
								<c:if test="${dispatch.skill.category == 1}">
									${empty dispatch.usedNum ? 0:dispatch.usedNum}/
									${dispatch.orderItem.product.measureWay==2 ? dispatch.orderItem.num*dispatch.orderItem.productSku.minStock:dispatch.orderItem.num}
								</c:if>
						</td>
					</tr>
				</tbody>
			</table>
		</div>

		<div class="alert alert-info">预约信息</div>
		<div class="control-group">
			<table>
				<tr>
					<td>
						<div class="control-group">
							<label class="control-label">预约时间：</label>
							<div class="controls">
								<input name="createTime" disabled="disabled" type="text" readonly="readonly" maxlength="20"
									   class="input-medium Wdate "
									   value="<fmt:formatDate value="${dispatch.createTime}" pattern="yyyy-MM-dd HH:mm"/>"/>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="control-group">
							<label class="control-label">预约上户时间：</label>
							<div class="controls">
								<input name="planStartTime" disabled="disabled" type="text" readonly="readonly" maxlength="20"
									   class="input-medium Wdate "
									   value="<fmt:formatDate value="${dispatch.planStartTime}" pattern="yyyy-MM-dd HH:mm"/>"/>
							</div>
						</div>
					</td>
					<td>
						<div class="control-group">
							<label class="control-label">预约下户时间：</label>
							<div class="controls">
								<input name="planEndTime" disabled="disabled" type="text" readonly="readonly" maxlength="20"
									   class="input-medium Wdate "
									   value="<fmt:formatDate value="${dispatch.planEndTime}" pattern="yyyy-MM-dd HH:mm"/>"/>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<div class="control-group">
							<label class="control-label">备注：</label>
							<div class="controls">
								<form:textarea path="remark"  rows="4" disabled="true" style="width:709px;"/>
							</div>
						</div>
					</td>
				</tr>
			</table>
		</div>

		<div class="alert alert-info">服务信息</div>
		<div class="control-group">
			<table  class="table table-striped table-bordered table-condensed" style="width:90%;">
				<thead>
				<tr>
					<th>服务人员姓名</th>
					<th>手机号</th>
					<th>预计开始服务时间</th>
					<th>实际开始服务时间</th>
					<th>预计结束服务时间</th>
					<th>实际结束服务时间</th>
					<th>服务时长</th>
					<th>服务状态</th>
				</tr>
				</thead>
				<tbody>
				<c:forEach items="${dispatchList}" var="newdispatch">
					<tr>
						<td>
								${newdispatch.dispatchEmployee.employee.name}
						</td>
						<td>
								${newdispatch.dispatchEmployee.employee.phone}
						</td>
						<td>
								<fmt:formatDate value="${newdispatch.planStartTime}" pattern="yyyy-MM-dd HH:mm"/>
						</td>
						<td>
								<fmt:formatDate value="${newdispatch.realStartTime}" pattern="yyyy-MM-dd HH:mm"/>
						</td>
						<td>
								<fmt:formatDate value="${newdispatch.planEndTime}" pattern="yyyy-MM-dd HH:mm"/>
						</td>
						<td>
								<fmt:formatDate value="${newdispatch.realEndTime}" pattern="yyyy-MM-dd HH:mm"/>
						</td>
						<td>
								${not empty newdispatch.realServiceTime ? newdispatch.realServiceTime:newdispatch.serviceTime}小时
						</td>
						<td>
								${erp:dispatchBillStatusName(newdispatch.status)}
						</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>

		<div class="alert alert-info">推荐服务人员信息</div>
		<strong>已推荐服务人员:</strong><br/>
		<div class="control-group">
			<table  class="table table-striped table-bordered table-condensed" style="width:90%;">
				<thead>
				<tr>
					<th>服务人员姓名</th>
					<th>编号</th>
					<th>技能点</th>
					<th>工作经验(年)</th>
					<th>星级</th>
					<th>服务价格(元)</th>
					<th>推荐时间</th>
				</tr>
				</thead>
				<tbody>
				<c:forEach items="${dispatchEmployeeList}" var="dispatchEmployee">
					<tr>
						<td>
								${dispatchEmployee.employee.name}
						</td>
						<td>
								${dispatchEmployee.employee.code}
						</td>
						<td>
								${erp:getCommonsTypeName(dispatchEmployee.employee.profession)}
						</td>
						<td>
								${not empty dispatchEmployee.employee.serviceYear? dispatchEmployee.employee.serviceYear:' '}
						</td>
						<td>
								${dispatchEmployee.employee.serviceLevelName}
						</td>
						<td>
								${not empty dispatchEmployee.employee.skillServicePrice? dispatchEmployee.employee.skillServicePrice:' '}
						</td>
						<td>
								<fmt:formatDate value="${dispatchEmployee.createTime}" pattern="yyyy-MM-dd HH:mm"/>
						</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>

		<strong>未选中的推荐服务人员:</strong><br/>
		<div class="control-group">
			<table  class="table table-striped table-bordered table-condensed" style="width:90%;">
				<thead>
				<tr>
					<th>服务人员姓名</th>
					<th>编号</th>
					<th>技能项</th>
					<th>工作经验</th>
					<th>星级</th>
					<th>服务价格</th>
					<th>推荐时间</th>
					<th>落选原因</th>
				</tr>
				</thead>
				<tbody>
				<c:forEach items="${noCheckList}" var="noCheck">
					<tr>
						<td>
								${noCheck.employee.name}
						</td>
						<td>
								${noCheck.employee.code}
						</td>
						<td>
								${erp:getCommonsTypeName(noCheck.employee.profession)}
						</td>
						<td>
								${not empty noCheck.employee.serviceYear? noCheck.employee.serviceYear:' '}
						</td>
						<td>
								${noCheck.employee.serviceLevelName}
						</td>
						<td>
								${not empty noCheck.employee.skillServicePrice? noCheck.employee.skillServicePrice:' '}
						</td>
						<td>
								<fmt:formatDate value="${noCheck.createTime}" pattern="yyyy-MM-dd HH:mm"/>
						</td>
						<td>
								${noCheck.reason}
						</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>

		<div class="form-actions">
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>