<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>上户信息管理</title>
	<meta name="decorator" content="default"/>
</head>
<body>
	<ul class="nav nav-tabs">
			<li>
				<a href="${ctx}/crm/dispatch/list">预约列表</a>
			</li>
			<li>
				<a href="${ctx}/crm/dispatch/list?statusFlag=1">待上户列表</a>
			</li>
			<li>
				<a href="${ctx}/crm/dispatch/list?statusFlag=2">服务中列表</a>
			</li>
			<li>
				<a href="${ctx}/crm/dispatch/list?statusFlag=3">待下户列表</a>
			</li>
			<li>
				<a href="${ctx}/crm/dispatch/list?statusFlag=4">已下户列表</a>
			</li>
		<li class="active">
			<a href="${ctx}/crm/dispatch/form?id=${dispatch.id}">预约上户${not empty dispatch.id?'修改':'添加'}</a>
		</li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="dispatch" action="${ctx}/crm/dispatch/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="order.id" id="orderId"/>
		<form:hidden path="orderItem.id" id="itemId"/>
		<form:hidden path="customer.id" id="customerId"/>
		<form:hidden path="skillNum" id="skillNum"/>
		<form:hidden path="usedNum" id="usedNum"/>
		<sys:message content="${message}"/>

		<div class="control-group">
			<label class="control-label">订单：</label>
			<div class="controls">
				<div class="input-append">
				<input id="selectOrder" name="selectOrder" type="text" readonly="readonly" class="input-large required"/>
				<a id="selectOrderHref" href="javascript:" class="btn">&nbsp;
					<i class="icon-search"></i>&nbsp;
				</a>
				</div>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>

		</div>
		<div class="control-group">
			<label class="control-label">服务项目：</label>

			<div class="controls" id="itemContent">

			</div>
		</div>
		<div class="control-group">
			<label class="control-label">预约上户时间：</label>
			<div class="controls">
				<input name="planStartTime" type="text" readonly="readonly" maxlength="20" class="required input-medium Wdate "
					value="<fmt:formatDate value="${dispatch.planStartTime}" pattern="yyyy-MM-dd HH:mm"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});" />
				<font color="red">*</font>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">预约下户时间：</label>
			<div class="controls">
				<input name="planEndTime" type="text" readonly="readonly" maxlength="20" class="required input-medium Wdate "
					   value="<fmt:formatDate value="${dispatch.planEndTime}" pattern="yyyy-MM-dd HH:mm"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});"/>
				<font color="red">*</font>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">地区：</label>
			<div class="controls">
				<sys:treeselect id="area" name="area.id" value="${dispatch.area.id}"
								labelName="area.name" labelValue="${dispatch.area.name}"
								title="区域" url="/sys/area/treeData" notAllowSelectParent="true" allowClear="true" cssClass="input-large required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">详细地址：</label>
			<div class="controls">
				<form:input path="serviceAddress" htmlEscape="false"  maxlength="1024" class="input-xxlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注：</label>
			<div class="controls">
				<form:textarea path="remark"  rows="4"  class="input-xxlarge " maxlength="1024"/>
				<%--<form:input path="remark" htmlEscape="false" rows="4" maxlength="1024" class="input-xxlarge "/>--%>
			</div>
		</div>
		<div class="form-actions">
			<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
	<script id="itemTemplate" type="text/template">
		<table id="contentTable" class="table table-striped table-bordered table-condensed" style="width: 70%">
			<thead>
			<th>
				订单编号
			</th>
			<th>
				商品名称
			</th>
			<th>
				服务项目
			</th>
			<th>
				购买数量
			</th>
			<th>
				服务次数
			</th>
			<th>
				预约次数
			</th>
			<th width="35%">
				操作
			</th>
			</thead>
			<tbody>
			{{#orderItemArray}}
			<tr>
				<td>
					<a name="viewOrder" orderId="{{order.id}}"  href="javascript:;">{{order.orderCode}}</a>
				</td>
				<td>
					{{product.title}}
				</td>
				<td>
					{{productSku.skill.skillName}}
				</td>
				<td>
					<%--{{productSku.skill.category}}--%>
					{{skillCount}}
				</td>
				<td>
					{{usedNum}}/{{serviceNum}}
				</td>
				<td>
					{{dispatchNum}}次
				</td>
				<td>
					<input id="selectOrderPlanId{{id}}" type="radio" name="selectOrderPlan"
						   itemId="{{id}}" skillCount="{{skillCount}}" num="{{num}}" skillCategory="{{productSku.skill.category}}"
						   		dispatchNum="{{dispatchNum}}" class="checkItem" /><span>预约上户</span>
				</td>
			</tr>
			{{/orderItemArray}}
			</tbody>
		</table>
	</script>
	<script type="text/javascript">
        var template;
        var itemArray;
        $(document).ready(function() {

            template = $("#itemTemplate").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");


            $("#inputForm").validate({
                submitHandler: function(form){
                    loading('正在提交，请稍等...');
                    form.submit();
                },
                errorContainer: "#messageBox",
                errorPlacement: function(error, element) {
                    $("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")){
                        error.appendTo(element.parent().parent());
                    }else if(element.is("input[name='selectOrder']")){
                            error.appendTo(element.parent());
					}else if(element.parent().is(".input-append")){
                            $(error).text("必填信息");
                            element.parents(".controls").append(error);
                    }else {
                        error.insertAfter(element);
                    }
                }
            });

            $.validator.addMethod("checkItem",function (value, element) {
                var selected = false;
                $("input[name='selectOrderPlan']").each(function () {
					if($(this).attr("checked") == "checked"){
                        selected = true;
                        return;
					}
                });
                return selected;//通过验证
            }, "请选择预约服务项目");

            $("#selectOrder,#selectOrderHref").click(function () {
                var orderId = $("#orderId").val();
                top.$.jBox.open("iframe:/crm/dispatch/selectOrder",
                    "选择订单",
                    1024,
                    550,
                    {
                        closed:function () {findOrderItem()},
                        ajaxData:{"id":orderId}
                    }
                );
            });
        });

        function selectOrderCallback(orderId,orderCode,customerId) {
			$("#orderId").val(orderId);
			$("#selectOrder").val(orderCode);
			$("#customerId").val(customerId);
            top.$.jBox.close(true);
        }

        function findOrderItem() {
            var orderId = $("#orderId").val();
            loading('正在加载，请稍等...');

            $.get("/crm/dispatch/findOrderItem",{"id":orderId},function (data) {

                if (data.status == "success"){
                    itemArray = data.orderItemList;
                    for(var i=0;i<itemArray.length;i++){
                        var obj = itemArray[i];
                        obj.skillCount = " ";
                        obj.serviceNum = obj.num;
                        console.info(obj.dispatchNum);
                        var category = obj.productSku.skill.category;
                        var measureWay = obj.product.measureWay;
                        if(measureWay==2){//打包
                            var sumCount = obj.num*obj.productSku.minStock;
						}else{
                            var sumCount = obj.num;
						}
                        if(category==2) {
                            obj.skillCount = sumCount+"天";
                            obj.usedNum = 0;
                            obj.serviceNum = 1;
                        }
						if(category==1) obj.skillCount = sumCount+"次";
					}

					showOrderItem();

                    closeLoading();
                }else{
                    loading('加载失败');
                    setTimeout("closeLoading()",2000);
                }
            }).error(function() {
                loading('加载失败');
                setTimeout("closeLoading()",2000);
            });
        }
        function showOrderItem(){
            //console.log(itemArray);
            $("#itemContent").empty();
            $("#itemContent").append(Mustache.render(template, {"orderItemArray":itemArray}));

            $(document).find("a[name='viewOrder']").each(function () {
                var orderId = $(this).attr("orderId");
                $(this).click(function () {
                    top.$.jBox("iframe:/erp/productOrder/view?id="+orderId,{
                        title:"查看订单",
                        width:1024,
                        height:600,
                        buttons:{}
                    });
                });
            });
            
            $("input[name='selectOrderPlan']").each(function () {
                var itemId = $(this).attr("itemId");
                var skillCount = $(this).attr("skillCount");
                var num = $(this).attr("num");
                //var canRepetition = $(this).attr("canRepetition");
                //var usedNum = $(this).attr("usedNum");
                var skillCategory = $(this).attr("skillCategory");
                var dispatchNum = $(this).attr("dispatchNum");
                var skillNum = parseInt(skillCount);
				$(this).click(function () {
					$("#itemId").val(itemId);
					if(skillCategory == 2) $("#skillNum").val(skillNum);
                    if(skillCategory == 1) $("#skillNum").val(1);
                    //$("#usedNum").val(usedNum);
                });
				if(skillCategory == 1 && dispatchNum==skillNum) $(this).attr("disabled","disabled");
				if(skillCategory == 2 && dispatchNum>0) $(this).attr("disabled","disabled");
            });
		}

	</script>
</body>
</html>