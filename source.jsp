 <%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>作业评测</title>
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layuiadmin/layui/css/layui.css" media="all">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layuiadmin/style/admin.css" media="all">
</head>
<body>

  <div class="layui-fluid">
    <div class="layui-card">
      <div class="layui-form layui-card-header layuiadmin-card-header-auto">
         <div class="layui-form-item">
       	   <div class="layui-inline">
            <label class="layui-form-label">教师姓名</label>
            <div class="layui-input-block">
              <input type="text" name="name" placeholder="请输入" autocomplete="off" class="layui-input">
            </div>
          </div>
          <div class="layui-inline">
            <label class="layui-form-label">课程名称</label>
            <div class="layui-input-block">
              <input type="text" name="cou_name" placeholder="请输入" autocomplete="off" class="layui-input">
            </div>
          </div>
          <div class="layui-inline">
            <label class="layui-form-label">学生姓名</label>
            <div class="layui-input-block">
              <input type="text" name="stu_name" placeholder="请输入" autocomplete="off" class="layui-input">
            </div>
          </div>
          <div class="layui-inline">
            <button class="layui-btn layuiadmin-btn-useradmin" lay-submit lay-filter="LAY-user-front-search">
              <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>搜索
            </button>
          </div>
        </div>
      </div>
      
      <div class="layui-card-body">
        <div style="padding-bottom: 10px;">
<%--          <button class="layui-btn layuiadmin-btn-useradmin" data-type="batchdel">删除</button>--%>
<%--          <button class="layui-btn layuiadmin-btn-useradmin" data-type="add">添加</button>--%>
        </div>
        
        <table id="dg" lay-filter="dg"></table>
        
        <script type="text/html" id="line-btn">
          <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="score"><i class="layui-icon layui-icon-edit"></i>打分</a>
<%--          <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="edit"><i class="layui-icon layui-icon-edit"></i>编辑</a>--%>
<%--          <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del"><i class="layui-icon layui-icon-delete"></i>删除</a>--%>
        </script>
      </div>
    </div>
  </div>

  <script src="${pageContext.request.contextPath}/static/jq/jquery-1.8.2.min.js"></script>  
  <script src="${pageContext.request.contextPath}/static/plugins/layuiadmin/layui/layui.js"></script>  
  <script>
  
  layui.use(['table', 'form'], function(){
	  var form = layui.form;
	  var table = layui.table;
	  //实例
	  table.render({
	    elem: '#dg'
	    ,toolbar: true
	    ,url: '${pageContext.request.contextPath}/source?tea_id=41710020&type=3' //数据接口
	    ,cols: [[ //表头
	      {type: 'checkbox', fixed: 'left'}
	      ,{title: '序号', width:80, type:'numbers',fixed: 'left'}
	      ,{field: 'name', title: '教师姓名 ', width:100,fixed: 'left'}
	      ,{field: 'cou_name', title: '课程名称', width:100,fixed: 'left'}
	      ,{field: 'stu_name', title: '学生姓名', width:100,fixed: 'left'}
	      ,{field: 'work1', title: '分数1', width:80}
	      ,{field: 'work2', title: '分数2', width:80}
	      ,{field: 'work3', title: '分数3', width:80}
	      //,{field: 'sou_id', title: '作业资源Id', width:80}
	      // ,{field: 'sou_name', title: '作业资源名称', width:80}
	      ,{title: '作业1', width:80,
	    	 templet: function(d){
	    	    return '<a style="text-decoration:underline;" href="'+'${pageContext.request.contextPath}/upload/'+d.tea_id+'/'+d.cou_id+'/work1/'+d.stu_id+'.txt'+'" target="_blank">作业1</a>' ;
	    	 }
	      }
	      ,{title: '作业2', width:80,
		    	 templet: function(d){
		    	    return '<a style="text-decoration:underline;" href="'+'${pageContext.request.contextPath}/upload/'+d.tea_id+'/'+d.cou_id+'/work2/'+d.stu_id+'.txt'+'" target="_blank">作业2</a>' ;
		    	 }
		   }
	      ,{title: '作业3', width:80,
		    	 templet: function(d){
		    	    return '<a style="text-decoration:underline;" href="'+'${pageContext.request.contextPath}/upload/'+d.tea_id+'/'+d.cou_id+'/work3/'+d.stu_id+'.txt'+'" target="_blank">作业3</a>' ;
		    	 }
		  }
	      
	     ,{title: '打分', width: 150, align:'center', fixed: 'right', toolbar: '#line-btn'}
	    ]]
	    //,skin:'nob'//line （行边框风格）row （列边框风格）  nob （无边框风格）
	    ,even:true //若不开启隔行背景，不设置该参数即可
	    ,page: true //开启分页
	    ,limit: 10
	    ,height: 'full-220'
	    ,text: {none: '一条数据也没有^_^'}
	  });

	  //监听搜索
	  form.on('submit(LAY-user-front-search)', function(data) {
		var field = data.field;
		
		//执行重载
		table.reload('dg', {
			where : field
		});
      });
	  
	  //事件
	  var active = {
		  //删除
	      batchdel: function(){
	  
	      }
		 //添加
	      ,add: function(){
	 
	      }
		 
		 
		};
		//事件
	  
		//处理事件
	    $('.layui-btn.layuiadmin-btn-useradmin').on('click', function(){
	        var type = $(this).data('type');
	        active[type] ? active[type].call(this) : '';
	    });
	
	
	    //监听行工具条
	    table.on('tool(dg)', function(obj){
	      var data = obj.data;
	      
	      if(obj.event === 'score'){
		        var tr = $(obj.tr);
		        console.info(data.tea_id+':'+data.cou_id+':'+data.stu_id);
		        layer.open({
		          type: 2
		          ,title: '打分'
		          ,content: '${pageContext.request.contextPath}/info?action=toScore&tea_id='+data.tea_id+'&cou_id='+data.cou_id+'&stu_id='+data.stu_id
		          ,maxmin: true
		          ,area: ['500px', '450px']
		          ,btn: ['确定', '取消']
		          ,yes: function(index, layero){
		            var iframeWindow = window['layui-layer-iframe'+ index]
		            ,submitID = 'LAY-user-front-submit'
		            ,submit = layero.find('iframe').contents().find('#'+ submitID);
		           
		            //监听提交
		            iframeWindow.layui.form.on('submit('+ submitID +')', function(data){
		            	
		              //刷新弹出框的表单，保证动态设置的值生效
		              iframeWindow.layui.form.render();
		              
		              var field = data.field; //获取提交的字段
		              //提交 Ajax 成功后，静态更新表格中的数据
		               $.ajax({
				            type : "post",
				            url : "${pageContext.request.contextPath}/info?action=score",
				            data:data.field,
				            async : true,
				            cache : false,
				            dataType : 'json',
				            success : function(data) {
				            	
				                table.reload('dg'); //数据刷新
					            layer.close(index); //关闭弹层
					            layer.msg(data.msg);
				            },
				            error : function(data) {
				              alert("error:" + data.responseText);
				            }
				            
				         });
		            });  
		            
		            submit.trigger('click');
		          }
		          ,success: function(layero, index){
		            
		          }
		        });
		  }
	      
	      
	    });
	  	//监听行工具条
	  
	});
		</script>
</body>
<a style="text-decoration:underline;"></a>
</html>
