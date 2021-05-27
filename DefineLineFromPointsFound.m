function [xs,ys] = DefineLineFromPointsFound(foundpts)
    linex=foundpts(1,:);
    liney=foundpts(2,:);
    coeffs=polyfit(linex,liney,1);
    clear linex liney;
    
    xs=linspace(-0.9,0.9,500); % almost entire MEMS range %war erst (-0.9,0.9,500)
    ys=polyval(coeffs,xs);
    test = xs.^2 + ys.^2 > 1;
    test = test.';
    xs = xs(~test);
    ys = ys(~test);
    
end