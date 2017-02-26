function AbsPos = RelToAbsPos(RelPos, Range);

Low = Range(1);
High = Range(2);
AbsPos = RelPos * (High - Low) + Low;