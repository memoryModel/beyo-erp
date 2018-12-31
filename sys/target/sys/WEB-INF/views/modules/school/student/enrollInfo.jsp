<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>单表管理</title>
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
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});


            if(${not empty student.id}){
                var occupationList = ${student.getOccupationList()};
                console.log(${student.getOccupationList()});
            }
            /*$('#customerResourceName').rules('add', { required: true });
            $('#customerResourceName').addClass("required");*/
		});
	</script>
</head>
<body>
<br>
    <ul class="nav nav-tabs">
        <li ><a href="${ctx}/school/student/info?id=${student.id}&&tagFlag=${tagFlag}">基本信息</a></li>
        <li  class="active"><a href="${ctx}/school/student/enrollInfo?id=${student.id}&&tagFlag=${tagFlag}">招生信息</a></li>
        <li ><a href="${ctx}/school/student/classInfo?id=${student.id}&&tagFlag=${tagFlag}">报读班级</a></li>
        <li ><a href="${ctx}/school/student/scheduleInfo?id=${student.id}&&tagFlag=${tagFlag}">课表信息</a></li>
        <li><a href="${ctx}/school/student/signInfo?id=${student.id}&&tagFlag=${tagFlag}">上课记录</a></li>
        <li><a href="${ctx}/school/student/communicateInfo?id=${student.id}&&tagFlag=${tagFlag}">沟通记录</a></li>
    </ul>
	<form:form id="inputForm" modelAttribute="student" action="${ctx}/school/student/enrollInfo" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<table style="border-collapse:separate; border-spacing:5px;">
            <tr>
                <td>
                    <div class="control-group">
                        <label class="control-label">招生来源：</label>
                        <div class="controls" >
                                ${student.customerResource.customerName}
                            
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
                        <label class="control-label">推荐人：</label>
                        <div class="controls">
                                ${student.referrer.name}
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="control-group">
                        <label class="control-label">跟进人：</label>
                        <div class="controls">
                                ${student.follow.name}
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="control-group">
                        <label class="control-label">添加人：</label>
                        <div class="controls">
                            <input type="hidden" value="${student.user.id}" />
                                ${student.user.name}
                            
                        </div>
                    </div>
                </td>
                <td>
                    <div class="control-group">
                        <label class="control-label">添加时间：</label>
                        <div class="controls">
                            <fmt:formatDate value="${student.createTime}" pattern="yyyy-MM-dd HH:mm"/>
                        </div>
                    </div>
                </td>
            </tr>
        </table>
	</form:form>
</body>
</html>


