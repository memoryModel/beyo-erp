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

        $(document).ready(function() {
            $(document).find("a[name='employeeResumeForm']").each(function () {
                var id = $(this).attr("id");
                $(this).click(function () {
                    top.$.jBox("iframe:/erp/employeeResume/form?id="+id,
                        {
                            title:"添加",
                            width:900,
                            height:550,
                            buttons:{}
                        }
                    );
                });
            });
        });

    </script>
</head>
<body>
    <ul class="nav nav-tabs">
        <li ><shiro:hasPermission name="crm:entry:info"><a href="${ctx}/crm/entry/info?id=${entryId}">详细信息</a></shiro:hasPermission></li>
        <li class="active"><shiro:hasPermission name="erp:employeeResume:experienceInfo"><a href="${ctx}/erp/employeeResume/experienceInfo?employeeId=${employeeResume.employee.id}&entryId=${entryId}">资历信息</a></shiro:hasPermission></li>
        <li><shiro:hasPermission name="erp:employeeInfo:getEmployeeExperienceInfo"><a href="${ctx}/erp/employeeInfo/getEmployeeExperienceInfo?employeeId=${employeeResume.employee.id}&entryId=${entryId}">培训信息</a></shiro:hasPermission></li>
    </ul>
    <shiro:hasPermission name="erp:employeeResume:list">
        <a name="employeeResumeForm" id="${employeeResume.id}" href="javascript:;">新增</a>
    </shiro:hasPermission>
    <table id="contentTable2" class="table table-striped table-bordered table-condensed" style="width: 70%">
                    <thead>
                    <tr>
                        <th>起始日期</th>
                        <th>公司名称</th>
                        <th>部门</th>
                        <th>岗位</th>
                        <th>工作描述</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${employeeResumeList}" var="employeeResume">
                        <tr>
                            <td>
                                <fmt:formatDate value="${employeeResume.startTime}" pattern="yyyy/MM"/>-<fmt:formatDate value="${employeeResume.endTime}" pattern="yyyy/MM"/>
                            </td>
                            <td>
                                    ${employeeResume.companyTitle}
                            </td>

                            <td>
                                    ${employeeResume.department}
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
</body>
</html>