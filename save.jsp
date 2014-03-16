<%@ page import="java.util.*,java.io.*" %>
<%
	String nodes=request.getParameter("nodes");//vertices
	String edges=request.getParameter("edges");//Edges
	String filename=request.getParameter("filename");//filename to be saved
	String filenames="";//list of filenames to refresh the filelist after saving the file
	String	context=nodes+"#"+edges;//content of the file to be saved
	PrintWriter resp=response.getWriter();
	String path="webapps/ROOT/Assignment/Saved/"+filename+".graph";//path where to save
	try{
	PrintWriter strFile = new PrintWriter(new FileOutputStream(path));
	strFile.println(context);
	strFile.close();
	File jsp = new File(request.getRealPath("/Assignment/Saved"));  //path to where all files are saved  
	File directory = jsp.getParentFile();
	File[] list = jsp.listFiles();
	for(int i=0;i<list.length;i++){
		filenames+=list[i].getName()+"#";
	}
	resp.print(filenames);//returning filelist in that folder
}
catch(IOException e)
{
	resp.print("failed");
}
%>
