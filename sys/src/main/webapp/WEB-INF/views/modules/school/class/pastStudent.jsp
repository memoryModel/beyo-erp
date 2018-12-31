<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>往期学员在读</title>
	<meta name="decorator" content="default"/>
</head>
<body>
<form:form id="inputForm" modelAttribute="class" method="post" class="form-horizontal">

		<sys:message content="${message}"/>

		<div class="control-group">
			<label class="control-label">选择班级：</label>
			<div class="controls">
                <input type="hidden" id="classId">
                <input type="text" id="className" readonly="readonly">
                <input id="selectClass" class="btn btn-primary" type="button" value="选择班级"/>
                <span class="help-inline"><font color="red">*</font></span>
                <label class="error" id="classIdError"></label>
			</div>
		</div>

        <div class="control-group">
            <label class="control-label">选择学员：</label>
            <div class="controls">
                <input id="selectPastStudent" class="btn btn-primary" type="button" value="选择学员"/>
                <span class="help-inline"><font color="red">*</font></span>
                <label class="error" id="studentIdsError"></label>
            </div>
        </div>

        <div class="control-group">
            <label class="control-label">已选择的学员：</label>
            <div class="controls">
                <input type="hidden" id="studentIds">
                <div id="studentNames"></div>
            </div>
        </div>
        <br/><br/>
</form:form>
		<div class="form-actions">
            <button type="button" class="btn btn-primary" onclick="submitSave()">保存</button>&nbsp;
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
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

            //选择班级
            $('#selectClass').click(function(){
                top.$.jBox.open("iframe:/school/class/selectClass",
                    "选择班级",
                    1024,
                    520,
                    {ajaxData:{"btnFlag":"1","filterResult":"y"}}
                );
            });

            //选择学员
            $('#selectPastStudent').click(function(){
                top.$.jBox.open("iframe:/school/class/selectPastStudent",
                    "选择学员",
                    1024,
                    520,
                    {ajaxData:{"classId":$('#classId').val()}}
                );
            });
        });

        //回显选择班级
        function selectClassCallback(classId,className){
            $('#classId').val(classId);
            $('#className').val(className);
            classValidate();
        }

        //回显选择的学员
        function selectPastStudentCallback(studentIds,studentNames){
            $('#studentIds').val(studentIds);
            $('#studentNames').text(studentNames);
            stduentValidate();
        }

        //验证班级是否为空
        function classValidate(){
            var classId = $('#classId').val()
            if(!classId){
                $("#classIdError").html("请选择班级！");
                return false;
            }else{
                $("#classIdError").html("");
                return true;
            }
        }

        //验证学员是否为空
        function stduentValidate(){
            var studentIds = $('#studentIds').val()
            if(!studentIds){
                $("#studentIdsError").html("请选择学员！");
                return false;
            }else{
                $("#studentIdsError").html("");
                return true;
            }
        }

        function submitSave(){
            var cv = classValidate();
            var sv = stduentValidate();
            if(!sv || !cv) return;
            $.ajax({
                type : 'post',
                url : '${ctx}/school/class/savePastStudent',
                data:{"classId":$('#classId').val(),"studentIds":$('#studentIds').val()},
                success : function(data) {
                    if (data && data == "success") {
                        location.href = '${ctx}/school/class/list';
                    } else {
                        window.location.reload();
                    }
                }
            })
        }
    </script>
</body>
</html>