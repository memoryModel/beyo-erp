<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>开班计划</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
        $(document).ready(function() {
            //$("#name").focus();
            $("#prepaidAmount").add("#tuitionAmount").add("#miscellaneousAmount").add("#depositAmount").add("#insuranceAmount").keyup(function () {
                var reg = $(this).val().match(/\d+\.?\d{0,2}/);
                var txt = '';
                if(reg != null) {
                    txt = reg[0];
                }
                $(this).val(txt);
            }).change(function () {
                $(this).keypress();
                var v = $(this).val();
                if (/\.$/.test(v)){
                    $(this).val(v.substr(0, v.length - 1));
                }
            });

            amountVerification();

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

            //验证开始时间是否合法
            jQuery.validator.addMethod("stratTimeV", function (value, element) {
                $('label[for="planEndTime"]').html("");
                if(null == $("#planEndTime").val() || undefined == $("#planEndTime").val() || ''== $("#planEndTime").val()){
                    return true;
                }
                var endTime = $("#planEndTime").val();
                var end = new Date(endTime.replace(/\-/g, "\/"));
                var start = new Date(value.replace(/\-/g, "\/"));
                if(end > start) return true;
                return false;
            }, "开始时间应小于结束时间");

            //验证结束时间是否合法
            jQuery.validator.addMethod("endTimeV", function (value, element) {
                $('label[for="planBeginTime"]').html("");
                if(null == $("#planBeginTime").val() || undefined == $("#planBeginTime").val() || ''== $("#planBeginTime").val()){
                    return true;
                }
                var stratTime = $("#planBeginTime").val();
                var start = new Date(stratTime.replace(/\-/g, "\/"));
                var end = new Date(value.replace(/\-/g, "\/"));
                //console.log(d1);
                if(start < end) return true;
                return false;
            }, "结束时间应大于开始时间");


        });

        //验证预定金不能高与学费
        function amountVerification(){
            var prepaidAmount = $('#prepaidAmountId').val();
            var tuitionAmount = $('#tuitionAmountId').val();

            if (parseFloat(prepaidAmount) > parseFloat(tuitionAmount)){
                $('#spanOne').html("<font color='red'>预定金不能高于学费</font>");
                $('#btnSubmit').attr("disabled",true);
            }else if (parseFloat(prepaidAmount) < parseFloat(tuitionAmount)){
                $('#spanOne').html("<font color='red'>*</font>");
                $('#btnSubmit').attr("disabled",false);
            }
        }
	</script>
</head>
<body>
<ul class="nav nav-tabs">
	<li><a href="${ctx}/school/classPlan/list">开班计划列表</a></li>
	<li class="active"><a href="${ctx}/school/classPlan/form?id=${schoolClass.id}">开班计划<shiro:hasPermission name="school:classPlan:form">${not empty schoolClass.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="school:classPlan:form">查看</shiro:lacksPermission></a></li>
</ul><br/>
<form:form id="inputForm" modelAttribute="aClass" action="${ctx}/school/classPlan/save" method="post" onclick="amountVerification();" class="form-horizontal">
	<form:hidden path="id"/>
	<sys:message content="${message}"/>

	<table id="contentTable">
		<tr>
			<td>
				<div class="control-group">
					<label class="control-label">班级名称：</label>
					<div class="controls">
						<form:input path="className" htmlEscape="false" maxlength="512" class="input-xlarge required"/>
						<span class="help-inline"><font color="red">*</font> </span>
					</div>
				</div>
			</td>
			<td>
				<div class="control-group">
					<label class="control-label">班型：</label>
					<div class="controls">
						<form:select path="classType" class="required input-medium">
							<form:option value="" label="--请选择--"/>
							<form:options items="${erp:getCommonsTypeList(50)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
						</form:select>
						<span class="help-inline"><font color="red">*</font> </span>
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class="control-group">
					<label class="control-label">班级最大人数：</label>
					<div class="controls">
						<form:input path="classMaxNum" htmlEscape="false" maxlength="20" class="input-xlarge required digits"/>
						<span class="help-inline"><font color="red">*</font> </span>
					</div>
				</div>
			</td>
			<td>
				<div class="control-group">
					<label class="control-label">班级预计招收人数：</label>
					<div class="controls">
						<form:input path="classMinNum" htmlEscape="false" maxlength="20" class="input-xlarge required digits" style="width: 160px"/>
						<span class="help-inline"><font color="red">*</font> </span>
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class="control-group">
					<label class="control-label">计划开班日期：</label>
					<div class="controls">
						<input name="planBeginTime" id="planBeginTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required stratTimeV valid"
							   value="<fmt:formatDate value="${schoolClass.planBeginTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
							   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true,minDate:'%y-%M-{%d+1}'});"/>
						<span class="help-inline"><font color="red">*</font> </span>
					</div>
				</div>
			</td>
			<td>
				<div class="control-group">
					<label class="control-label">计划结业日期：</label>
					<div class="controls">
						<input name="planEndTime" id="planEndTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required endTimeV valid"
							   value="<fmt:formatDate value="${schoolClass.planEndTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
							   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true,minDate:'%y-%M-{%d+1}'});"/>
						<span class="help-inline"><font color="red">*</font> </span>
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<div class="control-group">
					<label class="control-label">课时：</label>
					<div class="controls">
						<form:input path="classTime" htmlEscape="false" maxlength="20" class="input-xlarge digits required"/>
						<span class="help-inline"><font color="red">*</font> </span>
					</div>
				</div>
			</td>
		</tr>


	</table>




	<div class="control-group">
		<label class="control-label">学费：</label>
		<div class="controls">
			<table id="amountTable" class="table table-striped table-bordered table-condensed">
				<thead>
				<tr>
					<th>预定金(元)</th>
					<th>学费(元)</th>
					<th>学杂费(元)</th>
				</tr>
				</thead>
				<tbody>
				<tr>
					<td>
						<form:input path="prepaidAmount" id="prepaidAmountId" htmlEscape="false" maxlength="20" class="input-xlarge required"/>
						<span id="spanOne" class="help-inline"><font color="red">*</font> </span>
					</td>
					<td>
						<form:input path="tuitionAmount" id="tuitionAmountId" htmlEscape="false" maxlength="20" class="input-xlarge required"/>
						<span class="help-inline"><font color="red">*</font> </span>
					</td>
					<td>
						<form:input path="miscellaneousAmount" htmlEscape="false" maxlength="20" class="input-xlarge required"/>
						<span class="help-inline"><font color="red">*</font> </span>
					</td>
				</tr>
				</tbody>
			</table>
		</div>
	</div>


	<div class="control-group">
		<label class="control-label">备注:</label>
		<div class="controls">
			<form:textarea path="remark"  rows="4" style="width:709px;" maxlength="1000"/>
		</div>
	</div>

	<div hidden="hidden" class="control-group">
		<label class="control-label">状态：</label>
		<div class="controls">
			<form:select path="status" class="input-medium">
				<form:options items="${erp:classPlanStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
			</form:select>
		</div>
	</div>

	<div class="form-actions">
		<shiro:hasPermission name="school:classPlan:save"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
		<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
	</div>
</form:form>
</body>
</html>