<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>再委派客户列表</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }

        function selectDelegatesCallback(){
            window.location.reload(true);
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
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/crm/customer/againDelegateList">再委派客户</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="customer" action="${ctx}/crm/customer/againDelegateList" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>客户姓名：</label>
				<form:input path="name" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>客户编号：</label>
				<form:input path="code" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>手机号码：</label>
				<form:input path="phone" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>客户类别：</label>
				<form:select path="type" class="input-large " style="width:180px;">
					<form:option value="">请选择</form:option>
					<form:options items="${erp:customerTypeList()}"  itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li>
				<label>性别：</label>
				<form:select path="sex"  class="input-large">
					<form:option value="" label="------请选择------"/>
					<form:options items="${erp:sexStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>客户来源：</label>
				<sys:treeselect id="customerResource" name="customerResource.id" value="${customer.customerResource.id}"
								labelName="customerResource.customerName" labelValue="${customer.customerResource.customerName}"
								title="来源名称" url="/erp/customerResource/treeData" allowClear="true"/>
			</li>
			<li><label>添加时间：</label>
				<input name="startTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="<fmt:formatDate value="${customer.startTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/> -
				<input name="endTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="<fmt:formatDate value="${customer.endTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
			</li>
			<li><label>委派时间：</label>
				<input name="delegateStartTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="<fmt:formatDate value="${customer.delegateStartTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/> -
				<input name="delegateEndTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="<fmt:formatDate value="${customer.delegateEndTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
			</li>
			<li class="btns">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
				<input id="batchToCancel" class="btn btn-primary" type="button" value="批量委派跟进人"/>
			</li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<%--todo:批量导出--%>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>
					<input type="checkbox" name="checkboxs">
				</th>
				<th>客户编号</th>
				<th>客户姓名</th>
				<th>性别</th>
				<th>手机号码</th>
				<th>客户类别</th>
				<th>客户来源</th>
				<th>跟进人</th>
				<th>委派人</th>
				<th>委派次数</th>
				<th>撤回时间</th>
				<th>撤回类型</th>
				<th>撤回原因</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="customer">
			<tr>
				<td>
					<input type="checkbox" name="checkbox" value="${customer.id}">
				</td>
				<td>
						${customer.code}
				</td>
				<td>
					<a name="customerView" customerId="${customer.id}" href="javascript:;" >${customer.name}</a>

				</td>
				<td>
						${erp:sexStatusName(customer.sex)}
				</td>
				<td>
						${customer.phone}
				</td>
				<td>
						${erp:customerTypeName(customer.type)}
				</td>
				<td>
						${customer.customerResource.customerName}
				</td>
				<td>
						${customer.customerDelegateRecord.saleAdviserName.name}
				</td>
				<td>
						${customer.customerDelegateRecord.delegtatePersonName.name}
				</td>
				<td>
						${customer.customerDeleCount}
				</td>
				<td>
						<fmt:formatDate value="${customer.customerDelegateRecord.delegateTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
						${erp:getCancelTypeName(customer.customerDelegateRecord.cancelType)}
				</td>
				<td>
						${customer.customerDelegateRecord.cancelReason}
				</td>
				<td>
					<shiro:hasPermission name="crm:customer:form">
						<a name="delegateForm" id="${customer.id}" href="javascript:;">再次委派</a>
					</shiro:hasPermission>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
	<script type="text/javascript">
        $(document).find("a[name='customerView']").each(function () {
            var customerId = $(this).attr("customerId");
            $(this).click(function () {
                top.$.jBox("iframe:/crm/customer/info?id="+customerId+"&&tagFlag="+1,{
                    title:"客户信息 ",
                    width:1300,
                    height:768,
                    buttons:{}
                });
            });
        });

        $(document).ready(function() {
            jQueryCheckAll();
            $(document).find("a[name='delegateForm']").each(function () {
                var id = $(this).attr("id");
                $(this).click(function () {
                    top.$.jBox("iframe:/crm/customer/selectDelegate?id="+id,
                        {
                            title:"选择委派人",
                            width:500,
                            height:550,
                            buttons:{}
                        }
                    );
                });
            });

			//批量委派跟进人
            $('#batchToCancel').click(function () {
                var ids = checkedIds();
                if(ids == null || ids == ""){
                    return;
                }
                top.$.jBox("iframe:/crm/customer/batchToDelegateList?ids="+ids,{
                    title:"批量委派跟进人",
                    width:600,
                    height:300,
                    buttons:{},
                    closed:function () {
                        document.location.reload();
                    }
                });
            });
        });
	</script>
</body>
</html>