#include <iostream>
using namespace std;

class node{
public:
    int data;
    node* next;
    node(int val){
        data=val;
        next=NULL;
    }
};
node* head=NULL;
void push_first(int value){
    node* newnode= new node(value);
    if(head==NULL){
        head=newnode;
    }else{
        newnode->next=head;
        head=newnode;
    }
}

void push_back(int value){
    node* newnode= new node(value);
    if(head==NULL){
        head=newnode;
    }else{
        node* temp=head;
        while(temp->next!=NULL){
            temp=temp->next;
        }
        temp->next=newnode;
        
    }
    
    
}
void push_anypos(int value,int pos){
    node* newnode=new node(value);
    if(pos==1){
        push_first(value);
    }else{
        node* temp=head;
        for(int i=1;i<pos-1;i++){
            temp=temp->next;
            
        }
        newnode->next=temp->next;
        temp->next=newnode;
    
    }
    
}


void show(){
    node* temp= head;
    while(temp!=NULL){
        cout<<temp->data<<"->";
        temp=temp->next;
    }
    cout<<"NULL"<<endl;
    
}
int main(){
    push_first(10);
    push_first(20);
    push_first(30);
    show();
    push_back(300);
    show();
    push_anypos(200, 4);
    show();
}
