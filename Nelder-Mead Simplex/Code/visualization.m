[x,y]=meshgrid(-1:.01:1);
f=(y-x).^4+12*x.*y-x+y-3;
contour(x,y,f,800)