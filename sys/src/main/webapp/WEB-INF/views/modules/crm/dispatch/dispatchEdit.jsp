<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>修改派工信息</title>
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
		<li class="active"><a href="${ctx}/crm/dispatch/edit?id=${dispatch.id}">预约信息修改</a></li>
	</ul><br/>
	<%--<form:form id="inputForm" modelAttribute="dispatch" class="form-horizontal">--%>
	<form:form id="inputForm" modelAttribute="dispatch" action="${ctx}/crm/dispatch/save" method="post" class="form-horizontal">
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
								<input name="createTime" type="text" maxlength="20" class="required input-medium Wdate "
									   value="<fmt:formatDate value="${dispatch.createTime}" pattern="yyyy-MM-dd HH:mm"/>"
									   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});" />
								<span class="help-inline"><font color="red">*</font> </span>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="control-group">
							<label class="control-label">预约上户时间：</label>
							<div class="controls">
								<input name="planStartTime" type="text" maxlength="20" class="required input-medium Wdate "
									   value="<fmt:formatDate value="${dispatch.planStartTime}" pattern="yyyy-MM-dd HH:mm"/>"
									   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});" />
								<span class="help-inline"><font color="red">*</font> </span>
							</div>
						</div>
					</td>
					<td>
						<div class="control-group">
							<label class="control-label">预约下户时间：</label>
							<div class="controls">
								<input name="planEndTime" type="text" maxlength="20" class="required input-medium Wdate "
									   value="<fmt:formatDate value="${dispatch.planEndTime}" pattern="yyyy-MM-dd HH:mm"/>"
									   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});"/>
								<span class="help-inline"><font color="red">*</font> </span>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<div class="control-group">
							<label class="control-label">地区：</label>
							<div class="controls">
								<sys:treeselect id="area" name="area.id" value="${dispatch.area.id}"
										labelName="area.name" labelValue="${dispatch.area.name}"
										title="区域" url="/sys/area/treeData" notAllowSelectParent="true" cssClass="input-large required"/>
								<span class="help-inline"><font color="red">*</font> </span>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<div class="control-group">
							<label class="control-label">详细地址：</label>
							<div class="controls">
								<form:input path="serviceAddress" htmlEscape="false"  maxlength="1024" class="input-xxlarge required"/>
								<span class="help-inline"><font color="red">*</font> </span>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<div class="control-group">
							<label class="control-label">备注：</label>
							<div class="controls">
								<form:textarea path="remark"  rows="4" style="width:709px;"/>
							</div>
						</div>
					</td>
				</tr>
			</table>
		</div>

		<div class="form-actions">
			<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>