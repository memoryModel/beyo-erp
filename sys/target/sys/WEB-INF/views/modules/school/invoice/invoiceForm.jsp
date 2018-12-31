<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>单表管理</title>
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
<form:form id="inputForm" modelAttribute="invoice" action="${ctx}/erp/invoice/save" method="post" class="form-horizontal">
	<form:hidden path="id"/>
	<form:hidden path="order.id"/>
	<sys:message content="${message}"/>

	<c:if test="${empty result}">
	<table>
		<tr>
			<td>
				<div class="control-group">
					<label class="control-label">发票类型：</label>
					<div class="controls">
						<form:select path="typeId" style="width: 200px;">
							<form:options items="${erp:getCommonsTypeList(38)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
						</form:select>
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class="control-group">
					<label class="control-label">金额：</label>
					<div class="controls">
						<form:input path="amount" htmlEscape="false" style="width:190px;" class="required input-xlarge " readonly="true"/>
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class="control-group">
					<label class="control-label">发票抬头：</label>
					<div class="controls">
						<form:input path="title" htmlEscape="false" style="width:190px;" class="required input-xlarge valid" />
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class="control-group">
					<label class="control-label">发票内容：</label>
					<div class="controls">
						<form:select path="subjectId" style="width: 200px;">
							<form:options items="${erp:getCommonsTypeList(44)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
						</form:select>
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class="control-group">
					<label class="control-label">收款单位：</label>
					<div class="controls">
						<form:select path="payeeId" style="width: 200px;">
							<form:options items="${erp:getCommonsTypeList(45)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
						</form:select>
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class="control-group">
					<label class="control-label">申请人：</label>
					<div class="controls">
						<sys:treeselect id="createUser" name="user.id" value="${invoice.user.id}"
										labelName="user.name" labelValue="${invoice.user.name}"
										title="用户" url="/sys/office/treeData?type=3" notAllowSelectParent="true" cssClass="required valid" />
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<div class="form-actions">
					<shiro:hasPermission name="erp:invoice:save"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
					<input name="closeWindows" class="btn" type="button" value="返 回" />
				</div>
			</td>
		</tr>
	</table>
	</c:if>
	<c:if test="${!empty result}">
		<div class="form-actions">
			<c:choose>
				<c:when test="${result == 'success'}">
					<div id="messageBox" class="alert alert-success"><button data-dismiss="alert" class="close">×</button>申请成功</div>
				</c:when>
				<c:otherwise>
					<div id="messageBox" class="alert alert-success"><button data-dismiss="alert" class="close">×</button>申请失败</div>
				</c:otherwise>
			</c:choose>

			<input name="closeWindows" class="btn" type="button" value="关 闭"/>
		</div>
	</c:if>
</form:form>
</body>
</html>