#include<stdio.h>
#include<windows.h>


#define MAX_VERTEX_NUM 20
typedef int VertexType,InfoType,Status;

typedef struct ArcBox{
    int tailvex,headvex;            //该弧的尾和头顶点的位置
    struct ArcBox *hlink,*tlink;    //分别为弧头相同和狐尾相同的弧和链域
    InfoType    *info;              //该弧相关信息的指针
}ArcBox;

typedef struct VexNode{
    VertexType data;
    ArcBox      *firstin,*firstout; //分别指向该顶点第一条入弧和出弧          
}VexNode;

typedef struct{
    VexNode xlist[MAX_VERTEX_NUM];  //表头向量
    int vexnum,arcnum;              //有向图的当前顶点数和弧数

}OLGraph;


typedef OLGraph Graph;
typedef bool Boolean;


 int LocateVex(OLGraph G,int v){
    for (int i = 0; i < MAX_VERTEX_NUM; i++)
        if(G.xlist[i].data==v) return i;
    return 0;
 }
 

int FirstAdjVex(Graph G,int v){
    
    if(G.xlist[v].firstout==NULL) return -1;
    else return G.xlist[v].firstout->headvex;
}

int NextAdjVex(Graph G,int v,int w){
    ArcBox * buf =G.xlist[v].firstout;

    while (buf->headvex!=w)
        buf=buf->tlink;
    buf=buf->tlink; 
    if(buf==NULL) return -1;
    else return buf->headvex;
}


int FirstAdjVex1(Graph G,int v){
    
    if(G.xlist[v].firstin==NULL) return -1;
    else return G.xlist[v].firstin->tailvex;
}

int NextAdjVex1(Graph G,int v,int w){
    ArcBox * buf =G.xlist[v].firstin;

    while (buf->tailvex!=w)
        buf=buf->hlink;
    buf=buf->hlink; 
    if(buf==NULL) return -1;
    else return buf->tailvex;
}


Status CreateDG(OLGraph &G){
    //采用十字链表存储表示，构造有向图G
    int i,j,k,v1,v2,IncInfo;
    ArcBox *p;

    // scanf("%d%d%d",&G.vexnum,&G.arcnum,&IncInfo);                      //IncInfo为0则各弧不含其他信息
    scanf("%d%d",&G.vexnum,&G.arcnum);   
    
    for(i=0;i<G.vexnum;++i){                                    //构造表头向量
        // scanf("%d",&G.xlist[i].data);                                //输入顶点值
        G.xlist[i].data=i;
        G.xlist[i].firstin=NULL;G.xlist[i].firstout=NULL;       //初始化指针
    }
    for(k=0;k<G.arcnum;++k){                                    //输入各弧并构造十字链表
        scanf("%d%d",&v1,&v2);                                         //输入一条弧的始点和终点
        i=LocateVex(G,v1);j=LocateVex(G,v2);                    //确定v1,v2位置

        p=(ArcBox *) malloc (sizeof(ArcBox));                   //假定有足够空间
        *p={i,j,G.xlist[j].firstin,G.xlist[i].firstout,NULL }; //对弧顶点赋值 
        G.xlist[j].firstin=G.xlist[i].firstout=p;                //完成在入弧和出弧链头的插入
        // if(IncInfo) Input(*p->info);                             //若弧含有相关信息，则输入   
        // if(IncInfo)  scanf("%d",*p->info); 
    }
}//CreateDG


// Boolean visited[MAX];           //访问标志数组
Boolean visited[MAX_VERTEX_NUM];
int finished[MAX_VERTEX_NUM];
int count;
Status (* VisitFunc)(int v);    //函数变量



void DFS(Graph G,int v){
    //从第v个顶点出发递归地深度优先遍历图G
    int w;
    // visited[v]=TRUE;VisitFunc(v);                       //访问第v个顶点
    visited[v]=TRUE;                      //访问第v个顶点
    printf("%d",v);

    for(w=FirstAdjVex(G,v);w>=0; w=NextAdjVex(G,v,w))
        if(!visited[w]) DFS(G,w);                       //对v的未访问的邻接点w递归调用DFS
    finished[count++]=v;
}



void DFSTraverse(Graph G /*,-Status (* Visit)(int v)*/){
    //对图作深度优先遍历
    int v,w;

    count=0;
    // VisitFunc=Visit;                            //使用全局变量VisitFunc,使DFS不必使用函数指针参数
    for(v=0;v<G.vexnum;++v) visited[v]=FALSE;   //访问标志数组初始化
    for(v=0;v<G.vexnum;++v) 
        if(!visited[v]) DFS(G,v);               //对尚未访问的顶点调用DFS
}


void DFS1(Graph G,int v){
    //从第v个顶点出发递归地深度优先遍历图G
    int w;
    // visited[v]=TRUE;VisitFunc(v);                       //访问第v个顶点
    visited[v]=TRUE;                      //访问第v个顶点
    printf("%d",v);

    for(w=FirstAdjVex1(G,v);w>=0; w=NextAdjVex1(G,v,w))
        if(!visited[w]) DFS1(G,w);                       //对v的未访问的邻接点w递归调用DFS
    // finished[count++]=v;
}


void DFSTraverse1(Graph G /*,-Status (* Visit)(int v)*/){
    //对图作深度优先遍历
    int v,w,flag,num;
    flag=0;
    
    // count=0;
    // VisitFunc=Visit;                            //使用全局变量VisitFunc,使DFS不必使用函数指针参数
    for(v=0;v<G.vexnum;++v) visited[v]=FALSE;   //访问标志数组初始化
    for(num=G.vexnum-1,v=finished[num];num>=0;v=finished[--num]) 
        if(!visited[v]) {
            printf("\nflag=%d  :DFS ",++flag);
            DFS1(G,v);}               //对尚未访问的顶点调用DFS
}







int main(int argc, char const *argv[])
{
    OLGraph G;
    CreateDG(G);
    
    DFSTraverse(G);

    DFSTraverse1(G);

    return 0;
 }

