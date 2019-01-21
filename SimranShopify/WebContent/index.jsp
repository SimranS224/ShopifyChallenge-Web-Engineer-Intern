<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<!--meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"-->
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>2 Column Layout &mdash; Left Menu with Header &amp; Footer</title>
		<style type="text/css">
		
			body {
				margin:0;
				padding:0;
				font-family: Sans-Serif;
				line-height: 1.5em;
			}
			
			#header {
				background: #ccc;
				height: 100px;
			}
			
			#header h1 {
				margin: 0;
				padding-top: 15px;
			}
			
			main {
				padding-bottom: 10010px;
				margin-bottom: -10000px;
				float: left;
				width: 100%;
			}
			
			#nav {
				padding-bottom: 10010px;
				margin-bottom: -10000px;
				float: left;
				width: 230px;
				margin-left: -100%;
				background: #eee;
			}
			
			#footer {
				clear: left;
				width: 100%;
				background: #ccc;
				text-align: center;
				padding: 4px 0;
			}
	
			#wrapper {
				overflow: hidden;
			}
						
			#content {
				/*margin-left: 230px; /* Same as 'nav' width */
			}
			
			.innertube {
				margin: 15px; /* Padding for content */
				margin-top: 0;
			}
		
			p {
				color: #555;
			}
	
			nav ul {
				list-style-type: none;
				margin: 0;
				padding: 0;
			}
			
			nav ul a {
				color: darkgreen;
				text-decoration: none;
			}
			
			#textboxid
			{
				width:100%;
			    height:50px;
			    font-size:14pt;
			}
		
		</style>
		<%
			String rSubmitType = "";
			String rSubmitValue = "";
			String rSearchText = "";
			
			rSubmitType = request.getParameter("submittype");
			rSubmitValue = request.getParameter("submitvalue");
			if (request.getParameter("searchtext") != null && request.getParameter("searchtext").trim().length() > 0) {
				rSearchText = request.getParameter("searchtext");
			}
		%>

		
		<script type="text/javascript">
			var currST = "<%=rSearchText%>";
			
			function ChkForm(pForm) {
				var retVal = true;
				
				if (pForm.searchtextbox.value.trim().length == 0) {
					alert("Please enter Search Criteria....");
					retVal = false;
				}
				
				pForm.submittype.value = "";
				pForm.submitvalue.value = "";

				pForm.searchtext.value = pForm.searchtextbox.value;
								
				return retVal;
			}
			
			
			   /*$('#searchimgid').click(function(){
				      //$('#myform').submit();
				      alert(100);
				});*/
			function searchbclick() {
				var retVal = true;
				
				if (document.forms[0].searchtextbox.value.trim().length == 0) {
					alert("Please enter Search Criteria....");
					retVal = false;
				}
				
				document.forms[0].searchtext.value = document.forms[0].searchtextbox.value;
				if (retVal) {
					document.forms[0].submittype.value = "";
					document.forms[0].submitvalue.value = "";
					document.forms[0].submit();
				}
			}
				
			function setstarclick(pFlag, pTitle) {
				document.forms[0].searchtext.value = currST;
				if (pFlag == 1) {		//Grey to Green
					document.forms[0].submittype.value = "stargrey";
					document.forms[0].submitvalue.value = pTitle;
					document.forms[0].submit();
					//pForm.submit();
				} else {				//Green to Grey
					document.forms[0].submittype.value = "stargreen";
					document.forms[0].submitvalue.value = pTitle;
					document.forms[0].submit();
					//pForm.submit();
				}
			}
			
			function chkkey(pObj) {
				var pKeyCode = event.keyCode;
				
				if (pKeyCode ==8 && pObj.trim().length == 1) {
					document.forms[0].searchtext.value = "";
					document.forms[0].submittype.value = "";
					document.forms[0].submitvalue.value = "";
					document.forms[0].submit();
				}
			}
		</script>	
	
	</head>
	
	<body>		

		<header id="header">
			<div class="innertube">
				<h1 align="center">Toronto Waste Lookup</h1>
			</div>
		</header>
		
		<form name="shopifyform" action="index.jsp" onsubmit="return ChkForm(this)">

		<div id="wrapper">
			<main>
				<div id="content">
					<div class="innertube">
						<!--h1>Heading</h1>
						<p><script>generateText(20)</script></p-->
						<table width="100%">
							<tr>
								<td width="90%">
									<input autofocus="autofocus" id="textboxid" type="text" name="searchtextbox" value="<%=rSearchText%>" width="100%" onkeydown="chkkey(this.value)"/>
								</td>
								<td width="">&nbsp;&nbsp;</td>
								<td>
									<img id="searchimgid" src="searchimg.png" onclick="searchbclick()" style="cursor:pointer;"/>
								</td>
							</tr>
						</table>
						<br/>
						<table width="100%">
