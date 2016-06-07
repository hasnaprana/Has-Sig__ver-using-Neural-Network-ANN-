function rslt = getPairDifference(algoResults, imagesPerUser)

% get the differences between each element
rslt = zeros((imagesPerUser*(imagesPerUser-1)/2),1); 
cnt = 1;

for i= 1 : imagesPerUser
    for j= 2 : imagesPerUser
        if(j>i)
            if((algoResults(j)- algoResults(i)) > 0) 
                rslt(cnt,1) = algoResults(j) - algoResults(i);
                cnt = cnt +1;
            else
                rslt(cnt,1) = algoResults(i) - algoResults(j);
                cnt = cnt +1;
            end
        end
    end
end

