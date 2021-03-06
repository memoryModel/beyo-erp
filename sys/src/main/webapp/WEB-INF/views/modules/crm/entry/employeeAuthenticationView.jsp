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
    <li ><shiro:hasPermission name="crm:entry:info"><a href="${ctx}/crm/entry/info?id=${entryId}" >详细信息</a></shiro:hasPermission></li>
    <li class="active"><shiro:hasPermission name="erp:employeeResume:experienceInfo"><a href="${ctx}/erp/employeeResume/view?employeeId=${employeeResume.employee.id}&entryId=${entryId}">资历信息</a></shiro:hasPermission></li>
    <li><shiro:hasPermission name="erp:employeeInfo:getEmployeeExperienceInfo"><a href="${ctx}/erp/employeeResume/viewSchool?employeeId=${employeeResume.employee.id}&entryId=${entryId}" >培训信息</a></shiro:hasPermission></li>
</ul>
<form:form id="inputForm" modelAttribute="employeeResume" action="${ctx}/erp/employeeResume/save" method="post" class="form-horizontal">
    <form:hidden path="id"/>
    <sys:message content="${message}"/>
    <div class="control-group">

        <table id="contentTable2" class="table table-striped table-bordered table-condensed" style="width: 70%">
            <thead>
            <tr>
                <th>起始日期</th>
                <th>学校名称</th>
                <th>培训课程</th>
                <th>课程描述</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${employeeResumeList}" var="employeeResume">
                <tr>
                    <td>
                        <fmt:formatDate value="${employeeResume.courseStartTime}" pattern="yyyy/MM"/>-<fmt:formatDate value="${employeeResume.courseEndTime}" pattern="yyyy/MM"/>
                    </td>
                    <td>
                            ${employeeResume.organization}
                    </td>
                    <td>
                            ${employeeResume.course}
                    </td>
                    <td>
                            ${employeeResume.courseRemark}
                    </td>
                    <td>
                        <shiro:hasPermission name="erp:employeeResume:list">
                            <a href="${ctx}/erp/employeeResume/info?id=${employeeResume.id}">查看</a>
                        </shiro:hasPermission>
                        <shiro:hasPermission name="erp:employeeResume:form">
                            <a href="${ctx}/erp/employeeResume/form?id=${employeeResume.id}">修改</a>
                        </shiro:hasPermission>
                        <shiro:hasPermission name="erp:employeeResume:delete">
                            <a href="${ctx}/erp/employeeResume/delete?id=${employeeResume.id}">删除</a>
                        </shiro:hasPermission>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <br/><br/>
</form:form>


</body>
</html>