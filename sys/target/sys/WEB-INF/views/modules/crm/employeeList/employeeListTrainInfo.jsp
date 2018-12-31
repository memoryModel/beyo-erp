<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>单表管理</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(document).ready(function() {

        });
        function page(n,s){
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#searchForm").submit();
            return false;
        }
    </script>
</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a href="${ctx}/erp/employeeGrade/">员工升降级列表</a></li>
</ul></div><br/><div>
    <ul class="nav nav-tabs">
        <li><a href="${ctx}/erp/employeeGrade/getEmployeeInfo?id=${employee.id}">详细信息</a></li>
        <li><a href="${ctx}/erp/employeeGrade/getEmployeeExperienceInfo?id=${employee.id}">资历信息</a></li>
        <li><a href="${ctx}/erp/employeeGrade/getEmployeeAuthenticationInfo?id=${employee.id}">认证信息</a></li>
        <li class="active"><a href="${ctx}/erp/employeeGrade/getEmployeeTrainInfo?id=${employee.id}">培训信息</a></li>
        <li><a href="#">派工记录</a></li>
        <li><a href="#">投诉退费记录</a></li>
    </ul></div><br/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <thead>
    <tr>
        <th>入班日期</th>
        <th>班级名称</th>
        <th>课程</th>
        <th>价格</th>
        <th>班主任</th>
        <th>计划开班日期</th>
        <th>实际开班日期</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${classList}" var="schoolClass">
        <tr>
            <td>
                <fmt:formatDate value="${schoolClass.realBeginTime}" pattern="yyyy-MM-dd HH:mm"/>
            </td>
            <td>
                    ${schoolClass.className}
            </td>
            <td>
                    ${schoolClass.lessonNames}
            </td>
            <td>
                ${schoolClass.tuitionAmount}
            </td>
            <td>
                    ${schoolClass.headteacher.name}
            </td>
            <td>
                <fmt:formatDate value="${schoolClass.planBeginTime}" pattern="yyyy-MM-dd HH:mm"/>
            </td>
            <td>
                <fmt:formatDate value="${schoolClass.realBeginTime}" pattern="yyyy-MM-dd HH:mm"/>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</body>
</html>