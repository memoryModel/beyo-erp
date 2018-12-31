<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
<html>
<head>
	<title>学员列表</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
        $(document).ready(function() {
            jQueryCheckAll();
            $('[type="checkbox"]').click(function () {
                var studentIds = '';
                var studentNames = '';
                var chechboxHtml = $('[type="checkbox"][name="checkbox"]:checked');
                for(var i=0;i<chechboxHtml.length;i++){
                    if(i == chechboxHtml.length-1){
                        studentIds = studentIds + $(chechboxHtml[i]).val();
                        studentNames = studentNames + $(chechboxHtml[i]).attr('studentName');
                    }else{
                        studentIds = studentIds + $(chechboxHtml[i]).val() + ',';
                        studentNames = studentNames + $(chechboxHtml[i]).attr('studentName') + ',';
                    }
                }
                parent.window.frames["mainFrame"].selectPastStudentCallback(studentIds,studentNames);
            })
        });
        function page(n,s){
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#searchForm").submit();
            return false;
        }

        function checkedIds() {
            var ids = '';
            var elements = $("[name='checkbox']:checked");
            for (var  i = 0; i<elements.length;i++){
                if(i<elements.length-1){
                    ids = ids + $(elements[i]).val()+",";
                }else{
                    ids = ids + $(elements[i]).val();
                }
            }
            return ids;
        }

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
            })
        }

	</script>
</head>
<body>

<sys:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
	<tr>
		<th>
			<input type="checkbox" name="checkboxs">
		</th>
		<th>姓名</th>
		<th>性别</th>
		<th>手机号</th>
		<th>招聘老师</th>
	</tr>
	<tbody>
	<c:forEach items="${studentList}" var="student">
		<tr>
			<td>
				<input type="checkbox" name="checkbox" studentName="${student.name}" value="${student.id}">
			</td>
			<td>
					${student.name}
			</td>
			<td>
					${erp:sexStatusName(student.sex)}
			</td>
			<td>
					${student.phone}
			</td>
			<td>
					${student.teacher.name}
			</td>
		</tr>
	</c:forEach>
	</tbody>
</table>
<div class="pagination">${page}</div>
</body>
</html>