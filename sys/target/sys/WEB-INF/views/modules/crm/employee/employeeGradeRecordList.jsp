<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>员工升降级审批管理</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(document).ready(function() {
            $('a[name="view"]').each(function(){
                var id = $(this).attr("id");
                $(this).click(function () {
                    top.$.jBox("iframe:/crm/interviewRecord/info?id="+id,{
                        title:"升降级",
                        width:1100,
                        height:600,
                        buttons:{},
                        closed:function () {
                            document.location.reload();
                        }
                    });
                });
            });

        });
    </script>
</head>
<body>
<ul class="nav nav-tabs">
    <li><a href="${ctx}/erp/employee/view?id=${employee.id}">基本信息</a></li>
    <li><a href="${ctx}/erp/employee/findEmployeeAppointRecordList?id=${employee.id}">指派记录</a></li>
    <li><a href="${ctx}/erp/employee/findCommunicateHistoryList?id=${employee.id}">沟通记录</a></li>
    <li><a href="${ctx}/erp/employee/findInterviewRecordList?id=${employee.id}">面试记录</a></li>
    <li class="active"><a href="${ctx}/erp/employee/findEmployeeGradeRecordList?id=${employee.id}">定级记录</a></li>
    <li><a href="#">服务技能</a></li>
    <li><a href="#">签约记录</a></li>
</ul>
<sys:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <thead>
    <tr>
        <th>服务技能</th>
        <th>定级生效时间</th>
        <th>系统测试定级</th>
        <th>人工定级</th>
        <th>员工服务结算单价</th>
        <th>定级操作人</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${list}" var="employeeGrade">
        <tr>
            <td>
                    ${employeeGrade.skill.skillName}
            </td>
            <td>
                <fmt:formatDate value="${employeeGrade.entryTime}" pattern="yyyy-MM-dd HH:mm"/>
            </td>
            <td>

                    ${employeeGrade.systemServiceLevel.name}
            </td>
            <td>
                    ${employeeGrade.serviceLevel.name}
            </td>
            <td>
                    ${employeeGrade.servicePrice}
            </td>
            <td>
                    ${employeeGrade.skillUser.name}
            </td>
            <td>
                <a name="view" href="javascript:;" id="${interviewRecord.id}">查看</a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<input id="btnCancel" class="btn btn-primary" type="button" value="返 回" onclick="history.go(-1)">
</body>
</html>