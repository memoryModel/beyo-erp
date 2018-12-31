<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
<html>
<body>
<script type="text/javascript">
    $(document).ready(function() {

    });

    function page(n,s){
        $("#pageNo").val(n);
        $("#pageSize").val(s);
        $("#searchForm").submit();
        return false;
    }

    function selectOrderStudent(orderId,id,name,number,sex,phone,IdCard,status,flag,className,lessonName,tuitionAmount,payType,realBeginTime,applyTime,classStatus,orderStatus,miscellaneousAmount,depositAmount,insuranceAmount,contractNumber){
        top.$.jBox.confirm('确认要选择该学生吗？','系统提示',function(v,h,f) {
			if (v == 'ok') {
				parent.window.frames["mainFrame"].selectStudentback(orderId,id,name,number,sex,phone,IdCard,status,flag,className,lessonName,tuitionAmount,payType,realBeginTime,applyTime,classStatus,orderStatus,miscellaneousAmount,depositAmount,insuranceAmount,contractNumber);
				top.$.jBox.close(true);
			}
		},{buttonsFocus:1, closed:function(){
            if (typeof closed == 'function') {
                closed();
            }
        }});
    }

</script>
<table id="scheduleTable" class="table table-striped table-bordered table-condensed">
</table>

<form:form id="searchForm" modelAttribute="order" action="${ctx}/erp/ErpInvoiceApply/selectOrderStudent" method="post" class="breadcrumb form-search">
	<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
	<ul class="ul-form">

		<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
		<li class="clearfix"></li>
	</ul>
</form:form>
<sys:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
	<thead>
	<tr>
		<th>姓名</th>
		<th>学号</th>
		<th>性别</th>
		<th>手机号</th>
		<th>身份证号</th>
		<th>学员状态</th>
		<th>操作</th>
	</tr>
	</thead>
	<tbody>
	<c:forEach items="${page.list}" var="order">
		<tr>
			<td>
				${order.erpStudentEnroll.name != null ? order.erpStudentEnroll.name : order.employee.name}
			</td>
			<td>
				${order.erpStudentEnroll.name !=null ? order.erpStudentEnroll.studentNumber : order.employee.code}
			</td>
			<td>
				${order.erpStudentEnroll.name !=null ? order.erpStudentEnroll.sex : order.employee.sex}
			</td>
			<td>
				${order.erpStudentEnroll.name !=null ? order.erpStudentEnroll.phone : order.employee.phone}
			</td>
			<td>
				${order.erpStudentEnroll.name !=null ? order.erpStudentEnroll.stuNumber : order.employee.idcard}
			</td>
			<td>
				${order.erpStudentEnroll.name !=null ? order.erpStudentEnroll.studentStatus : order.employee.status}
			</td>

			<td>
				<a id="btnSelect" onclick="selectOrderStudent('${order.id}','${order.erpStudentEnroll.id != null ? order.erpStudentEnroll.id : order.employee.id}'
						,'${order.erpStudentEnroll.name != null ? order.erpStudentEnroll.name : order.employee.name}'
						,'${order.erpStudentEnroll.name !=null ? order.erpStudentEnroll.studentNumber : order.employee.code}'
						,'${order.erpStudentEnroll.name !=null ? order.erpStudentEnroll.sex : order.employee.sex}'
						,'${order.erpStudentEnroll.name !=null ? order.erpStudentEnroll.phone : order.employee.phone}'
						,'${order.erpStudentEnroll.name !=null ? order.erpStudentEnroll.stuNumber : order.employee.idcard}'
						,'${order.erpStudentEnroll.name !=null ? order.erpStudentEnroll.studentStatus : order.employee.status}'
						,'${order.erpStudentEnroll.name !=null ? 0 : 1 }','${order.erpStudentEnroll.schoolClassStudents.schoolClass.className}',
						'${order.erpStudentEnroll.schoolClassStudents.schoolClass.schoolClassToLesson.schoolClassLesson.lessonName}',
						'${order.erpStudentEnroll.schoolClassStudents.schoolClass.tuitionAmount}','${order.payType}',
						'${order.erpStudentEnroll.schoolClassStudents.schoolClass.realBeginTime}','${order.erpStudentEnroll.applyTime}',
						'${order.erpStudentEnroll.schoolClassStudents.schoolClass.status}','${order.status}',
						'${order.erpStudentEnroll.schoolClassStudents.schoolClass.miscellaneousAmount}','${order.erpStudentEnroll.schoolClassStudents.schoolClass.depositAmount}',
						'${order.erpStudentEnroll.schoolClassStudents.schoolClass.insuranceAmount}','${order.contractNumber}')"
				   href="javascript:; ">选择开票</a>
			</td>
		</tr>

	</c:forEach>
	</tbody>
</table>
<div class="pagination">${page}</div>
</body>
</html>