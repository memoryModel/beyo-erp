function getRootPath(){
    //获取当前网址，如： http://localhost:8083/uimcardprj/share/meun.jsp
    var curWwwPath=window.document.location.href;
    //获取主机地址之后的目录，如： /uimcardprj/share/meun.jsp
    var pathName=window.document.location.pathname;
    var pos=curWwwPath.indexOf(pathName);
    //获取主机地址，如： http://localhost:8083
    var localhostPath=curWwwPath.substring(0,pos);
    if(pathName == "/"){
        var path = curWwwPath.substring(0,curWwwPath.length-1);
        return path;
    }else{
        //获取带"/"的项目名，如：/uimcardprj
        var projectName=pathName.substring(0,pathName.substr(1).indexOf('/')+1);
        return(localhostPath+projectName);
    }
}

/**
 *异步加载数据来源信息
 */
$(function(){
    var trHtml = $('tr[createUser][id]');
    if(trHtml.length <= 0 ){
        return;
    }
    var createUsers = '';
    var ids = '';
    for(var i = 0;i<trHtml.length;i++){
        var trCreateUser = $(trHtml[i]).attr('createUser');
        var trId = $(trHtml[i]).attr('id');
        if(trCreateUser == undefined || trCreateUser == '' || trCreateUser.length <= 0){
            continue;
        }
        if(i == (trHtml.length - 1)){
            createUsers = createUsers + trCreateUser;
            ids = ids + trId;
        }else{
            createUsers = createUsers + trCreateUser + ',';
            ids = ids + trId + ',';
        }
    }
    $.ajax({
        url:'/sys/office/getOfficeNames',
        type:'post',
        async: false,
        data:{'createUsers':createUsers,'ids':ids},
        success:function(data){
            var thHTML = data[0].thHTML;
            $('thead tr').append(thHTML);
            for(var i = 0;i<data.length;i++){
                var id = data[i].id;
                var tdHTML = data[i].tdHTML;
                $('tr[id='+id+']').append(tdHTML);
            }
        }
    })
})