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
	<form:form id="inputForm" action="${ctx}/erp/productOrder/saleSave" method="post" class="form-horizontal">
		<input type="hidden" name="id" value="${order.id}"/>
		<sys:message content="${message}"/>
		<c:if test="${empty result}">
			<div class="control-group">
				<label class="control-label">销售顾问：</label>
				<div class="controls">
					<sys:treeselect id="saleId" name="sale.id" value="${order.sale.id}"
									labelName="sale.name" labelValue="${order.sale.name}"
									title="选择用户" url="/sys/office/treeData?type=3" notAllowSelectParent="true" cssClass="required"/>

				</div>
			</div>
			<div class="form-actions">
				<shiro:hasPermission name="erp:productOrder:saleSave">
					<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
				</shiro:hasPermission>
				<input name="closeWindows" class="btn" type="button" value="返 回" />
			</div>
		</c:if>
		<c:if test="${!empty result}">
			<div class="form-actions">
				<c:choose>
					<c:when test="${result == 'success'}">
						<div id="messageBox" class="alert alert-success"><button data-dismiss="alert" class="close">×</button>委派成功</div>
					</c:when>
					<c:otherwise>
						<div id="messageBox" class="alert alert-success"><button data-dismiss="alert" class="close">×</button>委派失败</div>
					</c:otherwise>
				</c:choose>

					<input name="closeWindows" class="btn" type="button" value="关 闭"/>
			</div>
		</c:if>
	</form:form>
</body>
</html>