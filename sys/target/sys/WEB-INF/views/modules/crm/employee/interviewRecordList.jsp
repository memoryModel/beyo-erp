<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>招工沟通历史记录表管理</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(document).ready(function() {
            $('a[name="view"]').each(function(){
                var id = $(this).attr("id");
                $(this).click(function () {
                    top.$.jBox("iframe:/crm/interviewRecord/info?id="+id,{
                        title:"面试记录详情",
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
    <li class="active"><a href="${ctx}/erp/employee/findInterviewRecordList?id=${employee.id}">面试记录</a></li>
    <li><a href="#">定级记录</a></li>
    <li><a href="#">服务技能</a></li>
    <li><a href="#">签约记录</a></li>
</ul>
<sys:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <thead>
    <tr>
        <th>面试人</th>
        <th>面试时间</th>
        <th>面试结果</th>
        <th>添加人</th>
        <th>添加时间</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${list}" var="interviewRecord">
        <tr>
            <td>
                    ${interviewRecord.interview.interviewers.name}
            </td>
            <td>
                <fmt:formatDate value="${interviewRecord.interviewTime}" pattern="yyyy-MM-dd HH:mm"/>
            </td>
            <td>
                    ${erp:interviewStatusName(interviewRecord.status)}
            </td>
            <td>
                    ${interviewRecord.interview.addPlanUser.name}
            </td>
            <td>
                <fmt:formatDate value="${interviewRecord.createTime}" pattern="yyyy-MM-dd HH:mm"/>
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