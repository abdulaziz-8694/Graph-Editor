<%@ page import="java.util.*,java.io.*" %>

<%
class Edge implements Comparable<Edge>{// Class for edge which will have source vertex,target vertex,and weight
		private int s;
		private int t;
		private int w;
		Edge(int source,int target,int weight)
		{
			s=source;
			t=target;
			w=weight;
		}
		 public int getWeight()
		 {
		 	return this.w;
		 }

		 public int getSource()
		 {
		 	return this.s;
		 }

		 public int getTarget()
		 {
		 	return this.t;
		 }
//implementing compareTo function for sorting the edges according to weights
		public int compareTo(Edge v)  
		{
			int compareQuantity=((Edge) v).getWeight();
			return this.w-compareQuantity;//for sorting in ascending order
		}

}

class DisjointSets{// implementing Disjoint Sets Data Structure with path compression and rank
	private int[] Parent;//representative of elements
	private int[] Rank;//rank of elements
//Constructor for DisjointSets whilch will create numElements distinct sets
	public DisjointSets(int numElements)
	{
		Parent=new int[numElements];
		Rank=new int[numElements];
		for(int i=0;i<Parent.length;i++)
		{
			Parent[i]=i;
			Rank[i]=0;
		}
	}
	public int Find(int i) {//Finding the representing of the set containing i
 
    // If i is the parent of itself
    if (Parent[i] == i) {
 
        // Then i is the representative of his set
        return i;
    }
    else { // Else if i is not the parent of itself
 
        // Then i is not the representative of his set,
        // so we recursively call Find on it's parent, and save it in our result variable
        int result = Find(Parent[i]);
 
        // We then cache the result by moving i's node directly under the representative of his set
        Parent[i] = result;
 
        // And then we return the result
        return result;
    }
}
//to take union of two sets
	public void Union(int u,int v)
	{
		int repu=Find(u);
		int repv=Find(v);
		if(repu==repv)//if both are on the same set the no need to unite
			return;
		if(Rank[u]<Rank[v])//if set u is smaller in height than set v 
		{
			this.Parent[repu]=repv;
		}
		else if(Rank[u]>Rank[v])//if set v is smaller in height than set u
		{
			this.Parent[repv]=repu;
		}
		else//if both are equal then we take union and increase the height
		{
			this.Parent[repu]=repv;
			Rank[repv]++;
		}
	}



}

	PrintWriter resp=response.getWriter();//object to send response to browser
	String n=request.getParameter("node");//No. of nodes
	String edges=request.getParameter("edges");//Edges of graph
	String weight=request.getParameter("weight");//Weights of edges
	String[] edge=edges.split(":");//array of edges
	String[] w=weight.split(":");//array of weights
	Edge[] E=new Edge[w.length];// array of Edges
	int s,t,wt;
	for(int i=0;i<w.length;i++)//parsing the data and Creating an array of objects of Edge
	{	
		String[] temp=edge[i].split("-");
		E[i]=new Edge(Integer.parseInt(temp[0]),Integer.parseInt(temp[1]),Integer.parseInt(w[i]));
		//s=E[i].getSource();
		//t=E[i].getTarget();
		//wt=E[i].getWeight();
		//resp.print(s+"-"+t+":"+wt+"#");
	
	}
	Arrays.sort(E);//sorting Edges according to weights defined previously
	//resp.print("After sort");
	/*for(int i=0;i<E.length;i++)
	{
		s=E[i].getSource();
		t=E[i].getTarget();
		wt=E[i].getWeight();
		//resp.print(s+"-"+t+":"+wt+"#");
	}*/
String answer="";//String for storing edges in minimum spanning tree
DisjointSets set=new DisjointSets(Integer.parseInt(n));//implementing Kruskals Algorithm for minimum spanning tree
	for(int i=0;i<E.length;i++)
	{
		s=E[i].getSource();
		t=E[i].getTarget();
		if(set.Find(s)!=set.Find(t))
		{
			answer+=s+"-"+t+":";
			//resp.print(s+"-"+t+"#");
			set.Union(s,t);
		}
	}
	resp.print(answer);



	
	





%>
