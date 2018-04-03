function classIndex=classMapping(nPeople,ClassDef)
%ClassDef=1;

if ClassDef==1
    if 0<=nPeople && nPeople<=0
        classIndex=0;
    end
    if 1<=nPeople && nPeople<=1
        classIndex=1;
    end
    if 2<=nPeople && nPeople<=2
        classIndex=2;
    end
    if 3<=nPeople && nPeople<=5
        classIndex=3;
    end
    if 6<=nPeople && nPeople<=10
        classIndex=4;
    end
    if 11<=nPeople && nPeople<=20
        classIndex=5;
    end
    if 21<=nPeople && nPeople<=30
        classIndex=6;
    end
    if 31<=nPeople && nPeople<=40
        classIndex=7;
    end
    if 41<=nPeople 
        classIndex=8;
    end
end

if ClassDef==2
    classIndex=nPeople;
end

if ClassDef==3
    if nPeople==0
        classIndex=0;
    end
    if 1<=nPeople
        classIndex=1;
    end
end

if ClassDef==4
    if nPeople==0
        classIndex=0;
    end
    if 1<=nPeople && nPeople<=10
        classIndex=1;
    end
    if 10<=nPeople
        classIndex=2;
    end
end
   
if ClassDef==5
    if nPeople==0
        classIndex=0;
    end
    if 1<=nPeople && nPeople<=10
        classIndex=1;
    end
    if 10<=nPeople && nPeople<=20
        classIndex=2;
    end
    if 20<=nPeople 
        classIndex=3;
    end
end
   
