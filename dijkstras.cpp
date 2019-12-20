//Program to find the shortest paths to every vertex from a single source from the given weighted connected graph entered as a cost matrix

#include<iostream>

using namespace std;

void parent(int v,int p[20]){
     if(v==0)
        return;
     parent(p[v],p);
	//  cout<<p[v]<<"->";
     printf(" %d->",p[v]);
     return;
}

int cost[20][20];
void dijkstra(int n,int source){
	int dis[20],visited[20],count,min,nextnode,i,j,p[20];
	for(i=0;i<n;i++){
		dis[i]=cost[source][i]; //to initialize dis[] with the respective distances from the source
		visited[i]=0; //initially none of the nodes are visited
		p[i]=source;
	}

	dis[source]=0; //distance of source from itself is 0
	visited[source]=1; //mark source node as visited
	count=1; //1 node is visited(source)

	while(count<n) //loops until all the nodes are visited
	{
		min=999;
		//nextnode gives the node at minimum distance
		for(i=0;i<n;i++)
			if(dis[i]<min && !visited[i]){
				min=dis[i];
				nextnode=i;
			}

			//to check if a better path exists through nextnode
			visited[nextnode]=1;
			for(i=0;i<n;i++)
				if(!visited[i])
					if(min+cost[nextnode][i]<dis[i]){
						dis[i]=min+cost[nextnode][i];
						p[i]=nextnode;
					}
		count++;
	}

	//to print distance of each node from the source node alongwith the path
	for(i=0;i<n;i++)
		if(i!=source){
			cout<<"\nDistance of node"<<i<<"to"<<source<<"with cost"<<dis[i]<<endl;
			parent(i,p);
            cout<<i;
		}
}

int main(){
	int i,j,n,source;
	cout<<"Enter no. of vertices:";
	cin>>n;
	printf("\nEnter the cost matrix:\n");

	for(i=0;i<n;i++)
		for(j=0;j<n;j++){
		   cin>>cost[i][j];
		    if(cost[i][j]==0 && i!=j)
			cost[i][j]=999;
		}

	printf("\nEnter the starting node:");
	cin>>source;
	printf("\n");
	dijkstra(n,source); //calls the function

	return 0;
}