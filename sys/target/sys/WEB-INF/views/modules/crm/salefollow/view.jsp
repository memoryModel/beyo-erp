<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>
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
			var viewStatus = '${viewStatus}'
			if(viewStatus != '' && parseInt(viewStatus) == 1){
			    $('li[plan="plan"]').hide();
			}
		});
	</script>
</head>
<body>
<ul class="nav nav-tabs">
	<li><a href="${ctx}/crm/sale/saleInfo?id=${sale.id}&&tagFlag=${tagFlag}">线索信息</a></li>
	<li class="active"><a href="${ctx}/crm/saleFollow/view?saleId=${sale.id}&&saleDelegateRecordId=${sale.saleDelegateRecord.id}&&tagFlag=${tagFlag}">跟进记录</a></li>
	<li plan="plan"><a href="${ctx}/crm/saleFollow/findAllListBySaleId?saleId=${sale.id}&&tagFlag=${tagFlag}">跟进计划</a></li>
	<li><a href="/erp/productOrder/saleOrderList?customerId=${sale.customer.id}">预定订单</a></li>
</ul>
	<form:form id="inputForm" modelAttribute="saleFollow" action="${ctx}/crm/saleFollow/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<table>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">客户：</label>
						<div class="controls">
							<input  id="customer.name"  value="${sale.customer.name}"  class="input-large" readonly="true"/>
						</div>
					</div>

				</td>
				<td>
					<div class="control-group">
						<label class="control-label">手机号码：</label>
						<div class="controls">
							<input  id="customer.phone"  value="${sale.customer.phone}"  class="input-large" readonly="true"/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">意向业务：</label>
						<div class="controls">
							<input  id="crmSale.serviceTypeId"  value="${erp:getCommonsTypeName(sale.serviceTypeId)}"  class="input-large" readonly="true"/>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">重要程度：</label>
						<div class="controls">
							<input  id="crmSale.importantDegree"  value="${erp:getCommonsTypeName(sale.importantDegree)}"  class="input-large" readonly="true"/>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">跟进人：</label>
						<div class="controls">
							<input  id="saleDelegateRecord.saleAdviserName.name"  value="${sale.saleDelegateRecord.saleAdviserName.name}"  class="input-large" readonly="true"/>
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
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">跟进阶段：</label>
						<div class="controls">
							<form:select path="followStage" class="required input-medium" disabled="true">
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
							<form:select path="customerIntention"  class="requird input-medium" disabled="true">
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
							<form:select path="followForm" class="required input-medium" disabled="true" >
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
							<form:select path="orderFormPercentage" class="required input-medium" disabled="true" >
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
							<input name="orderFormTime" id="orderFormTime" type="text" readonly="readonly" maxlength="20" class="required input-medium Wdate "
								   value="<fmt:formatDate value="${saleFollow.orderFormTime}" pattern="yyyy-MM-dd HH:mm"/>"
								   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});" />
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div></td>
				<td>
					<div class="control-group">
						<label class="control-label">预计成单金额：</label>
						<div class="controls">
							<form:input path="orderFormAmount" id="orderFormAmount" htmlEscape="false" class="required money valid" readonly="true"/>
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
							<form:textarea path="theme" htmlEscape="false" rows="2" maxlength="1024" class="required input-xxlarge" readonly="true"/>
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
							<form:textarea path="content" htmlEscape="false" rows="2" maxlength="1024"  class="input-xxlarge" readonly="true"/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="4">
					<div class="control-group">
						<label class="control-label">备注内容：</label>
						<div class="controls">
							<form:textarea path="remark" htmlEscape="false" rows="2" maxlength="1024" class="input-xxlarge" readonly="true"/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<div class="control-group">
						<label class="control-label">下次跟进安排：</label>
						<div class="controls">

							<input type="radio" value="0" name="nextFollowPlan" <c:if test="${saleFollow.nextFollowPlan ==0}">checked</c:if>>是
							<input type="radio" value="1" name="nextFollowPlan" <c:if test="${saleFollow.nextFollowPlan ==1}">checked</c:if>>否
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">下次跟进方式：</label>
						<div class="controls">
							<form:select path="nextFollowForm"  class="required input-medium" disabled="true">
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
		<div>
			<input type="button" class="btn btn-primary" onclick="history.go(-1)" value="返回">
		</div>
	</form:form>
</body>
</html>