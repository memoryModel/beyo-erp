<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>入职签约审批</title>
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
    </script>
</head>
<body>

    <ul class="nav nav-tabs">
        <li><shiro:hasPermission name="crm:entryApprove:list"><a href="${ctx}/crm/entryApprove/list/">员工入职审批列表</a></shiro:hasPermission></li>
        <li ><shiro:hasPermission name="crm:entryApprove:getEmployeeInfo"><a href="${ctx}/crm/entryApprove/getEmployeeInfo?employeeId=${entry.employee.id}&&id=${entry.id}">员工入职签约审批</a></shiro:hasPermission></li>
        <li class="active"><shiro:hasPermission name="crm:entryApprove:getEmployeeExperienceInfo"><a href="${ctx}/crm/entryApprove/getEmployeeExperienceInfo?employeeId=${entry.employee.id}&&id=${entry.id}">资历信息</a></shiro:hasPermission></li>
        <li><shiro:hasPermission name="crm:entryApprove:getEmployeeAuthenticationInfo"><a href="${ctx}/crm/entryApprove/getEmployeeAuthenticationInfo?employeeId=${entry.employee.id}&&id=${entry.id}">认证信息</a></shiro:hasPermission></li>
    </ul></div><br/>
<form:form modelAttribute="entry">


    <div class="alert alert-info">工作经验</div>

    <table id="contentTable" class="table table-striped table-bordered table-condensed">
             <thead>
             <tr>
                 <th>时间</th>
                 <th>公司名称</th>
                 <th>职位</th>
                 <th>工作描述</th>
             </tr>
             </thead>
             <tbody>
             <c:forEach items="${employeeResumeList}" var="employeeResume">
                 <c:if test="${employeeResume.type == 1}">
                     <tr>
                         <td>
                             <fmt:formatDate value="${employeeResume.startTime}" pattern="yyyy/MM"/>-<fmt:formatDate value="${employeeResume.startTime}" pattern="yyyy/MM"/>
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
                 </c:if>
             </c:forEach>
             </tbody>
         </table>
    <div class="alert alert-info">培训学校</div>
    <table id="contentTable2" class="table table-striped table-bordered table-condensed">
        <thead>
        <tr>
            <th>时间</th>
            <th>培训学校名称</th>
            <th>班级</th>
            <th>课程描述</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${employeeResumeTrainList}" var="employeeResume">
            <c:if test="${employeeResume.type == 2}">
                <tr>
                    <td>
                        <fmt:formatDate value="${employeeResume.startTime}" pattern="yyyy/MM"/>-<fmt:formatDate value="${employeeResume.startTime}" pattern="yyyy/MM"/>
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
            </c:if>
        </c:forEach>
        </tbody>
    </table>
</form:form>

</body>
</html>