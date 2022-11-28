function act_out=summation(num,r,wt,bias,hid_node)
    sum=0.0;
    for i=1:hid_node
        for j=1:num
            temp=r(j)*wt(i,j);
            sum=sum+temp;        
        end
        Out(i)=sum+bias;
        Out(i);
        act_out(i)=activation(Out(i));
        sum=0.0;
    end

end
