function PlotModel(model)

% ====== 地形 ======
mesh(model.X,model.Y,model.H);

colormap(parula);   
set(gca, 'Position', [0 0 1 1]);

axis equal vis3d on;
shading interp;

material dull;
camlight headlight;   
lighting gouraud;

xlabel('x [m]');
ylabel('y [m]');
zlabel('z [m]');
hold on


% ====== 威胁区 ======
threats = model.threats;
threat_num = size(threats,1);
h = 250;

for i = 1:threat_num
    threat = threats(i,:);
    threat_x = threat(1);
    threat_y = threat(2);
    threat_z = threat(3);
    threat_radius = threat(4);

    [xc,yc,zc] = cylinder(threat_radius);

    xc = xc + threat_x;
    yc = yc + threat_y;
    zc = zc * h + threat_z;

    % ====== 改进绘制方式 ======
    c = surf(xc,yc,zc);   

    set(c,...
        'EdgeColor','none',...                
        'FaceColor',[0.1 0.3 0.6],...          
        'FaceAlpha',0.6);                      
end

end