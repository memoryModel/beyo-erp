<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
<html>
<head>
	<title>考试管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
        $(function () {
            jQueryCheckAll();
        });

        function jQueryCheckAll(){
            var checkAll = $('[name="checkboxs"]');
            var items = $('[name="checkbox"]');
            checkAll.click(function () {
                if ($(this).attr('checked')) {
                    items.each(function () {
                        $(this).attr('checked', true);
                    })
                }else {
                    items.each(function () {
                        $(this).attr('checked', false);
                    })
                }
                items.click(function () {
                    checkAll.attr("checked", items.length == $('[name="checkbox"]:checked').length ? true : false);
                });
                appendParent();
            })

        }

        function appendParent(){

            $('[name="checkbox"]').each(function(){
                selectLesson($(this).next().val(),$(this).next().next().val(),$(this).next().next().next().val(),
                    $(this).next().next().next().next().val(),$(this).next().next().next().next().next().val(),
                    $(this).next().next().next().next().next().next().val(),$(this).next().next().next().next().next().next().next().val(),
                    $(this).next().next().next().next().next().next().next().next().val(),
                    $(this).next().next().next().next().next().next().next().next().next().val());
            })


        }


	</script>
</head>
<body>
<form:form id="searchForm" modelAttribute="classLesson" onsubmit="sub()"  method="post" class="breadcrumb form-search">
	<input type="hidden" name="lessonJson" id="lessonJson" style="width:1230px;"/>
	<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
	<ul class="ul-form">
		<li><label>课程名称：</label>
			<form:input path="lessonName" htmlEscape="false" maxlength="512" class="input-medium"/>
		</li>
		<li><label>创建时间：</label>
			<input name="createTimeStart" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
				   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>-
			<input name="createTimeEnd" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
				   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
		</li>
		<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
		<li class="clearfix"></li>
	</ul>

</form:form>
<sys:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
	<thead>
	<tr>
		<c:if test="${btnFlag == 0}">
			<th><input type="checkbox" name="checkboxs"></th>
		</c:if>
		<th>课程名称</th>
		<th>授课老师</th>
		<th>年份</th>
		<th>期段</th>
		<th>类型</th>
		<%--<th>科目</th>--%>
		<th>创建时间</th>
		<%--<th>状态</th>--%>
		<c:if test="${btnFlag == 1}">
			<td>操作</td>
		</c:if>
	</tr>
	</thead>
	<tbody>
	<c:forEach items="${page.list}" var="schoolClassLesson">
		<tr>
			<c:if test="${btnFlag == 0}">
				<td>
					<input type="checkbox" name="checkbox" id="checkbox${schoolClassLesson.id}" onclick="selectLesson(
							'${schoolClassLesson.id}','${schoolClassLesson.lessonName}',
							'${schoolClassLesson.teacherIds}','${schoolClassLesson.teacherNames}',
							'${erp:getCommonsTypeName(schoolClassLesson.schoolLessonType)}','${btnFlag}')"/>
					<input type="hidden" value="${schoolClassLesson.id}">
					<input type="hidden" value="${schoolClassLesson.lessonName}">
					<input type="hidden" value="${schoolClassLesson.teacherIds}">
					<input type="hidden" value="${schoolClassLesson.teacherNames}">
					<input type="hidden" value="${erp:getCommonsTypeName(schoolClassLesson.schoolLessonType)}">
					<input type="hidden" value="${btnFlag}">
				</td>

			</c:if>
			<td>
					${schoolClassLesson.lessonName}
			</td>
			<td>
					${schoolClassLesson.teacherNames}
			</td>
			<td>
				<fmt:formatDate value="${schoolClassLesson.createTime}" pattern="yyyy"/>
			</td>
			<td>
				<fmt:formatDate value="${schoolClassLesson.createTime}" pattern="MMMM"/>
			</td>
			<td>
					${erp:getCommonsTypeName(schoolClassLesson.schoolLessonType)}
			</td>
				<%--<td>
                        ${schoolClassLesson.schoolSubject.subjectName}
                </td>--%>
			<td>
				<fmt:formatDate value="${schoolClassLesson.createTime}" pattern="yyyy-MM-dd"/>
			</td>
				<%--<td>
                        ${erp:commonsStatusName(schoolClassLesson.status)}
                </td>--%>
			<c:if test="${btnFlag == 1}">
				<td>
					<input id="selectLesson${schoolClassLesson.id}" name="chkLesson" class="btn btn-primary" type="button" value="选择"
						   onclick="selectLesson(
								   '${schoolClassLesson.id}','${schoolClassLesson.lessonName}',
								   '${schoolClassLesson.teacherIds}','${schoolClassLesson.teacherNames}',
								   '${erp:getCommonsTypeName(schoolClassLesson.schoolLessonType)}','${btnFlag}')" />
				</td>
			</c:if>
		</tr>
	</c:forEach>
	</tbody>
