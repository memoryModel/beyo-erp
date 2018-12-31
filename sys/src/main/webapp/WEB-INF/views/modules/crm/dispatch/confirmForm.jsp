<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>上户员工管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
console.info(${statusFlag});
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
            });
		});

        /*var currentDay = new Date();
        var currentTime = currentDay.Format("yyyy-MM-dd HH:mm");
        var endDay = new Date(${dispatch.planEndTime});
        //var endDay = new Date(parseInt(${dispatch.planEndTime}) * 1000).toLocaleString().substr(0,16);
        var planEndTime = endDay.Format("yyyy-MM-dd HH:mm");
        var surplusTime = planEndTime.getTime() - currentTime.getTime();
        //var days=Math.floor(surplusTime/(24*3600*1000));
        var leave=surplusTime%(24*3600*1000);    //计算天数后剩余的毫秒数
        var surplushours=Math.floor(leave/(3600*1000));
        alert(${dispatch.planEndTime});
        $("#surplushours").text(surplushours+"小时");*/

        function sub(){
            if(${service==0}){//确认上户
				$("#inputForm").attr("action","${ctx}/crm/dispatch/startDispatchConfirm");
			}
            if(${service==1}){//提前下户
                $("#inputForm").attr("action","${ctx}/crm/dispatch/endDispatchConfirm");
            }
            if(${service==2}){//确认下户
                $("#inputForm").attr("action","${ctx}/crm/dispatch/endDispatchConfirm");
            }
            if(${service==3}){//修改结算时长
                $("#inputForm").attr("action","${ctx}/crm/dispatch/updateServiceTime");
            }
        }
	</script>
</head>
<body>

	<form:form id="inputForm" modelAttribute="dispatch" onsubmit="sub()" method="post" class="form-horizontal">
		<sys:message content="${message}"/>
		<c:if test="${empty result}">

		<form:hidden path="id"/>
		<div class="control-group">
			<label class="control-label">客户：</label>
			<div class="controls">
					${dispatch.customer.name}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">预约项目：</label>
			<div class="controls">
					${dispatch.skill.skillName}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">上户员工：</label>
			<div class="controls">
					${dispatch.dispatchEmployee.employee.name}
					<input type="hidden" name="dispatchEmployee.id" value="${dispatch.dispatchEmployee.id}" />
					<input type="hidden" name="dispatchEmployee.employee.id" value="${dispatch.dispatchEmployee.employee.id}" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">服务时长：</label>
			<div class="controls">
					${dispatch.serviceTime}小时
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">剩余服务时长：</label>
			<div class="controls" id="surplushours">

			</div>
		</div>
		<div class="control-group">
			<label class="control-label">预约上户时间：</label>
			<div class="controls">
					<fmt:formatDate value="${dispatch.planStartTime}" pattern="yyyy-MM-dd HH:mm"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">预计下户时间：</label>
			<div class="controls">
					<fmt:formatDate value="${dispatch.planEndTime}" pattern="MM-dd HH:mm"/>
			</div>
		</div>
		<div class="control-group">
			<c:if test="${service!=3}">
				<label class="control-label">实际${service==0 ? "上户":"下户"}时间：</label>
			</c:if>
			<c:if test="${service==3}">
				<label class="control-label">结算工资时长：</label>
			</c:if>
			<div class="controls">
				<c:if test="${service==2}">
					<input name="statusFlag" type="hidden" value="${service==2 ? 3:""}" maxlength="20" class="input-medium"/>
				</c:if>
				<c:if test="${service==0}">
					<input name="realStartTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
						   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});"/>
				</c:if>
				<c:if test="${service != 0 && service != 3}">
					<input name="realEndTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
						   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});"/>
				</c:if>
				<c:if test="${service == 3}">
					<input name="realServiceTime" type="text" value="${dispatch.serviceTime}" maxlength="20" class="input-medium"/>小时
				</c:if>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="crm:dispatch:save">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
			</shiro:hasPermission>
			<input name="closeWindows" class="btn" type="button" value="关 闭"/>
		</div>

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