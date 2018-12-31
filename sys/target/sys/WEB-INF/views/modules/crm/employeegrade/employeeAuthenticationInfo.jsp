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
        <li><a href="${ctx}/crm/employeeGradeManager/getEmployeeExperienceInfo?id=${employee.id}">资历信息</a></li>
        <li  class="active"><a href="${ctx}/crm/employeeGradeManager/getEmployeeAuthenticationInfo?id=${employee.id}">认证信息</a></li>
        <li><a href="${ctx}/crm/employeeGradeManager/getEmployeeTrainInfo?id=${employee.id}">培训信息</a></li>
       <%-- <li><a href="#">派工记录</a></li>
        <li><a href="#">投诉退费记录</a></li>--%>
    </ul></div><br/>
    <div class="alert alert-info">身份证</div>
            <table style="width: 50%; height: 200px;">
                <tr>
                <c:forEach items="${employeeInfoList}" var="employeeInfo">
                    <c:if test="${employeeInfo.type == 1}">
                            <td><img src='${employeeInfo.url}&iopcmd=thumbnail&type=4&width=100'/></td>
                    </c:if>
                </c:forEach>
                </tr>
            </table>

      <div class="alert alert-info">健康证</div>
               <table style="width: 100%; height: 200px;">
                   <tr>
                       <c:forEach items="${employeeInfoList}" var="employeeInfo">
                           <c:if test="${employeeInfo.type == 2}">
                               <td><img src='${employeeInfo.url}&iopcmd=thumbnail&type=4&width=100'/></td>
                           </c:if>
                       </c:forEach>
                   </tr>
                </table>
     <div class="alert alert-info">职业资格证</div>

             <table style="width: 100%; height: 200px;">
                 <tr>
                     <c:forEach items="${employeeInfoList}" var="employeeInfo">
                         <c:if test="${employeeInfo.type == 3}">
                             <td><img src='${employeeInfo.url}&iopcmd=thumbnail&type=4&width=100'/></td>
                         </c:if>
                     </c:forEach>
                 </tr>
            </table>
    <tr>
        <td></td>
    </tr>


</body>
</html>