function [ok,res]=Information_gain(n_sub,pos,neg,sub_pos1,sub_neg1,sub_pos2,sub_neg2,sub_pos3,sub_neg3)

if n_sub==2
    ok=2;
p=[pos/(pos+neg) , neg/(pos+neg)];
p1=[sub_pos1/(sub_pos1+sub_neg1) , sub_neg1/(sub_pos1+sub_neg1)];
p2=[sub_pos2/(sub_pos2+sub_neg2) , sub_neg2/(sub_pos2+sub_neg2)];
res=entropy(p)-((sub_pos1+sub_neg1)/(pos+neg))*entropy(p1)-((sub_pos2+sub_neg2)/(pos+neg))*entropy(p2);
end
if n_sub==3
    ok=3;
p=[pos/(pos+neg) , neg/(pos+neg)];
p1=[sub_pos1/(sub_pos1+sub_neg1) , sub_neg1/(sub_pos1+sub_neg1)]
p2=[sub_pos2/(sub_pos2+sub_neg2) , sub_neg2/(sub_pos2+sub_neg2)]
p3=[sub_pos3/(sub_pos3+sub_neg3) , sub_neg3/(sub_pos3+sub_neg3)]
res=entropy(p)-((sub_pos1+sub_neg1)/(pos+neg))*entropy(p1)-((sub_pos2+sub_neg2)/(pos+neg))*entropy(p2)-((sub_pos3+sub_neg3)/(pos+neg))*entropy(p3);        
end
end

function res1=entropy(p)
res1=-sum(p.*log2(p));
end


