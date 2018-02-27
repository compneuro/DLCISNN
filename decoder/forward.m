function fwd=forward(inp,bias,wgt)
    % Forward propagation
    
    global hid_lay;
    global hid_node;
    global inp_node_no;
    global out_node_no;

    num=inp_node_no;
    length(inp);
    r=inp;

    for i=1:hid_lay
        fwd{i}= summation(num,r,wgt{i},bias,hid_node(i)); 
        num=hid_node(i);
        r=fwd{i};
    end
    fwd{i+1}=summation(num,r,wgt{i+1},bias,out_node_no);
end






