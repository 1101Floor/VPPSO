function model=Create_Select_Model(map_select,map_complexity,startPos,goalPos,n)

if map_select==1
    H = imread('ChrismasTerrain.tif');
    H (H < 0) = 0;
    zmin = 100;
    zmax = 200;

    if map_complexity==1
        R1=50;  % Radius
        x1 = 400; y1 = 500; z1 = 200; % center

        R2=40;  % Radius
        x2 = 600; y2 = 200; z2 = 200; % center

        R3=50;  % Radius
        x3 = 500; y3 = 350; z3 = 200; % center
        threats = [x1 y1 z1 R1;x2 y2 z2 R2; x3 y3 z3 R3];
    elseif map_complexity==2
        R1=50;  % Radius
        x1 = 400; y1 = 500; z1 = 200; % center

        R2=40;  % Radius
        x2 = 600; y2 = 200; z2 = 200; % center

        R3=50;  % Radius
        x3 = 500; y3 = 350; z3 = 200; % center

        R4=40;  % Radius
        x4 = 350; y4 = 200; z4 = 200; % center

        R5=40;  % Radius
        x5 = 700; y5 = 550; z5 = 200; % center

        R6=50;  % Radius
        x6 = 650; y6 = 750; z6 = 150; % center
        threats = [x1 y1 z1 R1;x2 y2 z2 R2; x3 y3 z3 R3; x4 y4 z4 R4; x5 y5 z5 R5;x6 y6 z6 R6];
   
    end

end
MAPSIZE_X = size(H,2); % x index: columns of H
MAPSIZE_Y = size(H,1); % y index: rows of H
[X,Y] = meshgrid(1:MAPSIZE_X,1:MAPSIZE_Y);

xmin= 1;
xmax= MAPSIZE_X;
ymin= 1;
ymax= MAPSIZE_Y;



% 参数整定到model方便管理
model.start=startPos;
model.end=goalPos;
model.n=n;
model.xmin=xmin;
model.xmax=xmax;
model.zmin=zmin;
model.ymin=ymin;
model.ymax=ymax;
model.zmax=zmax;
model.MAPSIZE_X = MAPSIZE_X;
model.MAPSIZE_Y = MAPSIZE_Y;
model.X = X;
model.Y = Y;
model.H = H;
model.threats = threats;


PlotModel(model);
end
