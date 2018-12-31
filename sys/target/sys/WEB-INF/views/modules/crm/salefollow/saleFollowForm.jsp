<%@ taglib prefix="from" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>销售跟进管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
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
			<li class="active"><a href="${ctx}/crm/saleFollow/form?saleId=${saleId}">跟进记录</a></li>
		</ul>
	<form:form id="inputForm" modelAttribute="saleFollow" action="${ctx}/crm/saleFollow/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<input type="hidden" value="${crmSale.id}" name="saleId">
		<input type="hidden" value="${saleDelegateRecordId}" name="saleDelegateRecordId">
		<input type="hidden" name="recordStatus" value="${saleFollow.recordStatus}">
		<input name="firstFollowTime"  type="hidden" value="<fmt:formatDate value="${firstFollowTime}" pattern="yyyy-MM-dd HH:mm"/>"/>
		<input name="newFollowTime"  type="hidden" value="<fmt:formatDate value="${newFollowTime}" pattern="yyyy-MM-dd HH:mm"/>"/>
		<table>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">客户：</label>
						<div class="controls">
							<input  id="customer.name"  value="${crmSale.customer.name}"  class="input-large" readonly="true"/>
						</div>
					</div>

				</td>
				<td>
					<div class="control-group">
						<label class="control-label">手机号码：</label>
						<div class="controls">
							<input  id="customer.phone"  value="${crmSale.customer.phone}"  class="input-large" readonly="true"/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">意向业务：</label>
						<div class="controls">
							<input  id="crmSale.serviceTypeId"  value="${erp:getCommonsTypeName(crmSale.serviceTypeId)}"  class="input-large" readonly="true"/>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">重要程度：</label>
						<div class="controls">
							<input  id="crmSale.importantDegree"  value="${erp:getCommonsTypeName(crmSale.importantDegree)}"  class="input-large" readonly="true"/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">跟进人：</label>
						<div class="controls">
							<input  id="saleDelegateRecord.saleAdviserName.name"  value="${crmSale.saleDelegateRecord.saleAdviserName.name}"  class="input-large" readonly="true"/>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">跟进时间：</label>
						<div class="controls">
							<input name="followTime"  type="text" readonly="readonly" maxlength="20" class="required input-medium Wdate "
								   value="<fmt:formatDate value="${saleFollow.followTime}" pattern="yyyy-MM-dd HH:mm"/>"
								   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});" />
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">跟进阶段：</label>
						<div class="controls">
							<form:select path="followStage" class="required input-medium">
								<form:options items="${erp:getCommonsTypeList(9)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
							</form:select>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">客户意向：</label>
						<div class="controls">
							<form:select path="customerIntention"  class="requird input-medium" >
								<form:options items="${erp:getCommonsTypeList(49)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
							</form:select>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">跟进形式：</label>
						<div class="controls">
							<form:select path="followForm" class="required input-medium" >
								<form:options items="${erp:getCommonsTypeList(8)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
							</form:select>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">成单几率：</label>
						<div class="controls">
							<form:select path="orderFormPercentage" class="required input-medium" >
								<form:options items="${erp:getCommonsTypeList(24)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
							</form:select>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>
			</tr>
			<tr>

				<td>
					<div class="control-group">
						<label class="control-label">预计成单时间：</label>
						<div class="controls">
							<input name="orderFormTime" id="orderFormTime" type="text" maxlength="20" class="required input-medium Wdate "
								   value="<fmt:formatDate value="${saleFollow.orderFormTime}" pattern="yyyy-MM-dd HH:mm"/>"
								   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});" />
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div></td>
				<td>
					<div class="control-group">
						<label class="control-label">预计成单金额：</label>
						<div class="controls">
							<form:input path="orderFormAmount" id="orderFormAmount" htmlEscape="false" class="required money valid"/>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="4">
					<div class="control-group">
						<label class="control-label">跟进主题：</label>
						<div class="controls">
							<form:textarea path="theme" htmlEscape="false" rows="2" maxlength="1024" class="required input-xxlarge"/>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="4">
					<div class="control-group">
						<label class="control-label">跟进内容：</label>
						<div class="controls">
							<form:textarea path="content" htmlEscape="false" rows="2" maxlength="1024"  class="input-xxlarge"/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="4">
					<div class="control-group">
						<label class="control-label">备注内容：</label>
						<div class="controls">
							<form:textarea path="remark" htmlEscape="false" rows="2" maxlength="1024" class="input-xxlarge"/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<div class="control-group">
						<label class="control-label">下次跟进安排：</label>
						<div class="controls">
							<input type="radio" value="0" checked="checked" name="nextFollowPlan">是
							<input type="radio" value="1" name="nextFollowPlan">否
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">下次跟进方式：</label>
						<div class="controls">
							<form:select path="nextFollowForm"  class="required input-medium">
								<form:options items="${erp:getCommonsTypeList(8)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
							</form:select>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">下次跟进时间：</label>
						<div class="controls">
							<input name="nextFollowTime" type="text" readonly="readonly" maxlength="20" class="required input-medium Wdate "
								   value="<fmt:formatDate value="${saleFollow.nextFollowTime}" pattern="yyyy-MM-dd HH:mm"/>"
								   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});"/>
							<span class="help-inline"><font color="red">*</font> </span>

						</div>
					</div>
				</td>

			</tr>
		</table>
		<div class="form-actions">
			<shiro:hasPermission name="crm:saleFollow:save"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>