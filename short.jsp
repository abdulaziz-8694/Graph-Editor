<%@ page import="java.util.*,java.io.*" %>

<%
final String[] source=request.getParameter("source").split(":");
final String[] target=request.getParameter("target").split(":");
final String[] weight=request.getParameter("weight").split(":");
final int n=Integer.parseInt(request.getParameter("node"));
String[] sd=request.getParameter("sp").split("-");
PrintWriter resp=response.getWriter();

final int sourceNode=Integer.parseInt(sd[0]);
final int targetNode=Integer.parseInt(sd[1]);

class Vertex{//class for vertex 
	int index;
	int dist;
	int predecessor;
	int inque;
	List<Integer> adj;
	Vertex()
	{
		dist =100000;
		inque=1;
		predecessor=-1;
		adj=new ArrayList<Integer>();
	}
}

Vertex[] Vertices=new Vertex[n];
for(int i=0;i<n;i++)//creating an array of vertices
{
	Vertices[i]=new Vertex();
	Vertices[i].index=i;
}

for(int i=0;i<source.length;i++){//addinf edge to vertices
	int s=Integer.parseInt(source[i]);	
	int t=Integer.parseInt(target[i]);
	Vertices[s].adj.add(t);
	Vertices[t].adj.add(s);
}

class Distance{//for calculating distance between vertex a and b. returns -1 if no edge
	public int calculate_dist(int a,int b){
		for(int i=0;i<source.length;i++){
			int sr=Integer.parseInt(source[i]);
			int trg=Integer.parseInt(target[i]);
			if((sr==a&&trg==b)||(sr==b&&trg==a)){
				int wt=Integer.parseInt(weight[i]);
				return wt;
			}
		}
		return -1;
	}
}

class edge_comparator implements Comparator<Vertex> {// comparator class for sorting vertices array
	@Override
	public int compare(Vertex a,Vertex b){
		if(a.dist>b.dist)
			return 1;
		else if (a.dist<b.dist)
			return -1;
		else
			return 0;
	}
}
//Implementing Djikstra Algorithm for shortest path
List<Vertex> que=new LinkedList<Vertex>();//Implementing priority que(Sort after each update to get the min)
Vertices[sourceNode].dist=0;

for(int i=0;i<n;i++)
{
	que.add(Vertices[i]);//adding all the vetices
}

int disc=0;//for disconnectivity
while(que.size()!=0){

	Collections.sort(que,new edge_comparator());
	Vertex u=que.get(0);
	u.inque=0;

	que.remove(u);
	if(u.dist==100000){
	disc=1;
	break;
	}
	if(u.index==targetNode){
		break;
	}
	for(int i=0;i<u.adj.size();i++){//for each vertex having an edge with u
		Vertex v= new Vertex();
		v=Vertices[u.adj.get(i)];
		if(v.inque==1){
			Distance d=new Distance();
			int temp=u.dist+d.calculate_dist(u.index,v.index);
			if(temp<v.dist){//relaxing edges
			v.dist=temp;
			v.predecessor=u.index;
			Collections.sort(que,new edge_comparator());
			}
		}
	}
}
if(disc==0){
String s="";

Vertex v=new Vertex();
v=Vertices[targetNode];
while(v.predecessor!=-1){
	int temp1=v.index;
	v=Vertices[v.predecessor];
	int temp2=v.index;
	s+=temp2+"-"+temp1+":";	
}
resp.print(s+"0-0");
}
else
	resp.print("failed");

%>
