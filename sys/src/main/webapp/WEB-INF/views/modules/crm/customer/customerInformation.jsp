<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>客户管理</title>
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

            judgmentSex();
		});

		function judgmentSex(){
		    var value = '${customer.sex}'
			if (value == 1){
				$('#radioOne').attr("checked",true);
            }else {
                $('#radioTwo').attr("checked",true);
            }
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/crm/customer/editClientInfo?id=${customer.id}">基本信息</a></li>
		<li><a href="${ctx}/crm/customer/list">扩展信息</a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="customer" action="${ctx}/crm/customer/updateCustomer" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="type"/>
		<form:hidden path="status"/>
		<input type="hidden" value="${flag}" name="flag">
		<input type="hidden" value="${customer.phone}" id="oldPhone">
		<sys:message content="${message}"/>
		<table>
			<tr>
				<div class="control-group">
					<label class="control-label">客户编号：</label>
					<div class="controls">
							${customer.code}
					</div>
				</div>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label"><font color="red">*</font>&nbsp; 客户姓名：</label>
						<div class="controls">
							<form:input path="name" htmlEscape="false" disabled="true" maxlength="200" class="required input-xlarge " style="width:208px"/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label"><font color="red">*</font>&nbsp; 手机号码：</label>
						<div class="controls">
							<form:input path="phone" htmlEscape="false" disabled="true" maxlength="200" class="required input-xlarge " style="width:208px"/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label"><font color="red">*</font>&nbsp; 客户性别：</label>
						<div class="controls">
							<input id="radioOne" type="radio" disabled="disabled">男 &nbsp;
							<input id="radioTwo" type="radio" disabled="disabled">女
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">出生日期：</label>
						<div class="controls">
							<input name="birthTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate " style="width: 210px"
								   value="<fmt:formatDate value="${customer.birthTime}" pattern="yyyy-MM-dd"/>"
								   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">qq号码：</label>
						<div class="controls">
							<form:input path="qqCode" htmlEscape="false" class="number" maxlength="50"/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">邮箱地址：</label>
						<div class="controls">
							<form:input path="email" htmlEscape="false" maxlength="128" class="email valid "/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label"><font color="red">*</font> &nbsp; 客户来源：</label>
						<div class="controls">
							<sys:treeselect id="customerResource" name="customerResource.id" value="${customer.customerResource.id}"
											labelName="customerResource.customerName" labelValue="${customer.customerResource.customerName}"
											title="来源名称" url="/erp/customerResource/treeData" cssClass="required"/>

						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label"><font color="red">*</font> &nbsp; 客户类别：</label>
						<div class="controls">
							<form:select path="type"  style="width: 220px" class="required">
								<form:options items="${erp:customerTypeList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
							</form:select>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">推荐人：</label>
						<div class="controls">
							<form:input path="name" htmlEscape="false" disabled="true" maxlength="200" class="required input-xlarge " style="width:208px"/>
						</div>
					</div>
				</td>
				<%--todo:手机号码重复--%>
				<td>
					<div class="control-group">
						<label class="control-label">手机号码：</label>
						<div class="controls">
							<form:input path="name" htmlEscape="false" disabled="true" maxlength="200" class="required input-xlarge " style="width:208px"/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label"><font color="red">*</font> &nbsp; 所在地区：</label>
						<div class="controls">
							<sys:treeselect id="area" name="area.id" value="${customer.area.id}"
											labelName="area.name" labelValue="${customer.area.name}"
											title="区域" url="/sys/area/treeData" cssClass="required" allowClear="true"/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">详情地址：</label>
						<div class="controls">
							<form:textarea path="address" htmlEscape="false" rows="1" maxlength="200" class="required input-xxlarge " style="width: 300px;"/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">信息获取人：</label>
						<div class="controls">
							<form:input path="infoCollect.name" htmlEscape="false" disabled="true" maxlength="200" class="required input-xlarge " style="width:208px"/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">信息添加人：</label>
						<div class="controls">
							<form:input path="creater.name" htmlEscape="false" disabled="true" maxlength="200" class="required input-xlarge " style="width:208px"/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">添加时间：</label>
						<div class="controls">
							<input name="createTime" type="text" readonly="readonly" maxlength="20" disabled="disabled" class="input-medium Wdate " style="width: 210px"
								   value="<fmt:formatDate value="${customer.birthTime}" pattern="yyyy-MM-dd"/>"
								   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
						</div>
					</div>
				</td>
			</tr>
		</table>














		<div class="form-actions">
			<shiro:hasPermission name="crm:customer:save">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>