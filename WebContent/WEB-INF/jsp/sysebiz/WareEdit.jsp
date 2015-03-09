<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>仓库列表--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
</head>
<body>
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
	<div class="tab_warp main">
	<div class="dq_step">
		${path}
		<span class="opb lb op-area">
		<a href="<s:url action="ware_list" namespace="/sysebiz" />" >返回列表</a>
		</span>
	</div>
	<s:form id="editForm" name="editForm" cssClass="validForm" action="ware_add" namespace="/sysebiz" method="post" theme="simple">
	<div class="label_con">
	<s:if test="null != ware">
	<div class="label_main">
	       <div class="label_hang">
		         <div class="label_ltit">编号:</div>
		         <div class="label_rwb"><s:property value="ware.uuid" /> <s:hidden id="ware.uuid" name="ware.uuid" /></div>
	       	</div>
	 </div>
	</s:if>
	<div class="label_main">
	       <div class="label_hang">
		         <div class="label_ltit">仓库类型:</div>
		         <div class="label_rwben label_rwb">
	            	<s:select cssClass="selectKick" title="仓库类型" id="ware.ware_class" name="ware.ware_class" list="#{0:'普通库', 1:'藏酒库'}" value="1" require="required" controlName="仓库类型" />
	            </div>
	       	</div>
	 </div>
	 <div class="label_main">
	       <div class="label_hang">
		         <div class="label_ltit">仓库名称:</div>
		         <div class="label_rwben2">
		         <div class="label_rwb"><s:textfield id="ware.ware_name" name="ware.ware_name" title="仓库名称" require="required" cssClass="label_hang_linput validate[required,maxSize[100]]" /></div>
		         </div>
	       	</div>
	 </div>
	 <div class="label_main">
	       <div class="label_hang">
		         <div class="label_ltit">仓库地点:</div>
		         <div class="label_rwben2">
		         <div class="label_rwb"><s:textfield id="ware.address" name="ware.address" title="仓库地点" cssClass="label_hang_linput validate[maxSize[255]]" /></div>
		         </div>
	       	</div>
	 </div>
	 <div class="label_main">
        <div class="label_hang">
            <div class="label_ltit">简短描述:</div>
            <div class="label_rwbenx">
            	<s:textarea name="ware.short_note" cssStyle="width:50%;" rows="3" title="仓库简短描述" cssClass="label_hang_linput validate[maxSize[128]]" />
            </div>
        </div>
      </div>
      
      <div class="label_main">
        <div class="label_hang">
            <div class="label_ltit">仓库详细描述:</div>
            <div class="label_rwbenx">
            </div>
        </div>
        </div>
        <div class="label_main">
        	<div class="note_area">
        	<s:textarea name="ware.note" title="详细说明" cssClass="xheditorArea validate[maxSize[65535]]" />
        	</div>
        </div>
        <s:if test="null != ware">
        	<div class="label_main">
        		<div class="label_hang">
		            <div class="label_ltit">修改人:</div>
		            <div class="label_rwben">
		           <s:property value="ware.lm_user" /> <s:hidden name="ware.lm_user" />
		            </div>
	       		</div>
	       		<div class="label_hang">
		            <div class="label_ltit">修改时间:</div>
		            <div class="label_rwben" style="width:auto;">
		            <s:date name="ware.lm_time" format="yyyy-MM-dd HH:mm:ss" />
		            </div>
	       		</div>
        	</div>
	    </s:if>
	    <div class="label_main">
		<div class="label_hang">
            <div class="label_ltit">相关操作:</div>
            <div class="label_rwbenx">
            <span id="message"><s:property value="message" /></span>
            	
            	<s:if test="null == ware && 'add' == viewFlag">
				<s:submit id="add" name="add" value="确定" action="ware_add" cssClass="input-blue"/>
				</s:if>
				<s:elseif test="null != ware && 'mdy' == viewFlag">
				<s:submit id="save" name="save" value="保存" action="ware_save" cssClass="input-blue"/>
				<s:submit id="delete" name="delete" value="删除" action="ware_del" onclick="return isDel();" cssClass="input-red"/>
				</s:elseif>
				<input type="button" value="返回" onclick="linkurl('<s:url action="ware_list" namespace="/sysebiz" />');" />
				
            </div>
		</div>
		</div>
	</div>
	</s:form>
</div>
</div>
<s:action name="ref_foot" namespace="/manager" executeResult="true" />
</body>
</html>