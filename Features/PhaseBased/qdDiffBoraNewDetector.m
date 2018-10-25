function [qd_diff] = qdDiffBoraNewDetector(Comp,numQuads,bgr)

qd_diff = NaN(size(Comp));
qd_diff(1)=0;
for i = 2:numel(Comp)
    %background_rejection_series(i) =     BackGroundRejection;
    if and(FindIsAboveBackGroundRejection(Comp(i-1), bgr) ...
            ,FindIsAboveBackGroundRejection(Comp(i), bgr) ),
        cur_qd_diff = findNumQuadrantChanges([Comp(i-1);Comp(i)]...
            ,[FindCurQuad(Comp(i-1),numQuads);FindCurQuad(Comp(i), numQuads)]);
        qd_diff(i) = cur_qd_diff(end);
    %else
        %qd_diff(i)=0;
    %end
end

end

function qd = FindCurQuad(Comp, numQuads)
if(numQuads == 4)
    qd = findQuadrant4(Comp);
elseif numQuads ==8
    qd = findQuadrant8(Comp);
else
    error(['Unimplmented number of quadrants = ' num2str(numQuad)]);
end