function wekaOBJ = matlab2weka(name, featureNames, data,targetIndex,ifReg)
% Convert matlab data to a weka java Instances object for use by weka
% classes. 
%
% name           - A string, naming the data/relation
%
% featureNames   - A cell array of d strings, naming each feature/attribute
%
% data           - An n-by-d matrix with n, d-featured examples or a cell
%                  array of the same dimensions if string values are
%                  present. You cannot mix numeric and string values within
%                  the same column. 
%
% wekaOBJ        - Returns a java object of type weka.core.Instances
%
% targetIndex    - The column index in data of the target/output feature.
%                  If not specified, the last column is used by default.
%                  Use the matlab convention of indexing from 1.
%
% Written by Matthew Dunham

    import java.io.*;
    import java.lang.*;
    
    %ifReg=0;

    if(~wekaPathCheck || numel(data)==0)
        wekaOBJ = []; 
        return;
    end
    if(nargin < 4)
        targetIndex = numel(featureNames); %will compensate for 0-based indexing later
    end

    import weka.core.*;
    
%  if after import, cannot use the classes like FastVector in weka, it might be the problem of the jre version
%  follow the link http://www.mathworks.com/matlabcentral/answers/103056-how-do-i-change-the-java-virtual-machine-jvm-that-matlab-is-using
    
    vec = FastVector();
    if(iscell(data))
        for i=1:numel(featureNames)
            if(ischar(data{1,i}))
                attvals = unique(data(:,i));
                values = FastVector();
                
                
%                 for j=0:49                  %use this if not cross validation
%                     if j<=9
%                         values.addElement(Character.toString(num2str(j)));
%                     else
%                         values.addElement(num2str(j));
%                     end
%                 end
                
                for j=1:numel(attvals)       %use this if cross validation
                    if length(attvals{j})==1
                        values.addElement(Character.toString(attvals{j})); % convert char to str, otherwise error will happen
                    else
                        values.addElement(attvals{j}); 
                    end
                end

                vec.addElement(Attribute(featureNames{i},values));
            else
                vec.addElement(Attribute(featureNames{i})); 
            end
        end 
    else
        for i=1:numel(featureNames)
            vec.addElement(Attribute(featureNames{i})); 
        end
    end
    wekaOBJ = Instances(name,vec,size(data,1));
    if(iscell(data))
        for i=1:size(data,1)
            %inst = Instance(numel(featureNames));  % weka 3.6
            inst = DenseInstance(numel(featureNames));  % weka 3.7
            inst.setDataset(wekaOBJ);
            for j=0:numel(featureNames)-2 % last 2 columns assign string if needed             
                inst.setValue(j,data{i,j+1});
            end
            % now at the last column
            j=numel(featureNames)-1;
            if ifReg==1
                inst.setValue(j,data{i,j+1});
            else
                if data{i,j+1}<=9
                    inst.setValue(j,Character.toString(num2str(data{i,j+1})));
                else
                    inst.setValue(j,num2str(data{i,j+1}));
                end
            end   
            wekaOBJ.add(inst);
        end
    else
        for i=1:size(data,1)
            %wekaOBJ.add(Instance(1,data(i,:))); % Weka 3.6
            wekaOBJ.add(DenseInstance(1,data(i,:)));  % Weka 3.7
        end
    end
    wekaOBJ.setClassIndex(targetIndex-1);
end