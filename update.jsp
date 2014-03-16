<%@ page import="java.util.*,java.io.*" %>
<%//to be loaded when loading the webpage 
	String filenames="";
	PrintWriter resp=response.getWriter();
	File jsp = new File(request.getRealPath("/Assignment/Saved"));  //eg. /WEB-INF/jsp/my.jsp
	//File directory = jsp.getParentFile();
	File[] list = jsp.listFiles();
	for(int i=0;i<list.length;i++){
		filenames+=list[i].getName()+"#";
	}
	resp.print(filenames);
%>
