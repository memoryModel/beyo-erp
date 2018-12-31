<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>单表管理</title>
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


            $("input[name='closeWindows']").each(function () {
                $(this).click(function () {
                    top.$.jBox.close(true);
                });
            })
		});
	</script>
</head>
<body>
	<br/>
	<form:form id="inputForm" action="${ctx}/erp/productOrder/contractSave" method="post" class="form-horizontal">
		<input type="hidden" name="order.id" value="${order.id}"/>
		<input type="hidden" name="customer.id" value="${order.customer.id}"/>
		<sys:message content="${message}"/>
		<c:if test="${empty result}">
			<div class="control-group">
				<label class="control-label">客户名称：</label>
				<div class="controls">
					<input type="text" maxlength="128" class="input-xlarge " value="${order.customer.name}" readonly="readonly"/>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">客户编码：</label>
				<div class="controls">
					<input type="text" maxlength="128" class="input-xlarge " value="${order.customer.code}" readonly="readonly"/>
				</div>
			</div>

			<div class="control-group">
				<label class="control-label">合同名称：</label>
				<div class="controls">
					<input type="text" name="title" maxlength="128" class="required input-xlarge valid"/>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">合同编号：</label>
				<div class="controls">
					<input type="text" name="code" value="${code}" maxlength="128" class="required input-xlarge valid" readonly="readonly"/>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">签约时间：</label>
				<div class="controls">
					<input name="signTime" type="text" readonly="readonly" maxlength="20" class="required input-medium Wdate valid"
						   value=""  onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">合同备注：</label>
				<div class="controls">
				<input class="required input-xxlarge valid" name="remark" />
				</div>
			</div>

			<div class="control-group">
				<label class="control-label"><b>收费信息：</b></label>
			</div>
			<div class="control-group">
				<label class="control-label">订单总金额：</label>
				<div class="controls">
					<input type="text" value="${order.overallAmount}" class="input-xlarge  number" readonly="readonly"/>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">优惠金额：</label>
				<div class="controls">
					<input type="text" value="${order.favorableAmount}" class="input-xlarge  number" readonly="readonly"/>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">合同总金额：</label>
				<div class="controls">
					<input type="text" value="${order.paymentAmount}" class="input-xlarge  number" readonly="readonly"/>
				</div>
			</div>
			<div class="form-actions">
				<shiro:hasPermission name="erp:productOrder:contractSave">
					<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
				</shiro:hasPermission>
				<input name="closeWindows" class="btn" type="button" value="关 闭"/>
			</div>
		</c:if>
		<c:if test="${!empty result}">
			<div class="form-actions">
				<c:choose>
					<c:when test="${result == 'success'}">
						<div id="messageBox" class="alert alert-success"><button data-dismiss="alert" class="close">×</button>合同签订成功</div>
					</c:when>
					<c:otherwise>
						<div id="messageBox" class="alert alert-success"><button data-dismiss="alert" class="close">×</button>合同签订失败</div>
					</c:otherwise>
				</c:choose>

					<input name="closeWindows" class="btn" type="button" value="关 闭"/>
			</div>
		</c:if>
	</form:form>
</body>
</html>