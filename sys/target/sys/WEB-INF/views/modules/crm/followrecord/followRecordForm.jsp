<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>客户跟进记录管理</title>
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
            nextLayoutJudgment();
		});

		function nextLayoutJudgment(){
		    var value = '${followRecord.nextLayout}';
		    if (value == 1){
		        $("#radioOne").attr("checked",true);
            }else if(value == 2){
                $("#radioTwo").attr("checked",true);
            }
		}

	</script>
</head>
<body>
	<%--followFlag等于1时是 在跟进中客户-跟进次数-修改功能发起的请求--%>
	<c:if test="${followFlag == 1}">
		<ul class="nav nav-tabs">
			<br/>
			<font size="5">&nbsp;&nbsp;&nbsp;&nbsp;修改跟进记录</font>
		</ul><br/>
	</c:if>
	<c:if test="${followFlag == null}">
		<ul class="nav nav-tabs">
			<br/>
			<font size="5">&nbsp;&nbsp;&nbsp;&nbsp;添加跟进记录</font>
		</ul><br/>
	</c:if>

	<form:form id="inputForm" modelAttribute="followRecord" action="${ctx}/crm/followRecord/save" method="post" class="form-horizontal">
		<input type="hidden" name="customer.id" value="${customer.id}">
		<input type="hidden" name="user.id" value="${followRecord.user.id}">
		<form:hidden path="id"/>
		<c:if test="${flag != null}">
			<input type="hidden" name="flag" value="1">
		</c:if>
		<sys:message content="${message}"/>
		<table>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">客户姓名：</label>
						<div class="controls">
							${customer.name}
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">手机号码：</label>
						<div class="controls">
							${customer.phone}
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">意向服务：</label>
						<div class="controls">
							<form:input path="intentProfession" htmlEscape="false" maxlength="20" class="input-xlarge  digits"/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">跟进人：</label>
						<div class="controls">
							<form:input path="user.name" htmlEscape="false" disabled="true" maxlength="20" class="input-xlarge  digits"/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">跟进时间：</label>
						<div class="controls">
							<input name="createTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
								   value="<fmt:formatDate value="${followRecord.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
								   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label"><font color="red">*</font>&nbsp;跟进形式：</label>
						<div class="controls">
							<form:select path="type" class="input-xlarge">
								<form:options items="${erp:getCommonsTypeList(55)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
							</form:select>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label"><font color="red">*</font>&nbsp;客户意向：</label>
						<div class="controls">
							<form:select path="intent" class="required" style="width: 220px">
								<form:options items="${erp:customerIntentionList()}" itemLabel="name" itemValue="value" htmlEscape="false" />
							</form:select>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label"><font color="red">*</font>&nbsp;跟进主题：</label>
						<div class="controls">
							<form:textarea path="theme" htmlEscape="false" rows="1" maxlength="200" class="required input-xxlarge " style="width: 350px;"/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label"><font color="red">*</font>&nbsp;跟进内容：</label>
						<div class="controls">
							<form:textarea path="content" htmlEscape="false" rows="4" maxlength="200" class="required input-xxlarge " style="width: 350px;"/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label"><font color="red">*</font>&nbsp;下次跟进安排：</label>
						<div class="controls">
							<input type="radio" id="radioOne" name="nextLayout" value="1">有 &nbsp;
							<input type="radio" id="radioTwo" name="nextLayout" value="2">无
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label"><font color="red">*</font>&nbsp;下次跟进方式：</label>
						<div class="controls">
							<form:select path="nextType" class="input-xlarge">
								<form:options items="${erp:getCommonsTypeList(55)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
							</form:select>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">下次跟进时间：</label>
						<div class="controls">
							<input name="nextTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
								   value="<fmt:formatDate value="${followRecord.nextTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
								   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
						</div>
					</div>
				</td>
			</tr>
		</table>

		<div class="form-actions">
			<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
			<input id="btnCancel" class="btn" type="button" value="取 消" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>