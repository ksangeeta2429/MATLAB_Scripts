function Result = subsref(Obj, Index)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% subsref method for ScanSetT type.

NumRef = length(Index);

switch Index(1).type
  case {'{}', '()'}
    ERROR('Array and cell arrays not supported on this type');
    
  case '.'
    switch Index(1).subs
      %% exposed feilds, i.e., accesor methods
      case 'Data'
        if NumRef == 1
          Result = Obj.Data;
        else
          if Index(2).type == '()'
            Temp = Index(2).subs;
            Result = Obj.Data(Temp{:});
          else
            ERROR('Operation no supported')
          end
        end

      %% Method with no arguments and no return

      %% Method with optional arguments and no return
      case {'Movie', 'View', 'View2d'}
        if (NumRef == 1)
          switch Index(1).subs
            case 'Movie', Movie(Obj);
            case 'View', View(Obj);
            case 'View2d', View2d(Obj);
            otherwise ERROR('Code Rot');
          end
        else
          if Index(2).type == '()'
            Temp = Index(2).subs;
            switch Index(1).subs
              case 'Movie', Movie(Obj, Temp{:});
              case 'View', View(Obj, Temp{:});
              case 'View2d', View2d(Obj, Temp{:});
              otherwise ERROR('Code Rot');
            end
          else
            ERROR('Operation not supported')
          end
        end
           
      %% Method with arguments but no return
      
      %% Method no arguments but with return
      case {'Pos', 'NumScan', 'NumSamp', 'NumChan', 'Median', 'IncDiff'}
        if (NumRef == 1)
          switch Index(1).subs
            case 'Median', Result = Median(Obj);
            case 'Pos', Result = Obj.Pos;
            case 'NumScan', Result = Obj.NumScan;
            case 'NumSamp', Result = Obj.NumSamp;
            case 'NumChan', Result = Obj.NumChan;
            case 'IncDiff', Result = IncDiff(Obj);
            otherwise, ERROR('Code Rot');
          end
        else
          ERROR('No arguments allowed')
        end
      
      %% Method with arguments and return
      case {'UpSamp', 'DownSamp', 'Shift', 'Sub'}
        if Index(2).type == '()'
          Temp = Index(2).subs;
          
          switch Index(1).subs
            case 'UpSamp', Result = UpSamp(Obj, Temp{:});
            case 'DownSamp', Result = DownSamp(Obj, Temp{:});
            case 'Shift', Result = Shift(Obj, Temp{:});
            case 'Sub', Result = Sub(Obj, Temp{:});
            otherwise, ERROR('Code rot!')
          end
        else
          ERROR('Operation not supported')
        end

      otherwise
        ERROR('Unknown method')
    end
end