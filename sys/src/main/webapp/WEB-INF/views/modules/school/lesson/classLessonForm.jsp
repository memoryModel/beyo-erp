<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>课程管理</title>
	<meta name="decorator" content="default"/>
	<link href="/static/upload/uploadfile.css?v=1" type="text/css" rel="stylesheet" />
	<script type="text/javascript">
        //全局参数
        var teacherList = ${fns:toJson(teacherList)};//scheduleList后台查询已有课程信息
        //console.info("ids"+teacherIdsList);
        var lessonTeacherTableTemplate;
        var lessonTeacherArray = new Array();


        $(document).ready(function() {
            $("#inputForm").each(function() {
                $(this).validate({
                    ignore: ".ignore",
                    submitHandler: function (form) {
                        loading('正在提交，请稍等...');
                        form.submit();
                    },
                    errorContainer: "#messageBox",
                    errorPlacement: function (error, element) {
                        $("#messageBox").text("输入有误，请先更正。");
                        if (element.is(":checkbox") || element.is(":radio") || element.parent().is(".input-append")) {
                            error.appendTo(element.parent().parent());
                        } else {
                            error.insertAfter(element);
                        }
                    }
                });
            });

            //选择授课老师
            $("#selectTeacher").click(function () {
                top.$.jBox("iframe:/school/lesson/findTeacher",
                    {"title": "老师列表",
                        "width":1024,
                        "height":520
                    });
            });
            lessonTeacherTableTemplate = $("#lessonTeacherTableTemplate").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
            appendTable();
        });

        //读取后台传递的已有课程列表
        for(var i=0;i<teacherList.length;i++){
            var obj = teacherList[i];
            var userId = obj.id;
            //console.log(obj);
            var userName = obj.name;
            var userLoginName = obj.loginName;
            var companyName = obj.company.name;
            var officeName = obj.office.name;
            var userPhone = obj.phone;
            var userMobile = obj.mobile;

            var key = userId+userPhone;

            pushlessonTeacherArray(key,userId,userName,userLoginName,companyName,officeName,userPhone,userMobile);

        }

        function appendTable(){
            $("#lessonTeacherTable").empty();
            $("#lessonTeacherTable").append(Mustache.render(lessonTeacherTableTemplate, {"lessonTeacherArray":lessonTeacherArray}));
            $("#lessonTeacherJson").val(JSON.stringify(lessonTeacherArray));
            if(lessonTeacherArray.length>0){
                $("#teacherSum").val("共 "+lessonTeacherArray.length+" 个教师");
            }else{
                $("#teacherSum").val("");
            }
        }

        function selectTeacherCallback(userId,userName,userLoginName,companyName,officeName,userPhone,userMobile,chked) {
            var key = userId+userPhone;
            $("#userId").val(userId);
            $("#userName").val(userName);

            for(var i=0;i<lessonTeacherArray.length;i++){
                if (key == lessonTeacherArray[i].key){
                    if (chked){
                        return;
                    }else{
                        lessonTeacherArray.remove(i);
                        appendTable();
                        return;
                    }
                }
            }

            pushlessonTeacherArray(key,userId,userName,userLoginName,companyName,officeName,userPhone,userMobile);
            appendTable();
        }

        //lessonArray追加数据
        function pushlessonTeacherArray(key,userId,userName,userLoginName,companyName,officeName,userPhone,userMobile) {
            lessonTeacherArray.push({
                "key":key,
                "userId":userId,
                "userName":userName,
                "userLoginName":userLoginName,
                "companyName":companyName,
                "officeName":officeName,
                "userPhone":userPhone,
                "userMobile":userMobile
            });
        }

        //移除元素
        Array.prototype.remove=function(dx){
            if(isNaN(dx)||dx>this.length){return false;}
            for(var i=0,n=0;i<this.length;i++)
            {
                if(this[i]!=this[dx])
                {
                    this[n++]=this[i]
                }
            }
            this.length-=1
        };

        function removeteacher(userId){
            //console.log(userId);
            for(var i=0;i<lessonTeacherArray.length;i++){
                if (userId == lessonTeacherArray[i].userId){
                    lessonTeacherArray.remove(i);
                    appendTable();
                    return;
                }
            }
            //appendTable();
        }

	</script>
</head>
<body>
<ul class="nav nav-tabs">
	<li><a href="${ctx}/school/lesson/list">课程列表</a></li>
	<li class="active"><a href="${ctx}/school/lesson/form?id=${schoolClassLesson.id}">课程${not empty schoolClassLesson.id?'修改':'添加'}查看</a></li>
