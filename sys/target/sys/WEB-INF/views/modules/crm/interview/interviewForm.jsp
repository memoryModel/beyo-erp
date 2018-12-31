<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>面试管理管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">

        $(document).ready(function() {
            $.validator.addMethod("checkTime",function (value, element) {

                var interviewTime = $("#interviewTime").val();
                if(!interviewTime)return true;

                var interviewDate = new Date(interviewTime);
                if(interviewDate.getTime()>(new Date()).getTime()){
                    return false;
                }

                return true;
            },"面试时间不能超过当前时间!");

            $("#inputForm").validate({
                submitHandler: function(form){
                    loading('正在提交，请稍等...');
                    form.submit();
                },
                errorContainer: "#messageBox",
                errorPlacement: function(error, element) {
                    $("#messageBox").text("输入有误，请先更正。");
                    if (element.is(":checkbox")||element.is(":radio")){
                        error.appendTo(element.parent().parent());
                    }else if(element.parent().is(".input-append")){
                        $(error).text("必填信息");
                        element.parents(".controls").append(error);
                    } else {
                        error.insertAfter(element);
                    }
                }
            });
            load();
        });

        function load(){
            var value = ${tagFlag};
			var a = 0;
            if(value == a){
                $("#planInterviewTime").attr("disabled",true);
                $("#createTime").attr("disabled",true);
                $("#remark").attr("readonly",true);
            }
        }

        function selectEmployeeCallback(trHtml,selectFlag){
			var id = $(trHtml).attr('id');
			if(selectFlag == '选择'){

                $('table').append(trHtml);
                $('table').find('tr[id='+id+']').find('input[type="button"]').bind("click",function () {
                    $(this).parent().parent().remove();
                })
			}
			if(selectFlag == '取消选择'){
                $('table').find('tr[id='+id+']').remove();
			}

        }

        function submitForm() {
            var employeeIds = ''
			var trHtmls = $('table').find('tr:gt(0)');
        	for (var i=0;i<trHtmls.length;i++){
                if(i==trHtmls.length-1){
                    employeeIds = employeeIds + $(trHtmls[i]).attr('id');
                }else{
                    employeeIds = employeeIds + $(trHtmls[i]).attr('id')+",";
                }
			}
			$('#inputForm').append('<input type="hidden" name="employeeIds" value='+employeeIds+'>');
			$('#inputForm').submit();

        }



	</script>
