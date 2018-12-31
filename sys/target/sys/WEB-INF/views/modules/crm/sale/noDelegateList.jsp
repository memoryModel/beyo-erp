
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>销售线索管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
        $(document).ready(function() {
            jQueryCheckAll();
            //批量委派负责人
            $('#batchToDelegate').click(function () {
                var ids = checkedIds();
                if(ids == null || ids == ""){
                    return;
                }
                top.$.jBox("iframe:/crm/sale/batchToDelegate?ids="+ids,{
                    title:"委派销售顾问",
                    width:600,
                    height:300,
                    buttons:{},
                    closed:function () {
                        document.location.reload();
                    }
                });
            })

            $(document).find("a[name='delegateForm']").each(function () {
                var id = $(this).attr("id");
                $(this).click(function () {
                    top.$.jBox("iframe:/crm/sale/selectDelegate?id="+id,
                        {
                            title:"选择委派人",
                            width:500,
                            height:550,
                            buttons:{}
                        }
                    );
                });
            });
            $(document).find("a[name='customerView']").each(function () {
                var customerId = $(this).attr("customerId");
                $(this).click(function () {
                    top.$.jBox("iframe:/crm/customer/info?id="+customerId+"&&tagFlag="+1,{
                        title:"客户信息 ",
                        width:1100,
                        height:768,
                        buttons:{}
                    });
                });
            });


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

        function selectDelegatesCallback(){
            window.location.reload(true);
        }
	</script>
</head>
<body>
<ul class="nav nav-tabs">
	<li class="active"><a href="${ctx}/crm/sale/list?delegateStatus=0">待指派线索列表</a></li>
</ul>
<form:form id="searchForm" modelAttribute="sale" action="${ctx}/crm/sale/list?delegateStatus=0" method="post" class="breadcrumb form-search">
	<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
	<ul class="ul-form">
		<li><label>线索来源：</label>
			<sys:treeselect id="customerResource" name="customerResource.id" value="${sale.customerResource.id}"
							labelName="customerResource.customerName" labelValue="${sale.customerResource.customerName}"
							title="来源名称" url="/erp/customerResource/treeData" cssClass="required" allowClear="true"/>
		</li>
		<li>
			<label>意向业务：</label>
			<form:select path="serviceTypeId" class="input-medium">
				<form:option value="">请选择</form:option>
				<form:options items="${erp:getCommonsTypeList(59)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
			</form:select>
		</li>
		<li><label>意向门店：</label>

		</li>
		<li><label>vip客户：</label>
			<form:select path="vipFlag" class="input-medium">
				<form:option value="">请选择</form:option>
				<form:options items="${erp:findVipFlagList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
			</form:select>
		</li>
		<li><label>重要程度：</label>
			<form:select path="importantDegree" class="input-medium">
				<form:option value="">请选择</form:option>
				<form:options items="${erp:getCommonsTypeList(54)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
			</form:select>
		</li>
		<li><label>获取人：</label>
			<sys:treeselect id="clueAccessId" name="clueAccessName.id" value="${sale.clueAccessName.id}"
							labelName="clueAccessName.name" labelValue="${sale.clueAccessName.name}"
							title="用户" url="/sys/office/treeData?type=3" notAllowSelectParent="true" allowClear="true"/>
		</li>
		<li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;预计消费时间：<li/>
			<input name="startPlanConsumptionTime" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
				   value="<fmt:formatDate value="${sale.startPlanConsumptionTime}" pattern="yyyy-MM-dd"/>"
				   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>-
			<input name="endPlanConsumptionTime" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
				   value="<fmt:formatDate value="${sale.endPlanConsumptionTime}" pattern="yyyy-MM-dd"/>"
				   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
		</li>
		<li><label>创建人：</label>
			<sys:treeselect id="createUser" name="createUserName.id" value="${sale.createUserName.id}"
							labelName="createUserName.name" labelValue="${sale.createUserName.name}"
							title="用户" url="/sys/office/treeData?type=3" notAllowSelectParent="true" allowClear="true"/>
		</li>

		<li><label>创建时间：</label>
			<input name="startTime" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
				   value="<fmt:formatDate value="${sale.startTime}" pattern="yyyy-MM-dd"/>"
				   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>-
			<input name="endTime" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
				   value="<fmt:formatDate value="${sale.endTime}" pattern="yyyy-MM-dd"/>"
				   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/></li>
		<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
			<input id="batchToDelegate" class="btn btn-primary" type="button" value="委派负责人"/>
		</li>
		<li class="clearfix"></li>
	</ul>
</form:form>
<sys:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
	<thead>
	<tr>
		<th>
			<input type="checkbox" name="checkboxs">
		</th>
		<th>客户名称</th>
		<th>意向业务</th>
		<th>意向门店</th>
		<th>线索来源</th>
		<th>重要程度</th>
		<th>VIP客户</th>
		<th>获取人</th>
		<th>预计消费时间</th>
		<th>创建时间</th>
		<th>创建人</th>
		<th>操作</th>
	</tr>
	</thead>
	<tbody>
	<c:forEach items="${page.list}" var="crmSale">
		<tr>
			<td>
				<input type="checkbox" name="checkbox" value="${crmSale.id}">
			</td>
			<td>
				<a name="customerView" customerId="${crmSale.customer.id}" href="javascript:;" >${crmSale.customer.name}</a>
			</td>
			<td>
					${erp:getCommonsTypeName(crmSale.serviceTypeId)}
			</td>
			<td>
				意向门店
			</td>
			<td>
					${crmSale.customerResource.customerName}
			</td>
			<td>
					${erp:getCommonsTypeName(crmSale.importantDegree)}
			</td>
			<td>
				<c:if test="${crmSale.vipFlag == 0}">
					是
				</c:if>
				<c:if test="${crmSale.vipFlag == 1}">
					否
				</c:if>
			</td>
			<td>
					${crmSale.clueAccessName.name}
			</td>
			<td>
				<fmt:formatDate value="${crmSale.planConsumptionTime}" pattern="yyyy-MM-dd HH:mm"/>
			</td>
			<td>
				<fmt:formatDate value="${crmSale.createTime}" pattern="yyyy-MM-dd HH:mm"/>
			</td>
			<td>
					${crmSale.createUserName.name}
			</td>
			<td>
				<shiro:hasPermission name="crm:sale:saleInfo"><a href="${ctx}/crm/sale/saleInfo?id=${crmSale.id}&&delegateStatus=${crmSale.delegateStatus}">查看</a></shiro:hasPermission>
				<a name="delegateForm" id="${crmSale.id}" href="javascript:;">委派</a>&nbsp;&nbsp;
			</td>
		</tr>
	</c:forEach>
	</tbody>
</table>
<div class="pagination">${page}</div>
</body>
</html>