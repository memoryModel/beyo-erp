<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>入职签约管理</title>
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
                }
            });
        });
        function saveEmployeeResume() {
            $.ajax({
                type:'post',
                url:'${ctx}/erp/employeeResume/saveEmployeeResume',
                async:false,
                data:{"employeeResumeId":$("#id").val(),"employeeId":$("#employeeId").val(),"companyTitle":$("#companyTitle").val(),"title":$("#title").val(),"type":$("#type").val(),
                    "startTime":$("#startTime").val(),"endTime":$("#endTime").val(),"remarks":$("#remarks").val(),"status":$("#status").val()},
                success:function(data){
                    if (data && data.result == "success") {
                        location.href="${ctx}/erp/employeeResume/";
                        window.location.reload();
                    } else {
                        window.location.reload();
                    }
                }
            })
        }


    </script>
</head>
<body>
    <ul class="nav nav-tabs">
<%--
        <li><shiro:hasPermission name="crm:entry:list"><a href="${ctx}/crm/entry/list">入职签约管理</a></shiro:hasPermission></li>
--%>
        <li ><shiro:hasPermission name="crm:entry:info"><a href="${ctx}/crm/employeeEntry/info?id=${entryId}">详细信息</a></shiro:hasPermission></li>
        <li class="active"><shiro:hasPermission name="erp:employeeResume:experienceInfo"><a href="${ctx}/erp/employeeResume/experienceInfo?employeeId=${employeeResume.employee.id}&entryId=${entryId}">资历信息</a></shiro:hasPermission></li>
        <li><shiro:hasPermission name="erp:employeeInfo:getEmployeeExperienceInfo"><a href="${ctx}/erp/employeeInfo/getEmployeeExperienceInfo?employeeId=${employeeResume.employee.id}&entryId=${entryId}">认证信息</a></shiro:hasPermission></li>

    </ul>
    <form:form id="inputForm" modelAttribute="employeeResume" action="${ctx}/erp/employeeResume/save" method="post" class="form-horizontal">
        <form:hidden path="id"/>
        <sys:message content="${message}"/>
        <div class="control-group" >
            <div class="controls">
                <form:hidden path="employee.id" id="employeeId" htmlEscape="false" maxlength="64" class="input-xlarge " readonly="true"/>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">公司名称：</label>
            <div class="controls">
                <form:input path="companyTitle" id="companyTitle" htmlEscape="false" maxlength="200" class="required input-large " style="width:210px;"/>
                <span class="help-inline"><font color="red">*</font> </span>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">职位名称：</label>
            <div class="controls">
                <form:input path="title" id="title" htmlEscape="false" maxlength="200" class="required input-large " style="width:210px;"/>
                <span class="help-inline"><font color="red">*</font> </span>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">类型：</label>
            <div class="controls">
                <form:select path="type" id="type" class="input-large " style="width:220px;">
                    <form:options items="${erp:resumeStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false" />
                </form:select>
                <span class="help-inline"><font color="red">*</font> </span>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">开始时间：</label>
            <div class="controls">
                <input name="startTime" id="startTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate " style="width:210px;"
                       value="<fmt:formatDate value="${employeeResume.startTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
                       onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
                <span class="help-inline"><font color="red">*</font> </span>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">结束时间：</label>
            <div class="controls">
                <input name="endTime" id="endTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate " style="width:210px;"
                       value="<fmt:formatDate value="${employeeResume.endTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
                       onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
                <span class="help-inline"><font color="red">*</font> </span>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">备注：</label>
            <div class="controls">
                <form:textarea path="remarks" id="remarks" htmlEscape="false" rows="4" maxlength="200" class="required input-large " style="width:350px;"/>
                <span class="help-inline"><font color="red">*</font> </span>
            </div>
        </div>
        <div class="form-actions">
            <shiro:hasPermission name="erp:employeeResume:save"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存" />&nbsp;</shiro:hasPermission>
            <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
        </div>
        <div class="control-group">
            <label class="control-label"></label>
            <div class="controls">
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">简历信息：</label>
            <div class="controls">

                <table id="contentTable2" class="table table-striped table-bordered table-condensed" style="width: 70%">
                    <thead>
                    <tr>
                        <th>类型</th>
                        <th>时间</th>
                        <th>培训学校名称 / 公司名称</th>
                        <th>班级 / 职位</th>
                        <th>描述</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${employeeResumeList}" var="employeeResume">
                        <tr>
                            <td>
                                    ${erp:resumeStatusName(employeeResume.type)}
                            </td>
                            <td>
                                <fmt:formatDate value="${employeeResume.startTime}" pattern="yyyy/MM"/>-<fmt:formatDate value="${employeeResume.endTime}" pattern="yyyy/MM"/>
                            </td>
                            <td>
                                    ${employeeResume.companyTitle}
                            </td>
                            <td>
                                    ${employeeResume.title}
                            </td>
                            <td>
                                    ${employeeResume.remarks}
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

    <br/><br/>
</form:form>


</body>
</html>