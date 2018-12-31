<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>已通知面试列表</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
            jqueryCheckAll();

            //批量确认面试
            $("#batchAffirmInterview").click(function(){
                var ids = checkedIds();
                if (ids == null || ids ==''){
                    return;
                }
                top.$.jBox("iframe:/crm/interview/affirmInterview?ids="+ids,{
                    title:"确认面试",
                    width:500,
                    height:400,
                    buttons:{},
                    closed:function () {
                        document.location.reload();
                    }
                });
            })

            //批量放弃面试
            $("#batchAffirmInterview").click(function(){
                var ids = checkedIds();
                if (ids == null || ids ==''){
                    return;
                }
                top.$.jBox("iframe:/crm/interview/abandonInterview?ids="+ids,{
                    title:"确认面试",
                    width:500,
                    height:400,
                    buttons:{},
                    closed:function () {
                        document.location.reload();
                    }
                });
            })

			//点击复选框时检查计划状态是否为待确认
			$('input[name="checkbox"]').each(function () {
				$(this).click(function () {
					var interviewStatus = $(this).attr('interviewStatus');
                	if(interviewStatus != 0 || interviewStatus == '' || interviewStatus == undefined){
                       alert("该人员已确认面试或者已放弃面试，请选择其他人员进行操作");
                	    $(this).attr("checked",false);
					}
				});
            });
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

        function jqueryCheckAll(){
            var checkAll = $('[name=checkboxs]');
            var items = $('[name=checkbox]');

            checkAll.click(function(){
                if ($(this).attr("checked")){
                    items.each(function(){
                        var interviewStatus = $(this).attr('interviewStatus');
                        if(interviewStatus != 0){
                            items.attr("checked",false);
                            checkAll.attr("checked",false);
                            alert("当前页中有已面试或者已取消面试的人员，不能使用全选功能");
                            return false;
                        }else{
                            $(this).attr("checked",true);
						}
					})
				}else{
                    items.each(function(){
                        items.attr("checked",false);
					})
				}
			})
            items.click(function(){
                checkAll.attr("checked",$('[name="checkbox"]:checked').length == items.length ? true : false);
			})
        }

        function checkedIds(){
            var ids = '';
            var checkedIds = $('[name="checkbox"]:checked');
            for (var i = 0; i<checkedIds.length; i++){
                if (i<checkedIds.length-1){
                    ids = ids + $(checkedIds[i]).val()+",";
				}else{
                    ids = ids + $(checkedIds[i]).val();
				}
			}
			return ids;
		}

	</script>
</head>
<body>
<ul class="nav nav-tabs">
	<li class="active"><a href="${ctx}/crm/interview/informList">已通知列表</a></li>
</ul><br/>
<form:form id="searchForm" modelAttribute="interview" action="${ctx}/crm/interview/informList" method="post" class="breadcrumb form-search">
	<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
	<ul class="ul-form">
		<li><label>姓名：</label>
			<form:input path="employee.name" htmlEscape="false" maxlength="20" class="input-medium"/>
		</li>
		<li><label>手机号码：</label>
			<form:input path="employee.phone" htmlEscape="false" maxlength="20" class="input-medium"/>
		</li>
		<li>
			<label>来源：</label>
			<sys:treeselect id="customerResource" name="customerResource.id" value="${employee.customerResource.id}"
							labelName="customerResource.customerName" labelValue="${employee.customerResource.customerName}"
							title="来源名称" url="/erp/customerResource/treeData"  allowClear="true"/>
		</li>
		<li><label>性别：</label>
			<form:select path="employee.sex" class="input-medium ">
				<form:option value="" label="------请选择------"/>
				<form:options items="${erp:sexStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
			</form:select>
		</li>

		<li>&nbsp;&nbsp;&nbsp;计划面试时间：
			<input name="startInterviewTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
				   value="<fmt:formatDate value="${interview.startInterviewTime}" pattern="yyyy-MM-dd"/>"
				   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>至
			<input name="endInterviewTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
				   value="<fmt:formatDate value="${interview.endInterviewTime}" pattern="yyyy-MM-dd"/>"
				   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
		</li>
		<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<%--<li class="clearfix"></li>--%>
	</ul>
