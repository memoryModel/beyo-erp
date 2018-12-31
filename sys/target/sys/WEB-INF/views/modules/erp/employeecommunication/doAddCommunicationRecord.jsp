<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>添加沟通记录</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {

            $("input[name='closeWindows']").each(function () {
                $(this).click(function () {
                    top.$.jBox.close(true);
                });
            })

			$('input[type="radio"][name="nextCommunicationArrangement"]').click(function () {
				if($(this).val()==0){
				    $('tr[name="nextCommunication"]').show();
				}
				if($(this).val()==1){
                    $('tr[name="nextCommunication"]').hide();
				}
            })

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

            //如果下次沟通安排选中有 则下次沟通方式为必填
            jQuery.validator.addMethod("nextCommunicationModeRequired", function (value, element) {
                var flag = true;
                var nextCommunicationArrangementValue = $('input[type="radio"][name="nextCommunicationArrangement"]:checked').val();
                if(nextCommunicationArrangementValue == 0){
                    if(value != null && value != ''){
                        flag = true;
                    }else{
                        flag = false;
                    }
                }
                return flag;

            }, "必填信息");

            //如果下次沟通安排选中有 则下次沟通时间为必填
            jQuery.validator.addMethod("nextCommunicationTimeRequired", function (value, element) {
                var flag = true;
                var nextCommunicationArrangementValue = $('input[type="radio"][name="nextCommunicationArrangement"]:checked').val();
                if(nextCommunicationArrangementValue == 0){
                    if(value != null && value != ''){
                        flag = true;
                    }else{
                        flag = false;
                    }
                }
                return flag;

            }, "必填信息");

		});

	</script>
</head>
<body>
	<form:form id="inputForm" modelAttribute="employeeCommunicationHistory" action="${ctx}/erp/employeeCommunication/doAddCommunicationRecord" method="post" class="breadcrumb form-search">
		<c:if test="${empty result}">
			<input type="hidden" name="employeeId" value="${employee.id}">
			<input type="hidden" name="communicationId" value="${employee.employeeCommunication.communicationId}">
			<table>
				<tr>
					<td>
						<div class="control-group">
							员工姓名：${employee.name}
						</div>
					</td>
					<td>
						<div class="control-group">
							手机号码：${employee.phone}
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="control-group">
							沟 通 人：${employee.employeeCommunication.communicationPerson}

								<%--<sys:treeselect id="interviewers" name="communicationId" value="${interview.interviewers.id}"
												labelName="communicationName" labelValue="${interview.interviewers.name}"
												title="选择用户" url="/sys/office/treeData?type=3" notAllowSelectParent="true" cssClass="required"/>--%>
						</div>
					</td>
					<td>
						<div class="control-group">
							沟通时间：

								<input name="communicationTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
									   value="<fmt:formatDate value="${time}" pattern="yyyy-MM-dd HH:mm"/>"
									   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
								<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="control-group">
							沟通方式：
							<form:select path="communicationMode" class="input-medium required">
								<form:option value="" label="------请选择------"/>
								<form:options items="${erp:communicationModeStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
							</form:select>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</td>
					<td>
						<div class="control-group">
							签约意向：
							<form:select path="signingIntention" class="input-medium required">
								<form:option value="" label="------请选择------"/>
								<form:options items="${erp:signingIntentionStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
							</form:select>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2">

							沟通主题：<input type="text" name="theme" class="input-xlarge required">
							<span class="help-inline"><font color="red">*</font> </span>
						<div class="control-group">
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<div class="control-group">
							沟通内容：<textarea name="content" class="required" style="width: 60%;height: 50%"></textarea>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<div class="control-group">
							下次沟通安排:
							<input type="radio" name="nextCommunicationArrangement" checked value="0">有
							<input type="radio" name="nextCommunicationArrangement" value="1">无
						</div>
					</td>
				</tr>
				<tr name="nextCommunication">
					<td>
						<div class="control-group">
							下次沟通方式：
							<form:select path="nextCommunicationMode" class="nextCommunicationModeRequired input-medium">
								<form:option value="" label="------请选择------"/>
								<form:options items="${erp:communicationModeStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
							</form:select>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</td>
					<td>
						<div class="control-group">
							下次沟通时间：
							<input name="nextCommunicationTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate nextCommunicationTimeRequired"
								   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</td>
				</tr>
			</table>
			<div class="form-actions">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
				<input name="closeWindows" class="btn" type="button" value="关闭"/>
			</div>
		</c:if>
		<c:if test="${!empty result}">
			<div class="form-actions">
				<c:choose>
					<c:when test="${result == 'success'}">
						<div id="messageBox" class="alert alert-success"><button data-dismiss="alert" class="close">×</button>添加沟通记录成功</div>
					</c:when>
					<c:otherwise>
						<div id="messageBox" class="alert alert-success"><button data-dismiss="alert" class="close">×</button>添加沟通记录失败</div>
					</c:otherwise>
				</c:choose>

				<input name="closeWindows" class="btn" type="button" value="关 闭"/>
			</div>
		</c:if>
	</form:form>
	<sys:message content="${message}"/>
</body>
</html>