</head>
<body>

	<ul class="nav nav-tabs">
		<c:if test="${tagFlag == 1}">
			<li  class="active"><a href="${ctx}/crm/interview/form?id=${interview.id}">面试管理<shiro:hasPermission name="crm:interview:form">${not empty interview.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="crm:interview:form">查看</shiro:lacksPermission></a></li>
		</c:if>
	</ul><br/>


	<form:form id="inputForm" modelAttribute="interview" action="${ctx}/crm/interview/save" method="post" class="form-horizontal">
		<input type="hidden" name="employee.id" id="employeeId" value="${interview.employee.id}">
		<input type="hidden" name="id" value="${interview.id}">
		<sys:message content="${message}"/>
		<div class="control-group" style="float:left;">
			<label class="control-label"><font color="red">*</font>&nbsp;&nbsp;计划面试时间：</label>
			<div class="controls">
				<input id="planInterviewTime" name="planInterviewTime" type="text" maxlength="20" class="required input-medium Wdate checkTime" style="width: 205px;"
					   value="<fmt:formatDate value="${interview.planInterviewTime}" pattern="yyyy-MM-dd HH:mm"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});"/>
			</div>
		</div>

		<c:if test="${tagFlag == 1}">
			<div class="control-group">
				<label class="control-label"><font color="red">*</font>&nbsp;&nbsp;面试人：</label>
				<div class="controls">
					<sys:treeselect id="interviewers" name="interviewers.id" value="${interview.interviewers.id}"
									labelName="interviewers.name" labelValue="${interview.interviewers.name}"
									title="选择用户" url="/sys/office/treeData?type=3" notAllowSelectParent="true"/>
				</div>
			</div>
		</c:if>

		<c:if test="${tagFlag == 0}">
			<div class="control-group">
				<label class="control-label"><font color="red">*</font>&nbsp;&nbsp;面试人：</label>
				<div class="controls">
					<input type="text" value="${interview.interviewers.name}" readonly="readonly">
				</div>
			</div>
		</c:if>

		<div class="control-group">
			<label class="control-label"><font color="red">*</font>&nbsp;&nbsp;面试员工：</label>
			<div class="controls">
				<input type="hidden" name="employee.id" id="id" value="${employee.id}">
				<input  type="hidden"   id="name" value="${interview.employee.name}"  class="input-large" readonly="true"   placeholder="点击选择添加员工" />
				<c:if test="${empty interview.id}">
					<input id="selectEmployee" class="btn btn-primary" type="button"  value="选择面试员工"/>
				</c:if>
			</div>
		</div>

		<div class="control-group" style="text-align:center;">
			<table class="table table-striped table-bordered table-condensed" style="width: 80%; text-align:center; margin:auto" border="1" cellpadding="2" cellspacing="1">
				<tr>
					<th>姓名</th>
					<th>性别</th>
					<th>手机号码</th>
					<th>工种</th>
					<th>来源</th>
					<c:if test="${interview.id == null}"><th>操作</th></c:if>
				</tr>

				<c:if test="${interview.id != null}">
					<tr>
						<td>${interview.employee.name}</td>
						<td>${erp:sexStatusName(interview.employee.sex)}</td>
						<td>${interview.employee.phone}</td>
						<td>
							<c:forEach items="${interview.employee.getProfessionList()}" var="occId" varStatus="length">
								<c:if test="${length.index!=0}">
									,
								</c:if>
								${erp:getCommonsTypeName(occId)}
							</c:forEach>
						</td>
						<td>${interview.customerResource.customerName}</td>
					</tr>
				</c:if>
			</table>
		</div>

		<c:if test="${tagFlag == 0}">
			<div class="control-group" style="float:left;">
				<label class="control-label"><font color="red">*</font>&nbsp;&nbsp;计划状态：</label>
				<div class="controls">
					<input type="text" value="${erp:interviewPlanName(interview.interviewStatus)}" readonly="readonly">
				</div>
			</div>

			<div class="control-group">
				<label class="control-label"><font color="red">*</font>&nbsp;&nbsp;预约面试时间：</label>
				<div class="controls">
					<input name="appointInterviewTime" disabled="disabled" type="text" maxlength="20" readonly="true" class="required input-medium Wdate checkTime" style="width: 205px;"
						   value="<fmt:formatDate value="${interview.appointInterviewTime}" pattern="yyyy-MM-dd HH:mm"/>"
						   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});"/>
				</div>
			</div>

		</c:if>
		<div class="control-group">
			<label class="control-label">备注信息：</label>
			<div class="controls">
				<form:textarea id="remark" path="remark" htmlEscape="false" maxlength="200" class="input-xlarge " rows="3" style="width: 620px;"/>
			</div>
		</div>

		<c:if test="${tagFlag == 0}">
			<div class="control-group" style="float:left;">
				<label class="control-label"><font color="red">*</font>&nbsp;&nbsp;添加人：</label>
				<div class="controls">
					<input type="text" value="${interview.addPlanUser.name}" readonly="readonly">
				</div>
			</div>
		</c:if>

		<c:if test="${tagFlag == 1}">
			<div class="control-group" style="float:left;">
				<label class="control-label"><font color="red">*</font>&nbsp;&nbsp;添加人：</label>
				<div class="controls">
					<sys:treeselect id="addPlanUser" name="addPlanUser.id" value="${interview.addPlanUser.id}"
									labelName="addPlanUser.name" labelValue="${interview.addPlanUser.name}"
									title="选择用户" url="/sys/office/treeData?type=3" notAllowSelectParent="true"/>
				</div>
			</div>
		</c:if>

		<div class="control-group">
			<label class="control-label"><font color="red">*</font>&nbsp;&nbsp;添加时间：</label>
			<div class="controls">
				<input id="createTime" name="createTime" type="text" maxlength="20" readonly="true" class="required input-medium Wdate checkTime" style="width: 205px;"
					   value="<fmt:formatDate value="${interview.createTime}" pattern="yyyy-MM-dd HH:mm"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});"/>
			</div>
		</div>

		<c:if test="${tagFlag == 1}">
			<div class="form-actions">
				<shiro:hasPermission name="crm:interview:save"><input id="btnSubmit" class="btn btn-primary" type="button" onclick="submitForm()" value="保 存"/>&nbsp;</shiro:hasPermission>
				<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
			</div>
		</c:if>

	</form:form>
	<script type="text/javascript">
		$("#selectEmployee").click(function () {
			var employeeIds = ''
            var trHtmls = $('table').find('tr:gt(0)');
            for (var i=0;i<trHtmls.length;i++){
                if(i<trHtmls.length-1){
                    employeeIds = employeeIds + $(trHtmls[i]).attr('id')+",";
                }else{
                    employeeIds = employeeIds + $(trHtmls[i]).attr('id');
                }
            }
			top.$.jBox("iframe:/crm/interview/selectEmployee?ids="+employeeIds, {
			 title:"添加员工",
			 width:1024,
			 height:520,
			 buttons:{}
			 });
		});
	</script>

</body>
</html>