</table>
<div class="pagination">${page}</div>
<script type="text/javascript">

    var btnFlag = ${btnFlag};//按钮标记  0：按钮隐藏  1：按钮展示
    var currentlessonId = "${lessonId}";
    var lessonJson = "${lessonJson}";
    var lessonDataArray = new Array;
    if(lessonJson !=null && lessonJson !="") lessonDataArray = JSON.parse(decodeURIComponent(lessonJson));
    //console.log(lessonDataArray);
    for(var i=0;i<lessonDataArray.length;i++) {
        var obj = lessonDataArray[i];
        var lessonId = obj.lessonId;
        var key = lessonId;
        lessonDataArray[i].key = key;
    }
    if (lessonDataArray.length>=20){
        $('[name="checkboxs"]').attr("checked",true);
    }
    //$("#lessonJson").val(JSON.stringify(lessonDataArray));

    $(document).ready(function() {
        //旧数据
        for(var k=0;k<lessonDataArray.length;k++) {
            var obj = lessonDataArray[k];
            //console.log(obj);
            $("#checkbox"+obj.key).attr("checked",true);

			/*if (obj.lessonId != currentClassLessonId || obj.classId != currentClassId){
			 $("#checkbox"+obj.key).attr("disabled",true);
			 }*/


        }
    });

    function page(n,s){
        $("#pageNo").val(n);
        $("#pageSize").val(s);
        $("#searchForm").submit();
        return false;
    }

    function selectLesson(lessonId,lessonName,teacherId,teacherName,lessonTypeName,btnFlag){
        var chked = $("#checkbox"+lessonId).attr("checked");
        if(btnFlag == 0) {
            parent.window.frames["mainFrame"].selectLessonCallback(lessonId, lessonName, teacherId, teacherName, lessonTypeName, chked);
        }
        if(btnFlag == 1){
            top.$.jBox.confirm('确认要选择该课程吗？','系统提示',function(v,h,f) {
                if (v == 'ok') {
                    parent.window.frames["mainFrame"].selectLessonCallback(lessonId,lessonName,teacherId,teacherName,lessonTypeName,chked);
                    top.$.jBox.close(true);
                }
            },{buttonsFocus:1, closed:function(){
                if (typeof closed == 'function') {
                    closed();
                }
            }});
        }
    }

    function sub() {
        var url= "${ctx}/school/class/selectLesson?lessonJson="+$("#lessonJson").val()+"&&btnFlag=${btnFlag}"
        $("#searchForm").attr("action",url);
        //action="${ctx}/school/class/selectLesson?lessonJson=&&btnFlag=${btnFlag}"
    }


	/*function selectLesson(lessonId,lessonName,teacherId,teacherName){
	 console.log("#btnSelect"+lessonId+"--"+lessonName+"--"+teacherId+"--"+teacherName+"--"+subjectId+"--"+subjectName);
	 var chked = $("#checkbox"+lessonId).attr("checked");
	 top.$.jBox.confirm('确认要选择添加该课程吗？','系统提示',function(v,h,f) {
	 if (v == 'ok') {
	 parent.window.frames["mainFrame"].selectLessonCallback(lessonId,lessonName,teacherId,teacherName,chked);
	 top.$.jBox.close(true);
	 }
	 },{buttonsFocus:1, closed:function(){
	 if (typeof closed == 'function') {
	 closed();
	 }
	 }});
	 //close
	 }*/
</script>
</body>
</html>