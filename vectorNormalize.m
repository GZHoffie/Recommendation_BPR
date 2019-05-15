function X = vectorNormalize(x)
%VECTORNORMALIZE Normalizes a vector x

if (max(x)-min(x)~=0)
    X = (x-mean(x))./std(x);
else  
    X = x;
end

end

