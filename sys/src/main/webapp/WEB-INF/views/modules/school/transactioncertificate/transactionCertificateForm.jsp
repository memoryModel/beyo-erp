<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>单表管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
        $(function () {
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

            <c:if test="${transactionCertificate.classStudents.id == null}">
            $("#div1").attr("style","float:left;");
            </c:if>
            <c:if test="${transactionCertificate.classStudents.id != null}">
            $("#div1").attr("class","control-group");
            </c:if>

            var jbox;
            $("#selectStudent").click(function () {
                top.$.jBox("iframe:/school/transactionCertificate/selectStudent",{
                    title:"办理证书学员",
                    width:900,
                    height:550,
                    buttons:{}
                });
            });

            var educationJsonArray = ${fns:toJson(educationList)};

        })

        //获取到复选框选中id传到后台
        function checkboxExamination(){
            var arr = $("input[type='radio']:checked");
            var arrays = '';
            for (var i = 0; i<arr.length; i++){
                if (arr[i].checked == true){
                    if(i<arr.length-1){
                        arrays = arrays + arr[i].value+',';
                    }else{
                        arrays = arrays + arr[i].value;
                    }

                }
            }

            $('input[type="hidden"][name="arrays"]').val(arrays);
        }


	</script>
</head>
<body>

<ul class="nav nav-tabs">
	<li><a href="${ctx}/school/transactionCertificate/list">证书列表</a></li>
	<li class="active"><a href="${ctx}/school/transactionCertificate/form?id=${transactionCertificate.id}"><shiro:hasPermission name="school:transactionCertificate:form">${not empty transactionCertificate.id?'修改':'新增办理记录'}</shiro:hasPermission><shiro:lacksPermission name="school:transactionCertificate:form">查看</shiro:lacksPermission></a></li>
</ul><br/>

<form:form id="inputForm" modelAttribute="transactionCertificate" action="${ctx}/school/transactionCertificate/save" onclick="checkboxExamination()" method="post" class="form-horizontal">
	<input type="hidden" name="classStudents.id" id="classStudentsId" value="${transactionCertificate.classStudents.id}">
	<input type="hidden" name="id" value="${transactionCertificate.id}">
	<input type="hidden" name="classStudents.student.id" id="schoolStudentId" value="${transactionCertificate.classStudents.student.id}">
	<input type="hidden" name="classStudents.schoolClass.id" id="schoolClassId" value="${transactionCertificate.classStudents.schoolClass.id}">
	<input type="hidden" value="${transactionCertificate.classStudents.student.sex}" id="studentSex" >
	<input type="hidden" name="arrays">
	<sys:message content="${message}"/>

	<table>
		<tr>
			<div >
				<div id="div1">
					<label class="control-label">学员姓名：</label>
					<div class="controls">
						<form:input  path="classStudents.student.name" id="studentName" readonly="true" htmlEscape="false" class="required" style="width: 200px"/>
						<span class="help-inline"><font color="red">*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font> </span>
					</div>
				</div>
				<c:if test="${transactionCertificate.classStudents.id == null}">
					<div class="control-group"  >
						<input type="hidden" name="classStudents.id" id="studentId" value="${classStudents.id}">
						<input id="selectStudent" class="btn btn-primary" type="button" value="选择学员"/>

					</div>
				</c:if>
			</div>
		</tr>

		<tr>
			<div class="control-group">
				<label class="control-label">班级：</label>
				<div class="controls">
					<form:input  path="classStudents.schoolClass.className" id="className" readonly = "true" htmlEscape="false" class="required" style="width: 200px"/>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
		</tr>

		<tr>
			<div class="control-group">
				<label class="control-label">学号：</label>
				<div class="controls">
					<form:input  path="classStudents.student.studentNumber" id="studentNumber" readonly = "true" htmlEscape="false" class="required" style="width: 200px"/>
				</div>
			</div>
		</tr>
		<tr>
			<div class="control-group">
				<label class="control-label">性别：</label>
				<div class="controls">
					<span id="sex">${transactionCertificate.classStudents.student.sex==1?"男":""}${transactionCertificate.classStudents.student.sex==2?"女":""}</span>
				</div>
			</div>
		</tr>

		<tr>
			<div class="control-group">
				<label class="control-label">手机号：</label>
				<div class="controls">
					<form:input  path="classStudents.student.phone" id="phone" readonly = "true" htmlEscape="false" class="required" style="width: 200px"/>
				</div>
			</div>
		</tr>

		<tr>
			<div class="control-group">
				<label class="control-label">证书列表：</label>
				<div class="controls">
					<c:forEach items="${educationList}" var="result">
						<span checkSpan><input name="ckeckboxName" type="radio" value="${result.id}">${result.certificateName}</span>
					</c:forEach>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
		</tr>
		<tr>
			<div class="control-group">
				<label class="control-label">经办人：</label>
				<div class="controls">
					<input type="hidden" value="${transactionCertificate.user.id}"/>
					<sys:treeselect id="user" name="user.id" value="${transactionCertificate.user.id}" labelName="transactionCertificate.user.name" labelValue="${transactionCertificate.user.name}"
									title="证书办理人" url="/sys/office/treeData?type=3" cssClass="required" allowClear="true" notAllowSelectParent="true" />
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">办理时间：</label>
				<div class="controls">
					<input name="createTime" type="text" readonly="readonly" maxlength="20" class="required input-medium Wdate " style="width: 195px"
						   value="<fmt:formatDate value="${transactionCertificate.createTime}" pattern="yyyy-MM-dd HH:mm"/>"
						   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});"/>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
		</tr>
		<tr>
			<div class="form-actions">
				<shiro:hasPermission name="school:transactionCertificate:save"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
				<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
			</div>
		</tr>
	</table>
</form:form>

<script>
    //回显数据
    function selectStudentback(id,name,studentNumber,sex,phone,className,schoolStudentId,schoolClassId,transactionCertificateJsonArray) {
        $("#classStudentsId").val(id);
        $("#studentName").val(name);
        $("#className").val(className);
        $("#studentNumber").val(studentNumber);
        $("#sex").text(sex);
        $("#phone").val(phone);
        $("#className").val(className);
        $("#schoolStudentId").val(schoolStudentId);
        $("#schoolClassId").val(schoolClassId);
        console.log(transactionCertificateJsonArray);

        for(var i=0;i<transactionCertificateJsonArray.length;i++){
            $('input[name="ckeckboxName"][type="radio"][value='+transactionCertificateJsonArray[i].transactionCertificateId+']').parent().hide();
        }

    }
</script>
</body>
</html>