</ul><br/>
<form:form id="inputForm" modelAttribute="classLesson" action="${ctx}/school/lesson/save" method="post" class="form-horizontal">
	<form:hidden path="id"/>
	<div class="control-group">
		<label class="control-label">课程名称：</label>
		<div class="controls">
			<form:input path="lessonName" htmlEscape="false" maxlength="512" class="required input-xlarge" style="width: 250px;"/>
			<span class="help-inline"><font color="red">*</font> </span>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">班型：</label>
		<div class="controls">
			<form:select path="schoolLessonType" class="required input-medium">
				<form:option value="" label="--请选择--"/>
				<form:options items="${erp:getCommonsTypeList(50)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
			</form:select>
			<span class="help-inline"><font color="red">*</font> </span>
		</div>
	</div>
	<%--<div class="control-group">
        <label class="control-label">科目：</label>
        <div class="controls">
            <form:select path="schoolSubject.id" class="required" style="width: 163px;">
                <form:options items="${subjectList}" itemLabel="subjectName" itemValue="id" htmlEscape="false"/>
            </form:select>
            <span class="help-inline"><font color="red">*</font> </span>
        </div>
    </div>--%>
	<%--<div class="control-group">
        <label class="control-label">授课老师：</label>
        <div class="controls">
            &lt;%&ndash;<sys:employeeselect id="employee" name="teacher.id" value="${schoolClassLesson.teacher.id}" labelName="schoolClassLesson.teacher.name" labelValue="${schoolClassLesson.teacher.name}"
                title="员工" url="/erp/employee/officeTreeData?type=3" allowClear="true" notAllowSelectParent="true" cssClass="required"/>&ndash;%&gt;
            <sys:treeselect id="teacher" name="teacher.id" value="${schoolClassLesson.teacher.id}"
                            labelName="teacher.name" labelValue="${schoolClassLesson.teacher.name}"
                            title="选择用户" url="/sys/office/treeData?type=3" notAllowSelectParent="true"/>
            <span class="help-inline"><font color="red">*</font> </span>
        </div>
    </div>--%>
	<div class="control-group">
		<label class="control-label">授课老师：</label>
		<div class="controls">
				<%--<form:input path="teacherIds" htmlEscape="false" maxlength="512" class="required input-xlarge" style="width: 250px;"/>--%>
			<input type="text" id="teacherSum" class="input-large required" readonly="readonly"/>
			<input id="selectTeacher" class="btn btn-primary" type="button" value="选择授课老师"/>
			<span class="help-inline"><font color="red">*</font> </span>
		</div>
	</div>

	<table id="contentTable" class="table table-striped table-bordered table-condensed" style="width: 80%">
		<thead>
		<tr>
			<th>姓名</th>
			<th>登录名</th>
			<th>归属公司</th>
			<th>归属部门</th>
			<th>电话</th>
			<th>手机</th>
			<th>操作</th>
		</tr>
		</thead>
		<tbody id="lessonTeacherTable">
		<script type="text/template" id="lessonTeacherTableTemplate">
			{{#lessonTeacherArray}}
			<tr>
				<td>{{userName}}</td>
				<td>{{userLoginName}}</td>
				<td>{{companyName}}</td>
				<td>{{officeName}}</td>
				<td>{{userPhone}}</td>
				<td>{{userMobile}}</td>
				<td>
					<input type="hidden" name="teacherIds" value="{{userId}}">
					<input id="removeteacher{{userId}}" class="btn btn-danger" type="button" value="删 除"
						   onclick="removeteacher('{{userId}}')"/>
				</td>
			</tr>
			{{/lessonTeacherArray}}
		</script>
		</tbody>
	</table>
	<br>


	<div class="control-group">
		<label class="control-label">图片：</label>
		<div class="controls">
			<form:hidden path="photoUrl" />
			<span id="coverShow">
					<c:if test="${!empty classLesson.photoUrl}">
						<div><img src='${classLesson.photoUrl}&iopcmd=thumbnail&type=4&width=100'/></div>
					</c:if>
				</span>
			<span id="uploadCover"></span>
			<div type="button" class="btn" id="deleteCover">删除封面</div>
		</div>
	</div>
	<c:if test="${classLesson.id != null }">
		<div class="control-group">
			<label class="control-label">状态：</label>
			<div class="controls">
				<form:select path="status" class="input-medium">
					<form:options items="${erp:commonsStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
	</c:if>
	<div class="control-group">
		<label class="control-label">课程内容：</label>
		<div class="controls">
			<form:textarea path="lessonContent" htmlEscape="false" rows="4" maxlength="200" class="required input-xlarge" style="width:700px;"/>
			<span class="help-inline"><font color="red">*</font> </span>
		</div>
	</div>

	<div class="form-actions">
		<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
		<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
	</div>
</form:form>
<script type="text/javascript" src="/static/upload/jquery.form.js"></script>
<script type="text/javascript" src="/static/upload/jquery.uploadfile.min.js?v=1"></script>
<script type="text/javascript">
    $(document).ready(function(){
        $("#uploadCover").uploadFile({
            url:"/upload/files",
            fileName:"content",
            uploadStr:"上传封面",
            formData: {"dir":"classLesson","isPrivate":false},
            multiple:false,
            dragDrop:false,
            uploadButtonClass:"ajax-file-upload-green btn btn-primary ignore",
            showStatusAfterSuccess:false,
            showAbort:false,
            showDone:false,
            acceptFiles:"image/*",
            allowedTypes:"png,gif,jpg,jpeg",
            returnType:"json",
            showPreview:true,
            previewHeight: "100px",
            previewWidth: "100px",
            onSuccess:function(files,data,xhr,pd) {
                var photoUrl = data.urls[0];//记得改上传目录

                $("#coverShow").empty();
                $("#coverShow").html("<div><img src='"+photoUrl+"&iopcmd=thumbnail&type=4&width=100'/></div>");
                $("input[name='photoUrl']").val(photoUrl);

            },
            onError:function(files,data,xhr,pd) {
                showMessage("error","上传失败");
            }
        });
    });
    $("#deleteCover").click(function () {
        $("#coverShow").empty();
        $("input[name='photoUrl']").val("");
    });

    function showMessage(status,message) {
        $("#contentTable").before('<div id="messageBox" class="alert alert-'+status+'"><button data-dismiss="alert" class="close">×</button>'+message+'</div>');
    }
</script>
</body>
</html>