</form:form>
<sys:message content="${message}"/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input id="batchAffirmInterview" class="btn btn-primary" type="button" value="批量确认面试"/>&nbsp;&nbsp;&nbsp;
<input id="batchAbandonInterview" class="btn btn-primary" type="button" value="批量放弃面试"/>
<p></p>

<table id="contentTable" class="table table-striped table-bordered table-condensed">
	<thead>
	<tr>
		<th><input type="checkbox" name="checkboxs"></th>
		<th>姓名</th>
		<th>性别</th>
		<th>手机号码</th>
		<th>工种</th>
		<th>来源</th>
		<th>面试人</th>
		<th>计划面试时间</th>
		<th>计划状态</th>
		<th>计划添加人</th>
		<th>计划添加时间</th>
		<th>操作</th>
	</tr>

	</thead>
	<tbody>
	<c:forEach items="${page.list}" var="interview">
		<tr>
			<td><input type="checkbox" name="checkbox" interviewStatus="${interview.interviewStatus}" value="${interview.id}"> </td>
			<td>
					${interview.employee.name}
			</td>
			<td>
					${erp:sexStatusName(interview.employee.sex)}
			</td>
			<td>
					${interview.employee.phone}
			</td>
			<td>
				<c:forEach items="${interview.employee.getProfessionList()}" var="occId" varStatus="length">
					<c:if test="${length.index!=0}">
						,
					</c:if>
					${erp:getCommonsTypeName(occId)}
				</c:forEach>
			</td>
			<td>
					${interview.customerResource.customerName}
			</td>
			<td>
					${interview.user.name}
			</td>
			<td>
					<fmt:formatDate value="${interview.planInterviewTime}" pattern="yyyy-MM-dd HH:mm"/>
			</td>
			<td>
					${erp:interviewPlanName(interview.interviewStatus)}
			</td>
			<td>
					${interview.addPlanUser.name}
			</td>
			<td>
					<fmt:formatDate value="${interview.createTime}" pattern="yyyy-MM-dd HH:mm"/>
			</td>
			<td>
				<c:if test="${interview.interviewStatus == 0}">
					<a interviewId="${interview.id}" name="affirmInterview" href="javascript:;">确认面试</a>&nbsp;&nbsp;
					<a interviewId="${interview.id}" name="abandonInterview" href="javascript:;">放弃面试</a>
				</c:if>
				<c:if test="${interview.interviewStatus == 1 || interview.interviewStatus == 2}">
					<a interviewId="${interview.id}" name="examineInterview" href="javascript:;">查看</a>
				</c:if>
			</td>
		</tr>
	</c:forEach>
	</tbody>
	</table>
	<div class="pagination">${page}</div>

	<script type="text/javascript">
		$(document).find("a[name = 'affirmInterview']").each(function () {
			var interviewId = $(this).attr("interviewId");
			$(this).click(function(){
                top.$.jBox("iframe:/crm/interview/affirmInterview?id="+interviewId,{
                    title:"确认面试",
                    width:500,
                    height:400,
                    buttons:{}
                });
			});
        });

		$(document).find("a[name = 'abandonInterview']").each(function() {
            var interviewId = $(this).attr("interviewId");
            $(this).click(function(){
                top.$.jBox("iframe:/crm/interview/abandonInterview?id="+interviewId,{
                    title:"放弃面试",
                    width:700,
                    height:400,
                    buttons:{}
                });
            });
		})

        $(document).find("a[name = 'examineInterview']").each(function() {
            var interviewId = $(this).attr("interviewId");
            $(this).click(function(){
                top.$.jBox("iframe:/crm/interview/examineInterview?id="+interviewId,{
                    title:"面试计划详情",
                    width:1000,
                    height:500,
                    buttons:{}
                });
            });
        })
	</script>
</body>
</html>