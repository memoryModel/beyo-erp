<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>学员信息</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
            jQueryCheckAll();
            $("input[name='closeWindows']").each(function () {
                $(this).click(function () {
                    top.$.jBox.close(true);
                });
            })
			$('#studentGraduat').click(function () {
                var ids = checkedIds();
                if(ids == '' || ids.length == 0){
                    return;
				}
				var classId = $('[name="classId"]').val();
				$.ajax({
					url:'${ctx}/school/class/studentGraduat',
                    type:"POST",
                    async:false,
                    data:{'ids':ids,'classId':classId},
					success:function(data){
					    if(data == 'success'){
                            top.$.jBox.close(true);
						}
					}
				});
            });
		});

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
	<input type="hidden" name="classId" value="${schoolClass.id}">
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
		<tr>
			<th>
				<input type="checkbox" name="checkboxs">
			</th>
			<th>学员姓名</th>
			<th>学号</th>
			<th>性别</th>
			<th>入班日期</th>
		</tr>
		</thead>
		<tbody>
		<c:forEach items="${studentList}" var="erpStudentEnroll" varStatus="">
			<tr>
				<td>
					<input type="checkbox" name="checkbox" value="${erpStudentEnroll.id}">
				</td>
				<td>
						${erpStudentEnroll.name}
				</td>
				<td>
						${erpStudentEnroll.studentNumber}
				</td>
				<td>
						${erp:sexStatusName(erpStudentEnroll.sex)}
				</td>
				<td>
						<fmt:formatDate value="${erpStudentEnroll.schoolClassStudents.applyTime}" pattern="yyyy-MM-dd"/>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="form-actions">

		<input id="studentGraduat" class="btn btn-primary" type="button" value="结 业"/>&nbsp;

		<input name="closeWindows" class="btn" type="button" value="返 回" />
	</div>
</body>
</html>