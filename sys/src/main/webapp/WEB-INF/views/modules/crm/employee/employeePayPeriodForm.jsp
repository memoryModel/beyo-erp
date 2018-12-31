<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>员工管理</title>
    <meta name="decorator" content="default"/>
</head>
<body>

<ul class="nav nav-tabs">
    <li ><a href="${ctx}/crm/employeePayPeriod/list">工资账期设置</a></li>
    <shiro:hasPermission name="crm:employeePayPeriod:form"><li class="active"><a href="${ctx}/crm/employeePayPeriod/form">工资账期添加</a></li></shiro:hasPermission>

</ul>
<br>
<form:form id="inputForm" modelAttribute="employeePayPeriod" action="${ctx}/crm/employeePayPeriod/save" method="post" class="form-horizontal">

    <sys:message content="${message}"/>

    <div class="control-group">
        <label class="control-label">员工类型：</label>
        <div class="controls">
            <select name="type" class="input-medium">
                <c:forEach items="${erp:employeeTypeList()}" var="obj" varStatus="index">
                    <option value="${obj.value}">${obj.name}</option>
                </c:forEach>
            </select>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">结算方式：</label>
        <div class="controls">
            <select id="payTypes" name="payType" class="input-medium">
                <c:forEach items="${erp:employeePayTypeList()}" var="obj" varStatus="index">
                    <option value="${obj.value}">${obj.name}</option>
                </c:forEach>
            </select>
        </div>
    </div>
    <div id="pt1" class="control-group">
        <label class="control-label">结算周期：</label>
        <div class="controls">
            <select name="startMonth" class="input-mini">
                <option value="0">本月</option>
                <option value="-1" selected>上月</option>
            </select>
            <select name="startDay" class="input-mini">
                <c:forEach items="${dayList}" var="day">
                    <option value="${day}">${day}日</option>
                </c:forEach>
            </select>
            &nbsp;
            至
            &nbsp;
            <select name="endMonth" class="input-mini">
                <option value="0" selected>本月</option>
                <option value="-1">上月</option>
            </select>
            <select name="endDay" class="input-mini">
                <c:forEach items="${dayList}" var="day">
                    <option value="${day}">${day}日</option>
                </c:forEach>
            </select>
            <br><br>
            每月&nbsp;
            <select name="payDay" class="input-mini">
                <c:forEach items="${dayList}" var="day">
                    <option value="${day}">${day}日</option>
                </c:forEach>
            </select>
            &nbsp;&nbsp;生成结算账单
        </div>
    </div>
    <div id="pt2" class="control-group" style="display: none">
        <label class="control-label">结算日期：</label>
        <div class="controls">
            <input name="plusDay" type="text"  value="" class="input-large required digits" style="width: 50px;text-align: right;" readonly="readonly">
        </div>
    </div>

    <div class="form-actions">
        <shiro:hasPermission name="crm:employeePayPeriod:save">
            <input  class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
        </shiro:hasPermission>
        <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
    </div>
</form:form>

<script type="text/javascript">
    $(document).ready(function() {

        $("#inputForm").validate({
            submitHandler: function(form){
                loading('正在提交，请稍等...');
                form.submit();
            },
            errorContainer: "#messageBox",
            errorPlacement: function(error, element) {
                $("#messageBox").text("输入有误，请先更正。");
                if (element.is(":checkbox")||element.is(":radio")){
                    error.appendTo(element.parent().parent());
                }else if(element.parent().is(".input-append")){
                    $(error).text("必填信息");
                    element.parents(".controls").append(error);
                } else {
                    error.insertAfter(element);
                }
            }
        });

        $("#payTypes").change(function () {
            var payType = $(this).val();

            $("#pt1").hide();
            $("#pt2").hide();
            $("#pt"+payType).show();

        });

    });
</script>
</body>
</html>