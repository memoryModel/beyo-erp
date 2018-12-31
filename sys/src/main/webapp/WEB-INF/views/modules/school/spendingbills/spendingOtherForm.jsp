<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>新增支出单</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {

        });
		function page(n,s){
			if(n) $("#pageNo").val(n);
			if(s) $("#pageSize").val(s);
			<%--$("#searchForm").attr("action","${ctx}/pro/schoolClass/info");--%>
			$("#searchForm").submit();
	    	return false;
	    }

		//确认单条收款记录
        /*function updateBill(billId) {
            $.ajax({
                type : 'post',
                url : '${ctx}/erp/receivableBill/updateBillStatus',
                data:{orderId:${erpReceivableBill.order.id},billId:billId},
                success : function(data) {
                    if (data && data.result == "success") {
                        location.href = '${ctx}/school/classPlan/list/';
                    } else {
                        window.location.reload();
                    }
                }
            })

        }


        //提交from表单  确认全部收款记录
        function submitSave() {

            $.ajax({
                type : 'post',
                url : '${ctx}/erp/receivableBill/updateBillStatus',
                data:{orderId:${erpReceivableBill.order.id}},
                success : function(data) {
                    if (data && data.result == "success") {
                        location.href = '${ctx}/school/classPlan/list/';
                    } else {
                        location.href = '${ctx}/school/classPlan/list/';
//                        window.location.reload();
                    }
                }
            })

        }*/

	</script>
</head>
<body>
	<div>
	<ul class="nav nav-tabs">
		<li class="active">
			<a href="">支出详情</a>
		</li>
	</ul></div><br/><div>

	<form:form id="inputForm" modelAttribute="orderRefund" action="${ctx}/erp/orderRefundPayBill/updatePayBill?billId=${orderRefund.id}&&orderId=${orderRefund.order.id}" method="post" class="form-horizontal">
		<form:hidden path="id"/>

		<table id="contentTable">
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">支出类别:</label>
						<div class="controls">
							<input value="" type="text" style="width:250px;"/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">支出科目:</label>
						<div class="controls">
							<input value="" type="text"  style="width:250px;"/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<div class="control-group">
						<label class="control-label">支出金额:</label>
						<div class="controls">
							<input value="" type="text"  style="width:250px;"/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">支出部门:</label>
						<div class="controls">
							<input value="" type="text" style="width:250px;"/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">支出人:</label>
						<div class="controls">
							<input value="" type="text" style="width:250px;"/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">支出确认人:</label>
						<div class="controls">
							<input value="" type="text" style="width:250px;"/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">支出确认时间:</label>
						<div class="controls">
							<input value="" type="text" style="width:250px;"/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td align="right">
					<shiro:hasPermission name="schoolleave:leave:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="确认支出"/>&nbsp;&nbsp;</shiro:hasPermission>
				</td>
				<td>
					<input id="btnCancel" class="btn" type="button" value="取消" onclick="history.go(-1)"/>
				</td>
			</tr>
		</table>
	</form:form>
</body>
</html>