function [xs,ys] = DefineLineFromPointsFound(foundpts)
    linex=foundpts(1,:);
    liney=foundpts(2,:);
    coeffs=polyfit(linex,liney,1);
    clear linex liney;
    
    xs=linspace(-0.9,0.9,500); % almost entire MEMS range
    ys=polyval(coeffs,xs);
end