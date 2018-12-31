<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>员工升降级管理</title>
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
    <li class="active"><a href="${ctx}/crm/employeeGradeManager/list">员工升降级列表</a></li>
</ul></div><br/><div>
    <ul class="nav nav-tabs">
        <li><a href="${ctx}/crm/employeeGradeManager/getEmployeeInfo?id=${employee.id}">详细信息</a></li>
        <li class="active"><a href="${ctx}/crm/employeeGradeManager/getEmployeeExperienceInfo?id=${employee.id}">资历信息</a></li>
        <li><a href="${ctx}/crm/employeeGradeManager/getEmployeeAuthenticationInfo?id=${employee.id}">认证信息</a></li>
        <li><a href="${ctx}/crm/employeeGradeManager/getEmployeeTrainInfo?id=${employee.id}">培训信息</a></li>
        <%--<li><a href="#">派工记录</a></li>
        <li><a href="#">投诉退费记录</a></li>--%>
    </ul></div><br/>
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


</body>
</html>