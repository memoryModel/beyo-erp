<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>单表管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">

		$(document).ready(function() {
            var date = new Date();
            var currentTime = date.Format("yyyy-MM-dd hh:mm");
            $("#expenditureTime").val(currentTime);
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
		<li><a href="${ctx}/erp/dormCost/list">宿舍成本列表</a></li>
		<li class="active"><a href="${ctx}/erp/dormCost/form?id=${dormCost.id}">宿舍成本<shiro:hasPermission name="erp:dormCost:form">${not empty dormCost.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="erp:dormCost:form">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="dormCost" action="${ctx}/erp/dormCost/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<table>
	<%--		<tr>
				&lt;%&ndash;<td>
					<div class="control-group">
						<label class="control-label">城市:</label>
						<div class="controls">
							<sys:treeselect id="area" name="area.id" value="${dormCost.area.id}" labelName="area.name" labelValue="${erpDeormCost.area.name}"
											title="区域" url="/sys/area/treeData" cssClass="required"/>
						</div>
					</div>
				</td>&ndash;%&gt;


			</tr>--%>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">宿舍：</label>
						<div class="controls">
							<form:select path="erpDorm.id"  class="required" style="width: 210px;">
								<form:options items="${dromList}" itemLabel="dormName" itemValue="id" htmlEscape="false" />
							</form:select>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">支出费用：</label>
						<div class="controls">
							<form:input path="expenditureAmount" id="expenditureAmount" htmlEscape="false" style="width:180px;" class="required money valid " />
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">类型：</label>
						<div class="controls">
							<form:select path="type" style="width: 210px;" class="required">
								<form:options items="${erp:getCommonsTypeList(14)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
							</form:select>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">支出日期：</label>
						<div class="controls">
							<input name="expenditureTime" id="expenditureTime" type="text" readonly="readonly" maxlength="20" class="required input-medium Wdate " style="width: 180px"
								   value="<fmt:formatDate value="${dormCost.expenditureTime}" pattern="yyyy-MM-dd HH:mm"/>"
								   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});"/>
						</div>
					</div>
				</td>

			</tr>
			<%--<tr>
				<td>
					<div class="control-group">
						<label class="control-label">状态：</label>
						<div class="controls">
							<form:select path="status" class="input-large ">
								<form:options items="${erp:commonsStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
							</form:select>
						</div>
					</div>
				</td>
			</tr>--%>
		</table>
		<div class="form-actions">
			<shiro:hasPermission name="erp:dormCost:save"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>