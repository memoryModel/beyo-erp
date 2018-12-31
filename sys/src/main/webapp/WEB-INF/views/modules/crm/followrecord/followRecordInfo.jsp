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

	<ul class="nav nav-tabs">
		<br/>
		<font size="5">&nbsp;&nbsp;&nbsp;&nbsp;我的跟进记录</font>
	</ul><br/>
	<ul class="nav nav-tabs">
		<font size="5">&nbsp;&nbsp;&nbsp;&nbsp;跟进记录详情</font>
	</ul>

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
							${followRecord.intentProfession}
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">跟进人：</label>
						<div class="controls">
							${followRecord.user.name}
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">跟进时间：</label>
						<div class="controls">
							<fmt:formatDate value="${followRecord.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label"><font color="red">*</font>&nbsp;跟进形式：</label>
						<div class="controls">
							<c:forEach items="${erp:getCommonsTypeList(55)}" var="commonsType">
								<c:if test="${commonsType.id == followRecord.type}">
									${commonsType.commonsName}
								</c:if>
							</c:forEach>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label"><font color="red">*</font>&nbsp;客户意向：</label>
						<div class="controls">
							${erp:customerIntentionStatusName(followRecord.intent)}
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label"><font color="red">*</font>&nbsp;跟进主题：</label>
						<div class="controls">
							${followRecord.theme}
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label"><font color="red">*</font>&nbsp;跟进内容：</label>
						<div class="controls">
							${followRecord.content}
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label"><font color="red">*</font>&nbsp;下次跟进安排：</label>
						<div class="controls">
							<input type="radio" id="radioOne" disabled="disabled" name="nextLayout" value="1">有 &nbsp;
							<input type="radio" id="radioTwo" disabled="disabled" name="nextLayout" value="2">无
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label"><font color="red">*</font>&nbsp;下次跟进方式：</label>
						<div class="controls">
							<c:forEach items="${erp:getCommonsTypeList(55)}" var="commonsType">
								<c:if test="${commonsType.id == followRecord.nextType}">
									${commonsType.commonsName}
								</c:if>
							</c:forEach>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">下次跟进时间：</label>
						<div class="controls">
							<fmt:formatDate value="${followRecord.nextTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
						</div>
					</div>
				</td>
			</tr>
		</table>

		<div class="form-actions">
			<input id="btnCancel" class="btn" type="button" style="width:130px;height:40px;" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>