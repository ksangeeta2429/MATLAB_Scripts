% input: fIndex, parameterSetting,  n features per iteration
% output: [indexes]
% do: convert index of feature to index of loop, for example,
% parameterSetting is {[x x x],[x x],[x x x]}, i.e. 3*2*3, 18 in total
% each loop 8 features for example, in total 8*18 features


function [indexes,indexInLoop]=convertIndex(fIndex,parameterSetting,n) 
if mod(fIndex,n)==0
    indexInLoop=n;
    indexLoop1=fIndex/n;
else
    indexInLoop=mod(fIndex,n);
    indexLoop1=floor(fIndex/n)+1;
end
%%

nLoop=length(parameterSetting);
if nLoop==0
    indexes=[];
end

if nLoop==1
    indexes=[indexLoop1];
end
if nLoop==2
    l=length(parameterSetting{2});
    if mod(indexLoop1,l)==0
        indexes(1)=indexLoop1/l;
        indexes(2)=length(parameterSetting{2});
        return;
    else  
        indexes(1)=floor(indexLoop1/l)+1;
    end  
    indexes(2)=mod(indexLoop1,l);
end
if nLoop==3
    l1=length(parameterSetting{2})*length(parameterSetting{3});
    if mod(indexLoop1,l1)==0
        indexes(1)=indexLoop1/l1;
        indexes(2)=length(parameterSetting{2});
        indexes(3)=length(parameterSetting{3});
        return;
    else
        indexes(1)=floor(indexLoop1/l1)+1;
    end
    
    indexLoop2=mod(indexLoop1,l1);
    l2=length(parameterSetting{3});
    if mod(indexLoop2,l2)==0
        indexes(2)=indexLoop2/l2;
        indexes(3)=length(parameterSetting{3});
        return;
    else
        indexes(2)=floor(indexLoop2/l2)+1;
    end
  
    indexes(3)=mod(indexLoop2,l2);
end

if nLoop==4
    l1=length(parameterSetting{2})*length(parameterSetting{3})*length(parameterSetting{4});
    if mod(indexLoop1,l1)==0
        indexes(1)=indexLoop1/l1;
        indexes(2)=length(parameterSetting{2});
        indexes(3)=length(parameterSetting{3});
        indexes(4)=length(parameterSetting{4});
        return;
    else
        indexes(1)=floor(indexLoop1/l1)+1;
    end
    
    indexLoop2=mod(indexLoop1,l1);
    l2=length(parameterSetting{3})*length(parameterSetting{4});
    if mod(indexLoop2,l2)==0
        indexes(2)=indexLoop2/l2;
        indexes(3)=length(parameterSetting{3});
        indexes(4)=length(parameterSetting{4});
        return;
    else
        indexes(2)=floor(indexLoop2/l2)+1;
    end
    
    indexLoop3=mod(indexLoop2,l2);
    l3=length(parameterSetting{4});
    if mod(indexLoop3,l3)==0
        indexes(3)=indexLoop3/l3;
        indexes(4)=length(parameterSetting{4});
        return;
    else
        indexes(3)=floor(indexLoop3/l3)+1;
    end
    
    indexes(4)=mod(indexLoop3,l3);
end

if nLoop==5
    l1=length(parameterSetting{2})*length(parameterSetting{3})*length(parameterSetting{4})*length(parameterSetting{5});
    if mod(indexLoop1,l1)==0
        indexes(1)=indexLoop1/l1;
        indexes(2)=length(parameterSetting{2});
        indexes(3)=length(parameterSetting{3});
        indexes(4)=length(parameterSetting{4});
        indexes(5)=length(parameterSetting{5});
        return;
    else
        indexes(1)=floor(indexLoop1/l1)+1;
    end
    
    indexLoop2=mod(indexLoop1,l1);
    l2=length(parameterSetting{3})*length(parameterSetting{4})*length(parameterSetting{5});
    if mod(indexLoop2,l2)==0
        indexes(2)=indexLoop2/l2;
        indexes(3)=length(parameterSetting{3});
        indexes(4)=length(parameterSetting{4});
        indexes(5)=length(parameterSetting{5});
        return;
    else
        indexes(2)=floor(indexLoop2/l2)+1;
    end
    
    indexLoop3=mod(indexLoop2,l2);
    l3=length(parameterSetting{4})*length(parameterSetting{5});
    if mod(indexLoop3,l3)==0
        indexes(3)=indexLoop3/l3;
        indexes(4)=length(parameterSetting{4});
        indexes(5)=length(parameterSetting{5});
        return;
    else
        indexes(3)=floor(indexLoop3/l3)+1;
    end
    
    indexLoop4=mod(indexLoop3,l3);
    l4=length(parameterSetting{5});
    if mod(indexLoop4,l4)==0
        indexes(4)=indexLoop4/l4;
        indexes(5)=length(parameterSetting{5});
        return;
    else
        indexes(4)=floor(indexLoop4/l4)+1;
    end
    
    indexes(5)=mod(indexLoop4,l4);
end

