<%@ page import="java.util.*,java.io.*" %>
<%
	String filename=request.getParameter("filename");//take the file name of the saved graph as a parameter
	PrintWriter resp=response.getWriter(); //
	try{ //if file exixst
	File jsp = new File(request.getRealPath("/Assignment/Saved/"+filename));//create a File object jsp
	FileInputStream fstream=new FileInputStream(jsp);// create a Filestream object 
    DataInputStream in = new DataInputStream(fstream);// create a data stream for reading the file
    BufferedReader br = new BufferedReader(new InputStreamReader(in));// creating the reader object
	String s=br.readLine();//reading the line of the file
	resp.print(s);//sending data to browser
}
catch(IOException e)//If there is an exception
{
resp.print("failed");
}

	

%>
