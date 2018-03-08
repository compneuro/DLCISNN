function [datapoints]=createneuron(inp_for_sys,cnt_MF)
    datapoints=[];
    if (mod(cnt_MF,2))%odd
        sd_cnt=floor(cnt_MF/2);
        sd_cnt=3/sd_cnt;
        datapoints(end+1)=inp_for_sys;
    else
        sd_cnt=cnt_MF/2;
        sd_cnt=3/sd_cnt;
    end
    for i=sd_cnt:sd_cnt:3
        minsigma=(inp_for_sys-(i*3));
        plussigma=(inp_for_sys+(i*3));
        datapoints=cat(2,datapoints,minsigma,plussigma);
    end

    datapoints=sort(datapoints);
end
    
