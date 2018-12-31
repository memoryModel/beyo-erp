<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>请假管理</title>
	<meta name="decorator" content="default"/>

</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/school/leave/list">请假列表</a></li>
		<li class="active"><a href="${ctx}/school/leave/form?id=${schoolLeave.id}">请假<shiro:hasPermission name="school:leave:form">${not empty schoolLeave.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="school:leave:form"></shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="schoolLeave" action="${ctx}/school/leave/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="predictLesson" id="predictLesson"/>
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">姓名：</label>
			<div class="controls">
				<input type="hidden" name="student.id" id="studentId" value="${schoolLeave.student.id}">
				<input  type="text"  name="student.name" id="studentName" value="${schoolLeave.student.name}"
						class="input-large required" placeholder="点击选择添加学员" readonly=readonly />&nbsp;&nbsp;
				<input id="selectEnroll" class="btn btn-primary" type="button" value="选择学员"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">学号：</label>
			<div class="controls">
				<input type="text" value="${schoolLeave.student.studentNumber}" class="input-large" id="studentNumber" readonly="readonly">
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">手机号：</label>
			<div class="controls">
				<input type="text" id="phone" value="${schoolLeave.student.phone}" class="input-large" readonly="readonly">
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">请假原因：</label>
			<div class="controls">
				<form:select id="leaveReason" path="leaveReason" class="required input-large" >
					<form:options items="${erp:getCommonsTypeList(28)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">请假时间：</label>
			<div class="controls">
				<input name="startTime" id="startTime"  type="text" readonly="readonly" maxlength="20" class="required input-medium Wdate "
					value="<fmt:formatDate value="${schoolLeave.startTime}" pattern="yyyy-MM-dd HH:mm"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true,onpicked:function(dp){changeTime()}});"/>&nbsp;至&nbsp;
				<input name="endTime" id="endTime" type="text" readonly="readonly" maxlength="20" class="required input-medium Wdate "
					   value="<fmt:formatDate value="${schoolLeave.endTime}" pattern="yyyy-MM-dd HH:mm" />"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true,onpicked:function(dp){changeTime()}});" />
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">请假状态：</label>
			<div class="controls">
				<form:select path="leaveStatus" id="status" class="required input-large" >
					<form:option value="">请选择</form:option>
					<form:options items="${erp:leaveStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注：</label>
			<div class="controls">
				<form:textarea path="remark" htmlEscape="false" rows="4" maxlength="512" class="input-xxlarge " />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><b>预计延误课程</b></label>
			<div class="controls">
				<table id="contentTable" class="table table-striped table-bordered table-condensed" style="width: 80%">
					<thead>
					<tr>
						<th>班级名称</th>
						<th>课程名称</th>
						<th>授课老师</th>
						<th>上课时间</th>
						<th>上课教室</th>
					</tr>
					</thead>
					<tbody id="classTable">

					</tbody>
				</table>
			</div>
		</div>

		<div class="form-actions">
			<shiro:hasPermission name="school:leave:save"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
	<script id="classTemplate" type="text/template">
		{{#classArray}}
		<tr>
			<td>
				{{className}}
			</td>
			<td>
				{{lessonName}}
			</td>
			<td>
				{{teacherName}}
			</td>
			<td>
				{{beginTime}}&nbsp;-&nbsp;{{endTime}}
			</td>
			<td>
				{{roomName}}
			</td>
		</tr>
		{{/classArray}}
	</script>
	<script type="text/javascript">
		var classTemplate;
		var classArray;

        Date.prototype.Format = function(fmt){
            var o = {
                "M+" : this.getMonth()+1,                 //月份
                "d+" : this.getDate(),                    //日
                "h+" : this.getHours(),                   //小时
                "m+" : this.getMinutes(),                 //分
                "s+" : this.getSeconds(),                 //秒
                "q+" : Math.floor((this.getMonth()+3)/3), //季度
                "S"  : this.getMilliseconds()             //毫秒
            };
            if(/(y+)/.test(fmt))
                fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));
            for(var k in o)
                if(new RegExp("("+ k +")").test(fmt))
                    fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));
            return fmt;
        }

        $(document).ready(function() {

            classTemplate = $("#classTemplate").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");

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

            $("#selectEnroll").click(function () {
                top.$.jBox("iframe:/school/leave/selectEnroll", {
                    title:"添加学员",
                    width: 1024,
                    height:520,
                    buttons:{}
                });
            });
            $("#studentName").change(function () {
                changeTime();
            });
        });

        function selectEnrollCallback(studentId,name,studentNumber,phone){
            $("#studentId").val(studentId);
            $("#studentName").val(name);
            $("#studentNumber").val(studentNumber);
            $("#phone").val(phone);
        }

        function changeTime() {
            var studentId = $("#studentId").val();
            var startTime = $("#startTime").val();
            var endTime = $("#endTime").val();
            if (studentId=="" || startTime=="" || endTime=="")return;

            $.ajax({
                type : 'post',
                url : '${ctx}/school/leave/selectLesson',
                data:{"studentId":studentId,"startTime":startTime,"endTime":endTime},
                success:function(data){
                    console.log(data);
                    if(!data)return;

					showClass(data.list);
                }
            })
        }
        function showClass(list) {
            $("#classTable").empty();
            classArray = new Array();
            if (list.length<=0)return;

            for(var i=0;i<list.length;i++){
                classArray.push({
					"className":list[i].schoolClass.className,
					"lessonName":list[i].schoolClassLesson.lessonName,
					"teacherName":list[i].teacher.name,
					"beginTime":(new Date(list[i].beginTime)).Format("yyyy-MM-dd hh:mm"),
					"endTime":(new Date(list[i].endTime)).Format("yyyy-MM-dd hh:mm"),
					"roomName":list[i].schoolClassroom.classroomName
				});
			}

            $("#classTable").append(Mustache.render(classTemplate, {"classArray":classArray}));
            $("#predictLesson").val(list.length);
        }
	</script>
</body>
</html>