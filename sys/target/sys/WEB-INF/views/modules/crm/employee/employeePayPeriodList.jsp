<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>招工管理</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(document).ready(function() {
            $(document).find("a[name='cancelForm']").each(function () {
                var rid = $(this).attr("rid");
                $(this).click(function () {
                    top.$.jBox("iframe:/crm/employeePayPeriod/cancel?id="+rid,{
                        title:"设置失效时间",
                        width:500,
                        height:550,
                        buttons:{},
                        closed:function () {
                            document.location.href="/crm/employeePayPeriod/list";
                        }
                    });
                });
            });
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
    <li class="active"><a href="${ctx}/crm/employeePayPeriod/list">工资账期设置</a></li>
    <shiro:hasPermission name="crm:employeePayPeriod:form"><li><a href="${ctx}/crm/employeePayPeriod/form">工资账期添加</a></li></shiro:hasPermission>

</ul>

<sys:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <thead>
    <tr>
        <th>员工类型</th>
        <th>结算方式</th>
        <th>结算周期</th>
        <th>账单日</th>
        <th>T+N</th>
        <th>失效时间</th>
        <th>状态</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${list}" var="employeePayPeriod">
        <tr>
            <td>
                ${erp:employeeTypeName(employeePayPeriod.type)}
            </td>
            <td>
                ${erp:employeePayTypeName(employeePayPeriod.payType)}
            </td>
            <td>
                <c:if test="${employeePayPeriod.startMonth==0}">本月</c:if>
                <c:if test="${employeePayPeriod.startMonth==-1}">上月</c:if>
                ${employeePayPeriod.startDay}&nbsp;日
                &nbsp;&nbsp;至&nbsp;&nbsp;
                <c:if test="${employeePayPeriod.endMonth==0}">本月</c:if>
                <c:if test="${employeePayPeriod.endMonth==-1}">上月</c:if>
                ${employeePayPeriod.endDay}&nbsp;日
            </td>
            <td>
                ${employeePayPeriod.payDay}&nbsp;日
            </td>
            <td>${employeePayPeriod.plusDay}</td>
            <td>
                <fmt:formatDate value="${employeePayPeriod.invalidTime}" pattern="yyyy-MM-dd"/>
            </td>
            <td>${erp:commonsStatusName(employeePayPeriod.status)}</td>
           <td>
               <shiro:hasPermission name="crm:employeePayPeriod:cancel"> <a name="cancelForm" rid="${employeePayPeriod.id}" href="javascript:;">设置失效时间</a></shiro:hasPermission>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</body>
</html>