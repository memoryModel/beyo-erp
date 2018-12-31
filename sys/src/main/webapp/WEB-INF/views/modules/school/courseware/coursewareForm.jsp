<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>知识管理</title>
	<meta name="decorator" content="default"/>
	<link href="/static/upload/uploadfile.css?v=1" type="text/css" rel="stylesheet" />
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/school/courseware/list">${courseware.category==2 ? '课件':'答疑'}列表</a></li>
		<li class="active">
			<c:if test="${courseware.category == 2}">
				<a href="${ctx}/school/courseware/form?id=${courseware.id}">课件${not empty schoolCourseware.id?'修改':'添加'}</a>
			</c:if>
			<c:if test="${courseware.category == 1}">
				<a href="${ctx}/school/answerQuestion/form?id=${courseware.id}">答疑${not empty schoolCourseware.id?'修改':'添加'}</a>
			</c:if>
		</li>
	</ul><br/>
		<form:form id="inputForm" modelAttribute="courseware" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">名称：</label>
			<div class="controls">
				<form:input path="title" htmlEscape="false" maxlength="524" class="required input-xlarge " style="width: 200px;"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">科目：</label>
			<div class="controls">
					<form:select path="schoolSubject.id" class="required" style="width: 210px;">
						<form:options items="${schoolSubjectList}" itemLabel="subjectName" itemValue="id" htmlEscape="false"/>
					</form:select>
				<span class="help-inline"><font color="red">*</font> </span>

			</div>
		</div>


		<div class="control-group">
			<label class="control-label">课件内容：</label>
			<div class="controls">
				<form:textarea path="content" htmlEscape="false" rows="4" class="required input-xxlarge "/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>

		<div class="control-group">
			<label class="control-label">权限：</label>
			<div class="controls">
				<!--checked="true" notAllowSelectRoot="true" notAllowSelectParent="true"-->
				<sys:treeselect id="office" name="office.id" value="${schoolCourseware.office.id}" labelName="office.name"
								labelValue="${schoolCourseware.office.name}" title="部门" url="/sys/office/treeData?type=2" cssClass="required" allowClear="true" />
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>

		<div class="control-group">
			<label class="control-label">附件：</label>
			<div class="controls">
				<form:hidden path="url" id="url"/>
				<span id="coverShow">
					<c:if test="${!empty courseware.url}">
						<div>
							<a target="_blank" href='${courseware.url}'>${courseware.url}</a>
						</div>
					</c:if>
				</span>
				<div id="uploadCover"></div>
				<div type="button" class="btn" id="deleteCover">删除附件</div>
			</div>
		</div>
			<c:if test="${courseware.id != null }">
				<div class="control-group">
					<label class="control-label">状态：</label>
					<div class="controls">
						<form:select path="status" class="input-medium">
							<form:options items="${erp:commonsStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
						</form:select>
					</div>
				</div>
			</c:if>

		<div class="form-actions">
			<c:if test="${schoolCourseware.category == 2}">
				<shiro:hasPermission name="school:courseware:save"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			</c:if>
			<c:if test="${schoolCourseware.category != 2}">
				<shiro:hasPermission name="school:answerQuestion:save"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			</c:if>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
	<script type="text/javascript" src="/static/upload/jquery.form.js"></script>
	<script type="text/javascript" src="/static/upload/jquery.uploadfile.min.js?v=3"></script>
	<script type="text/javascript">
        $(document).ready(function() {



            if(${courseware.category == 2}){
                $("#inputForm").attr("action","${ctx}/school/courseware/save");
            }else {
                $("#inputForm").attr("action","${ctx}/school/answerQuestion/save");
            }


            $("#uploadCover").uploadFile({
                url:"/upload/files",
                fileName:"content",
                uploadStr:"上传附件",
                formData: {"dir":"knowledge","isPrivate":false},
                multiple:false,
                dragDrop:false,
                uploadButtonClass:"ajax-file-upload-green btn btn-primary ignore",
                showStatusAfterSuccess:false,
                showAbort:false,
                showDone:false,
                acceptFiles:/(\.|\/)(txt|doc?|pdf|ppt|xls)$/i,
                //allowedTypes:"txt,doc,docx,xls,ppt,pptx,rmvb,avi",
                returnType:"json",
                showPreview:true,
                previewHeight: "100px",
                previewWidth: "100px",
                onSuccess:function(files,data,xhr,pd) {

                    var url = data.urls[0];


                    $("#coverShow").empty();
                    $("#coverShow").html("<div><a target='_blank' href='"+url+"'>"+url+"</a></div>");
                    $("input[name='url']").val(url);


                },
                onError:function(files,data,xhr,pd) {
                    showMessage("error","上传失败");
                }
            });


            $("#deleteCover").click(function () {
                $("#coverShow").empty();
                $("input[name='url']").val("");
            });

            $('form').each(function() {

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

            var result = '${result}'
			if(result == 'y'){
                $('[class="btn btn-primary"][type="submit"]').hide();
			}
        });


	</script>
</body>
</html>