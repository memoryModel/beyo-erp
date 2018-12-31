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
    <%--<ul class="nav nav-tabs">
        <li class="active"><a href="${ctx}/crm/entryApprove/list">入职签约审批</a></li>
    </ul></div><br/><div>--%>
    <ul class="nav nav-tabs">
        <li><shiro:hasPermission name="crm:entryApprove:list"><a href="${ctx}/crm/entryApprove/list/">员工入职审批列表</a></shiro:hasPermission></li>
        <li><shiro:hasPermission name="crm:entryApprove:getEmployeeInfo"><a href="${ctx}/crm/entryApprove/getEmployeeInfo?employeeId=${entry.employee.id}&&id=${entry.id}">员工入职签约审批</a></shiro:hasPermission></li>
        <li><shiro:hasPermission name="crm:entryApprove:getEmployeeExperienceInfo"><a href="${ctx}/crm/entryApprove/getEmployeeExperienceInfo?employeeId=${entry.employee.id}&&id=${entry.id}">资历信息</a></shiro:hasPermission></li>
        <li  class="active"><shiro:hasPermission name="crm:entryApprove:getEmployeeAuthenticationInfo"><a href="${ctx}/crm/entryApprove/getEmployeeAuthenticationInfo?employeeId=${entry.employee.id}&&id=${entry.id}">认证信息</a></shiro:hasPermission></li>
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



</body>
</html>