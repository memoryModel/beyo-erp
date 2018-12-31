<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>单表管理</title>
	<meta name="decorator" content="default"/>

</head>
<body>
<br>
<ul class="nav nav-tabs">
    <li  class="active"><a href="${ctx}/school/student/info?id=${student.id}&&tagFlag=${tagFlag}">基本信息</a></li>
    <c:if test="${tagFlag != 1}">
        <li><a href="${ctx}/school/student/enrollInfo?id=${student.id}&&tagFlag=${tagFlag}">招生信息</a></li>
        <li><a href="${ctx}/school/student/classInfo?id=${student.id}&&tagFlag=${tagFlag}">报读班级</a></li>
        <li><a href="${ctx}/school/student/scheduleInfo?id=${student.id}&&tagFlag=${tagFlag}">课表信息</a></li>
        <li><a href="${ctx}/school/student/signInfo?id=${student.id}&&tagFlag=${tagFlag}">上课记录</a></li>
    </c:if>
    <li><a href="${ctx}/school/student/communicateInfo?id=${student.id}&&tagFlag=${tagFlag}">沟通记录</a></li>
</ul>
	<form:form id="inputForm" modelAttribute="student" action="${ctx}/school/student/info" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<table style="border-collapse:separate; border-spacing:5px;" >
			<tr>
                <td>
                    <div class="control-group">
                        <label class="control-label">名称：</label>
                        <div class="controls">
                            ${student.name}
                            
                        </div>
                    </div>
                </td>
                <td>
                    <div class="control-group">
                        <label class="control-label">身份证号：</label>
                        <div class="controls">
                                ${student.stuNumber}

                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label">身份证地址：</label>
                        <div class="controls">
                                ${student.stuNumberAddress}

                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="control-group">
                        <label class="control-label">出生日期：</label>
                        <div class="controls">
                            <fmt:formatDate value="${student.dateBirth}" pattern="yyyy-MM-dd"/>
                        </div>
                    </div>
                </td>
                <td>
                    <div class="control-group">
                        <label class="control-label">职业方向：</label>
                        <div class="controls">
                            <c:forEach items="${student.getOccupationList()}" var="occId" varStatus="length">
                                <c:if test="${length.index!=0}">
                                    ,
                                </c:if>
                                ${erp:getCommonsTypeName(occId)}
                            </c:forEach>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="control-group">
                        <label class="control-label">手机号码：</label>
                        <div class="controls">
                                ${student.phone}

                            
                        </div>
                    </div>
                </td>
                <td>
                    <div class="control-group">
                        <label class="control-label">紧急联系人：</label>
                        <div class="controls">
                                ${student.emergencyContact}

                            
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="control-group">
                        <label class="control-label">QQ号码：</label>
                        <div class="controls">
                                ${student.qqNumber}

                        </div>
                    </div>
                </td>
                <td>
                    <div class="control-group">
                        <label class="control-label">紧急联络人电话：</label>
                        <div class="controls">
                                ${student.urgencyPhone}

                            
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="control-group">
                        <label class="control-label">生活城市:</label>
                        <div class="controls">
                           ${student.stuCity.name}
                        </div>
                    </div>
                </td>
                <td>
                    <div class="control-group">
                        <label class="control-label">性别：</label>
                        <div class="controls">
                            ${erp:sexStatusName(student.sex)}
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="control-group">
                        <label class="control-label">籍贯:</label>
                        <div class="controls">
                                ${student.nativePlace.name}
                        </div>
                    </div>
                </td>
                <td>
                    <div class="control-group">
                        <label class="control-label">学历：</label>
                        <div class="controls">
                            <c:forEach items="${erp:getCommonsTypeList(7)}" var="commonsType">
                                <c:if test="${commonsType.id == student.education}">
                                    ${commonsType.commonsName}
                                </c:if>
                            </c:forEach>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="control-group">
                        <label class="control-label">招生来源：</label>
                        <div class="controls" >
                                ${student.customerResource.customerName}
                            
                        </div>
                    </div>
                </td>
                <td>
                    <div class="control-group">
                        <label class="control-label">所属校区:</label>
                        <div class="controls">
                            <c:forEach items="${areasList}" var="areas">
                                <c:if test="${areas.id == student.areas.id}">
                                    ${areas.areaName}
                                </c:if>
                            </c:forEach>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="control-group">
                        <label class="control-label">招聘老师：</label>
                        <div class="controls">
                                ${student.teacher.name}
                        </div>
                    </div>
                </td>
                <td>
                    <div class="control-group">
                        <label class="control-label">学员类型：</label>
                        <div class="controls">
                            ${erp:studentTypeName(student.studentType)}
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="control-group">
                        <label class="control-label">推荐人：</label>
                        <div class="controls">
                                ${student.referrer.name}
                        </div>
                    </div>
                </td>
                <td>
                    <div class="control-group">
                        <label class="control-label">预计报名时间：</label>
                        <div class="controls">
                            <fmt:formatDate value="${student.predictApplyTime}" pattern="yyyy-MM-dd"/>
                        </div>
                    </div>
                </td>
            </tr>

        </table>
	</form:form>
</body>
</html>


