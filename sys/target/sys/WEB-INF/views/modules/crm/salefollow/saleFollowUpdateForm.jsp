<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>销售跟进管理</title>
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
	<li><a href="${ctx}/crm/sale/list">销售线索列表</a></li>
	<li><a href="${ctx}/crm/sale/saleInfo?id=${saleFollow.crmSale.id}">基本信息</a></li>
	<li class="active"><a href="${ctx}/crm/saleFollow/saleFollowInfo?saleId=${saleFollow.crmSale.id}">跟进记录</a></li>
</ul></div><br/><div>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/crm/saleFollow/form?id=${saleFollow.id}&&saleId=${saleFollow.crmSale.id}">跟进记录详情</a></li>
	</ul></div><br/>
	<form:form id="inputForm" modelAttribute="saleFollow" action="${ctx}/crm/saleFollow/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<table>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">跟进人：</label>
						<div class="controls">
							<form:input  path="followPeopleName" value="${name}" style="width: 150px;" class="input-large " readonly="true"/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">跟进时间：</label>
						<div class="controls">
							<input name="followTime" type="text" readonly="readonly" maxlength="20"  style="width:150px;"
								   value="<fmt:formatDate value="${saleFollow.followTime}" pattern="yyyy-MM-dd"/>"/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">服务类型：</label>
						<div class="controls">
							<input type="text" value="${skillName}"  style="width: 150px;"  class="input-large" readonly="true"/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">跟进阶段：</label>
						<div class="controls">
							<%--<form:select path="followStage" style="width: 150px;">
								<form:options items="${erp:getCommonsTypeList(9)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
							</form:select>--%>
							<form:input  path="followStage" value="${erp:getCommonsTypeName(saleFollow.followStage)}" style="width: 150px;" class="input-large " readonly="true"/>

						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">跟进形式：</label>
						<div class="controls">
							<%--<form:select path="followForm" style="width: 170px;">
								<form:options items="${erp:getCommonsTypeList(8)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
							</form:select>--%>
							<form:input  path="followForm" value="${erp:getCommonsTypeName(saleFollow.followForm)}" style="width: 150px;" class="input-large " readonly="true"/>

						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">客户意向：</label>
						<div class="controls">
							<form:input  path="customerIntention" value="${erp:getCommonsTypeName(saleFollow.customerIntention)}" style="width: 150px;" class="input-large " readonly="true"/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="6">
					<div class="control-group">
						<label class="control-label">跟进主题：</label>
						<div class="controls">
							<form:textarea path="theme" rows="2" style="width:920px;" htmlEscape="false" readonly="true" value="${saleFollow.theme}"></form:textarea>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="6">
					<div class="control-group">
						<label class="control-label">详细内容：</label>
						<div class="controls">
							<form:textarea path="content" rows="2"  style="width:920px;" htmlEscape="false" readonly="true" value="${saleFollow.content}"></form:textarea>
						</div>
					</div>
				</td>
			</tr>

			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">成单几率：</label>
						<div class="controls">
							<form:select path="orderFormPercentage" style="width: 170px;">
								<form:options items="${erp:getCommonsTypeList(24)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
							</form:select>

							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">预计成单时间：</label>
						<div class="controls">
							<input name="orderFormTime" type="text" readonly="true" maxlength="20"
								   value="<fmt:formatDate value="${saleFollow.orderFormTime}" pattern="yyyy-MM-dd HH:mm"/>"/>
						</div>
					</div></td>
				<td>
					<div class="control-group">
						<label class="control-label">预计成单金额：</label>
						<div class="controls">
							<form:input path="orderFormAmount" style="width: 150px;" readonly="true" value="${saleFollow.orderFormAmount}" class="input-large "/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="6">
					<div class="control-group">
						<label class="control-label">备注内容：</label>
						<div class="controls">
							<form:textarea path="remark" rows="3"  style="width:920px;" htmlEscape="false" readonly="true" value="${saleFollow.remark}"></form:textarea>
						</div>
					</div>
				</td>
			</tr>
		</table>
		                     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>下次提醒计划</strong>
		<table>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">下次跟进时间：</label>
						<div class="controls">
							<input name="nextFollowTime" type="text" readonly="readonly" maxlength="20"
								   value="<fmt:formatDate value="${saleFollow.orderFormTime}" pattern="yyyy-MM-dd HH:mm"/>"/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">下次跟进形式：</label>
						<div class="controls">
							<form:input  path="nextFollowForm" value="${erp:getCommonsTypeName(saleFollow.nextFollowForm)}" style="width: 150px;" class="input-large " readonly="true"/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<div class="control-group">
						<label class="control-label">下次跟进主题：</label>
						<div class="controls">
							<form:textarea path="nextFollowTheme" rows="2"  style="width:920px;" htmlEscape="false" readonly="true" value="${saleFollow.nextFollowTheme}"></form:textarea>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="6">
					<div class="control-group">
						<label class="control-label">是否短信提醒：</label>
						<div class="controls">
							<form:radiobuttons path="remind" items="${fns:getDictList('message_remind')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required"/>
						</div>
					</div>
				</td>

			</tr>
			<tr>
				<td colspan="6">
					<div class="control-group">
						<label class="control-label">联系方式：</label>
						<div class="controls">
							<form:input path="phone"  style="width: 200px;" class="input-large " readonly="true"/>
						</div>
					</div>
				</td>
			</tr>
		</table>
	</form:form>
</body>
</html>