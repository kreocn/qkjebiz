<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="tab_right">
		<div class="tab_warp main">
			<div id="result">
				<div class="itablemdy">
					<div class="itabletitle">(实时)潜在客户回访报表</div>
					<div class="ilistsearch">
						<form id="simple_search" name="simple_search" action="\rpt/simple" method="get">
							<table class="ilisttable" id="serach_table" width="100%" border="1" cellspacing="0" cellpadding="0" bordercolor="#8B8B8B">
								<tr>
									<td class="firstRow">月份:</td>
									<td class="secRow"><select name="sdate"><option value="">请选择</option>
											<option value="2014-04-26">2014-04</option>
											<option value="2014-05-26">2014-05</option>
											<option value="2014-06-26">2014-06</option>
											<option value="2014-07-26">2014-07</option>
											<option value="2014-08-26">2014-08</option>
											<option value="2014-09-26">2014-09</option>
											<option value="2014-10-26">2014-10</option>
											<option value="2014-11-26" selected="selected">2014-11</option>
											<option value="2014-12-26">2014-12</option>
											<option value="2015-01-26">2015-01</option>
											<option value="2015-02-26">2015-02</option>
											<option value="2015-03-6">2015-03</option></select></td>
									<td class="firstRow"></td>
									<td class="secRow"></td>
								</tr>
								<tr>
									<td colspan="4" class="buttonarea"><input name="initClassName" type="hidden" value="CustomReply" /><input type="submit" value="查询" /><input type="reset" value="重置" /></td>
								</tr>
							</table>
						</form>
					</div>
					<table class="ilisttable" id="table1" width="100%" border="1" cellspacing="0" cellpadding="0" bordercolor="#8B8B8B">
						<tr>
							<th>部门名称</th>
							<th>总客户数</th>
							<th>零 回 访<br />总客户数
							</th>
							<th>本月新增<br />客 户 数
							</th>
							<th>未回访新增<br />客 户 数
							</th>
							<th>新增客户<br />回访率(%)
							</th>
							<th>本月回访<br />客 户 数
							</th>
							<th>本 月<br />总回访数
							</th>
							<th>新客户<br />回访数
							</th>
							<th>活 跃<br />客户数
							</th>
							<th>活跃客户<br />回访率(%)
							</th>
							<th>人 均<br />回访数
							</th>
						</tr>
						<tr class="oddStyle">
							<td>北京销售部</td>
							<td>4</td>
							<td>0</td>
							<td>0</td>
							<td>0</td>
							<td>0.00</td>
							<td>3</td>
							<td>6</td>
							<td>0</td>
							<td>3</td>
							<td>100.00</td>
							<td>0.38</td>
						</tr>
						<tr class="evenStyle">
							<td>河南办事处</td>
							<td>60</td>
							<td>0</td>
							<td>0</td>
							<td>0</td>
							<td>0.00</td>
							<td>5</td>
							<td>4</td>
							<td>0</td>
							<td>5</td>
							<td>100.00</td>
							<td>1.00</td>
						</tr>
						<tr class="oddStyle">
							<td>江苏办事处</td>
							<td>68</td>
							<td>0</td>
							<td>0</td>
							<td>0</td>
							<td>0.00</td>
							<td>9</td>
							<td>6</td>
							<td>0</td>
							<td>9</td>
							<td>100.00</td>
							<td>2.00</td>
						</tr>
						<tr class="evenStyle">
							<td>陕西办事处</td>
							<td>7</td>
							<td>0</td>
							<td>0</td>
							<td>0</td>
							<td>0.00</td>
							<td>0</td>
							<td>0</td>
							<td>0</td>
							<td>0</td>
							<td>0.00</td>
							<td>0.00</td>
						</tr>
						<tr class="oddStyle">
							<td>山东办事处</td>
							<td>45</td>
							<td>0</td>
							<td>0</td>
							<td>0</td>
							<td>0.00</td>
							<td>2</td>
							<td>2</td>
							<td>0</td>
							<td>2</td>
							<td>100.00</td>
							<td>0.50</td>
						</tr>
						<tr class="evenStyle">
							<td>安徽办事处</td>
							<td>2</td>
							<td>0</td>
							<td>0</td>
							<td>0</td>
							<td>0.00</td>
							<td>0</td>
							<td>0</td>
							<td>0</td>
							<td>0</td>
							<td>0.00</td>
							<td>0.00</td>
						</tr>
						<tr class="oddStyle">
							<td>湖南/四川/重庆办事处</td>
							<td>9</td>
							<td>3</td>
							<td>0</td>
							<td>0</td>
							<td>0.00</td>
							<td>3</td>
							<td>0</td>
							<td>0</td>
							<td>3</td>
							<td>100.00</td>
							<td>0.00</td>
						</tr>
						<tr class="evenStyle">
							<td>广东办事处</td>
							<td>16</td>
							<td>0</td>
							<td>0</td>
							<td>0</td>
							<td>0.00</td>
							<td>0</td>
							<td>0</td>
							<td>0</td>
							<td>0</td>
							<td>0.00</td>
							<td>0.00</td>
						</tr>
						<tr class="oddStyle">
							<td>湖北/浙江办事处</td>
							<td>20</td>
							<td>3</td>
							<td>0</td>
							<td>0</td>
							<td>0.00</td>
							<td>6</td>
							<td>6</td>
							<td>0</td>
							<td>6</td>
							<td>100.00</td>
							<td>1.50</td>
						</tr>
						<tr class="evenStyle">
							<td>东北办事处</td>
							<td>38</td>
							<td>1</td>
							<td>8</td>
							<td>0</td>
							<td>100.00</td>
							<td>11</td>
							<td>14</td>
							<td>11</td>
							<td>11</td>
							<td>100.00</td>
							<td>3.50</td>
						</tr>
						<tr class="oddStyle">
							<td>云南/贵州办事处</td>
							<td>4</td>
							<td>0</td>
							<td>0</td>
							<td>0</td>
							<td>0.00</td>
							<td>0</td>
							<td>0</td>
							<td>0</td>
							<td>0</td>
							<td>0.00</td>
							<td>0.00</td>
						</tr>
						<tr class="evenStyle">
							<td>河北/天津办事处</td>
							<td>16</td>
							<td>0</td>
							<td>2</td>
							<td>0</td>
							<td>100.00</td>
							<td>5</td>
							<td>5</td>
							<td>2</td>
							<td>5</td>
							<td>100.00</td>
							<td>2.50</td>
						</tr>
						<tr class="oddStyle">
							<td>山西办事处</td>
							<td>15</td>
							<td>0</td>
							<td>0</td>
							<td>0</td>
							<td>0.00</td>
							<td>0</td>
							<td>0</td>
							<td>0</td>
							<td>0</td>
							<td>0.00</td>
							<td>0.00</td>
						</tr>
					</table>
					<div style='color: #025;''>
						<hr />
						<b>名词解释</b><br />总客户数: 该办事处所有的客户总数<br />零回访总客户数: 无回访记录的客户总数<br />本月新增客户数: 本月新增加的客户数量<br />未回访新增客户数: 无回访记录的本月新增客户数<br />新增客户回访率(%): [已回访新增客户数]/[本月新增客户数]<br />本月回访客户数: 本月回访的客户总数<br />本月回访总数: 本月回访的次数<br />新客户回访数: 对本月新增客户进行回访的次数<br />活跃客户数: 3个月内有回访记录的客户数(含本月)<br />活跃客户回访率: [本月回访客户数]/[活跃客户数]<br />人均回访数:
						[本月回访总数]/[部门人数]<br />
						<div></div>
					</div>
				</div>
			</div>
			</div>
			</div>
</body>
</html>