<%
		java.sql.Connection conn = null;
		java.sql.Statement stmt = null;
		java.sql.ResultSet rs = null;

    	try {
    		Class.forName("org.mariadb.jdbc.Driver");
    		
    		conn = java.sql.DriverManager.getConnection("jdbc:mariadb://localhost:3306/test", "testu1", "TestU1");
    		//conn = java.sql.DriverManager.getConnection("jdbc:mariadb://localhost:3306/getwellsoondb", "gwsu1", "Ka1yan786");
    		
    		//System.out.println("Got Connection....");
    		//rs = stmt.executeQuery("select s.storynum, s.storyname, p.pagenum, p.pagetitle, p.iscurrent, pp.paranum, pp.paratext from story s, storypages p, storyparas pp WHERE s.storynum = p.storynum and p.pagenum = pp.pagenum order by p.pagenum, pp.paranum");
    		
    		if (rSubmitType != null && rSubmitType.trim().length() > 0) {
    			stmt = conn.createStatement();
    			if (rSubmitType.equals("stargrey")) {
    				stmt.executeUpdate("update simranshopify set sisfav = 1 where stitle = '" + rSubmitValue + "'");
    			} else {
    				stmt.executeUpdate("update simranshopify set sisfav = 0 where stitle = '" + rSubmitValue + "'");
    			}
    			
    			stmt.close();
    		}

    		if (rSearchText != null && rSearchText.trim().length() > 0) {
	    		stmt = conn.createStatement();
	    		//rs = stmt.executeQuery("select * from simranshopify");
	    		rs = stmt.executeQuery("select stitle, sdesc, sisfav from simranshopify where lower(stitle) like '%" + rSearchText.toLowerCase() + "%'");
	    		while(rs.next()) {
	    			out.println("<tr>");
	    			out.println("<td valign=\"top\" width=\"5%\">");
	    			if (rs.getInt(3) == 0) {
	    				out.println("<img style=\"cursor:pointer;\" src=\"greystar.png\" onclick=\"setstarclick(1, \'" + rs.getString(1) + "\')\"/>");
	    			} else {
	    				out.println("<img style=\"cursor:pointer;\" src=\"greenstar.png\" onclick=\"setstarclick(2, \'" + rs.getString(1) + "\')\"/>");
	    			}
					out.println("</td>");
	    			out.println("<td valign=\"top\" width=\"45%\">" + rs.getString(1) + "</td>");
	    			out.println("<td valign=\"top\" width=\"50%\">" + rs.getString(2) + "</td>");
	    			out.println("</tr><tr><td>&nbsp;</td></tr>");
	    		}
	    		rs.close();
	    		stmt.close();
    		}

    		if (rSearchText != null && rSearchText.trim().length() > 0) {
	    		stmt = conn.createStatement();
	    		rs = stmt.executeQuery("select stitle, sdesc, sisfav from simranshopify where lower(stitle) like '%" + rSearchText.toLowerCase() + "%' and sisfav = 1");
	    		int titlef = 0;
	    		if (rs.next()) {
	    			do {
	    				if (titlef == 0) {
	    					out.println("<tr><td colspan=\"3\">Favourites</td></tr>");
	    					titlef = 1;
	    				}
	        			out.println("<tr>");
	        			out.println("<td valign=\"top\" width=\"5%\">");
	       				out.println("<img style=\"cursor:pointer;\" src=\"greenstar.png\" onclick=\"setstarclick(2, \'" + rs.getString(1) + "\')\"/>");
	    				out.println("</td>");
	        			out.println("<td valign=\"top\" width=\"45%\">" + rs.getString(1) + "</td>");
	        			out.println("<td valign=\"top\" width=\"50%\">" + rs.getString(2) + "</td>");
	        			out.println("</tr>");
	    			}while(rs.next());
	    		}
	    		rs.close();
	    		stmt.close();
    		}
    	}catch(Exception er1){
    		System.out.println("\n\nError: " + er1 + "\n\n");
    	} finally {
    		try {
    			if(rs != null) {
    				rs.close();
    			}
    		}catch(Exception eer1){
    		}
    		try {
    			if(stmt != null) {
    				stmt.close();
    			}
    		}catch(Exception eer1){
    		}
    		try {
    			if (conn != null) {
    				conn.close();
    			}
    		}catch(Exception eer2){
    		}
    	}
%>
						</table>
					</div>
				</div>
					<input type="hidden" name="searchtext" value=""/>
					<input type="hidden" name="submittype" value=""/>
					<input type="hidden" name="submitvalue" value=""/>
			</main>
			
			<!--nav id="nav">
				<div class="innertube">
					<h3>Left heading</h3>
					<ul>
						<li><a href="#">Link 1</a></li>
						<li><a href="#">Link 2</a></li>
						<li><a href="#">Link 3</a></li>
						<li><a href="#">Link 4</a></li>
						<li><a href="#">Link 5</a></li>
					</ul>
					<h3>Left heading</h3>
					<ul>
						<li><a href="#">Link 1</a></li>
						<li><a href="#">Link 2</a></li>
						<li><a href="#">Link 3</a></li>
						<li><a href="#">Link 4</a></li>
						<li><a href="#">Link 5</a></li>
					</ul>
					<h3>Left heading</h3>
					<ul>
						<li><a href="#">Link 1</a></li>
						<li><a href="#">Link 2</a></li>
						<li><a href="#">Link 3</a></li>
						<li><a href="#">Link 4</a></li>
						<li><a href="#">Link 5</a></li>
					</ul>
				</div>
			</nav-->
		
		</div>
		</form>

		<!--footer id="footer">
			<div class="innertube">
				<p>Footer...</p>
			</div>
		</footer-->
	
	</body>
</html>