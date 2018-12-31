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
	<form:form id="inputForm" action="${ctx}/erp/productOrder/paySave" method="post" class="form-horizontal">
		<input type="hidden" name="order.id" value="${order.id}"/>
		<sys:message content="${message}"/>
		<c:if test="${empty result}">
			<div class="control-group">
				<label class="control-label">支付金额：</label>
				<div class="controls">
					<input type="text" name="totalAmount" class="required money valid" value="${order.paymentAmount}"/>&nbsp;元
					<span class="help-inline">
						<font color="red">*</font>
				</span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">收款类型</label>
				<div class="controls">
					<select name="payCategory" class="input-medium">
						<c:forEach items="${erp:getCommonsTypeList(19)}" var="type">
							<option value="${type.id}">${type.commonsName}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">财务科目：</label>
				<div class="controls">
					<sys:treeselect id="finaceId" name="finaceId" labelName="subjectName" labelValue="" title="财务科目" url="/erp/finaceType/treeData" cssClass="required" value=""/>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">支付方式</label>
				<div class="controls">
					<select name="typeId" class="input-medium">
						<c:forEach items="${erp:getCommonsTypeList(16)}" var="type">
							<option value="${type.id}">${type.commonsName}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">支付时间：</label>
				<div class="controls">
					<input name="payTime" type="text" readonly="readonly" maxlength="20" class="required input-medium Wdate valid"
						   value="<fmt:formatDate value="${currentTime}" pattern="yyyy-MM-dd"/>"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">备注：</label>
				<div class="controls">
					<input class="required input-xxlarge valid" name="remark" />
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">操作人：</label>
				<div class="controls">
					<sys:treeselect id="payUserId" name="payUser.id" value="${currentUser.id}"
									labelName="sale.name" labelValue="${currentUser.name}"
									title="选择用户" url="/sys/office/treeData?type=3" notAllowSelectParent="true" cssClass="required"/>

				</div>
			</div>
			<div class="form-actions">
				<shiro:hasPermission name="erp:productOrder:paySave">
					<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
				</shiro:hasPermission>
				<input name="closeWindows" class="btn" type="button" value="关闭"/>
			</div>
		</c:if>
		<c:if test="${!empty result}">
			<div class="form-actions">
				<c:choose>
					<c:when test="${result == 'success'}">
						<div id="messageBox" class="alert alert-success"><button data-dismiss="alert" class="close">×</button>订单支付成功</div>
					</c:when>
					<c:otherwise>
						<div id="messageBox" class="alert alert-success"><button data-dismiss="alert" class="close">×</button>订单支付失败</div>
					</c:otherwise>
				</c:choose>

					<input name="closeWindows" class="btn" type="button" value="关 闭"/>
			</div>
		</c:if>
	</form:form>
</body>
</html>