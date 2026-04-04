
%%
clc
clear
close all
tic
%% 地图
G=[0 0 0 0 0 0 1 1 1 1 1 1 0 0 0 0 0 0 0 0;
   0 0 0 0 0 0 1 1 1 1 1 1 0 0 1 0 0 1 0 0;
   0 0 0 0 0 0 1 1 1 1 1 1 0 0 1 0 0 0 0 0;
   0 0 0 0 0 0 0 0 1 1 0 0 0 0 1 0 0 0 0 0;
   0 1 1 1 0 1 1 0 0 0 0 1 1 0 0 0 0 1 0 0;
   0 1 1 1 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0;
   0 0 0 0 0 1 1 1 0 0 1 0 0 1 1 1 0 1 1 0;
   0 0 0 0 0 0 0 1 0 0 0 0 0 0 1 0 0 1 1 0;
   0 0 0 0 1 1 0 1 0 1 1 0 0 0 0 0 0 0 0 0;
   0 0 0 0 1 1 0 1 0 0 0 0 1 1 1 1 0 0 0 0;
   0 0 0 0 0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 0;
   0 0 0 0 1 0 0 0 0 0 1 0 1 1 0 0 1 0 0 0;
   0 0 0 0 0 0 1 1 1 0 1 0 1 1 0 1 1 0 0 0;
   1 1 1 0 0 0 1 1 1 0 0 0 0 0 0 0 1 0 0 0;
   1 1 1 0 1 0 0 0 0 0 0 1 0 0 0 0 1 0 0 0;
   1 1 1 0 0 0 1 1 1 0 0 0 0 0 0 0 0 0 0 0;
   1 1 1 0 0 0 1 1 1 0 0 1 1 1 0 1 1 1 1 0;
   0 0 0 0 1 0 1 1 1 0 1 0 0 0 0 0 0 0 0 0;
   0 1 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1 0;
   0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;];















num = size(G,1);
for i=1:num/2  
    for j=1:num
        m=G(i,j);
        n=G(num+1-i,j);
        G(i,j)=n;
        G(num+1-i,j)=m;
    end
end
%% 
S = [1 1];   
E = [num num];  
G0 = G;
G = G0(S(1):E(1),S(2):E(2)); 
[Xmax,dimensions] = size(G); X_min = 1;         
dimensions = dimensions - 2;            
max_gen = 500;    % 最大迭代次数
num_polution = 30;         % 种群数量
%% 

fobj=@(x)fitness(x,G);

[Best_score,Best_pos,GA_curve]=GA(num_polution,max_gen,X_min,Xmax,dimensions,fobj,G);
%结果分析
Best_pos = round(Best_pos);
disp(['GA算法寻优得到的最短路径是：',num2str(Best_score)])
route = [S(1) Best_pos E(1)];
path_GA=generateContinuousRoute(route,G);
path_GA=GenerateSmoothPath(path_GA,G);  
path_GA=GenerateSmoothPath(path_GA,G);

[Best_score,Best_pos,SSA_curve]=SSA(num_polution,max_gen,X_min,Xmax,dimensions,fobj,G);
%结果分析
Best_pos = round(Best_pos);
disp(['SSA算法寻优得到的最短路径是：',num2str(Best_score)])
route = [S(1) Best_pos E(1)];
path_SSA=generateContinuousRoute(route,G);
path_SSA=GenerateSmoothPath(path_SSA,G);  
path_SSA=GenerateSmoothPath(path_SSA,G);



[Best_score,Best_pos,PSO_curve]=PSO(num_polution,max_gen,X_min,Xmax,dimensions,fobj,G);
%结果分析
Best_pos = round(Best_pos);
disp(['PSO算法寻优得到的最短路径是：',num2str(Best_score)])
route = [S(1) Best_pos E(1)];
path_PSO=generateContinuousRoute(route,G);
path_PSO=GenerateSmoothPath(path_PSO,G);  
path_PSO=GenerateSmoothPath(path_PSO,G);


[Best_score,Best_pos,GWO_curve]=GWO(num_polution,max_gen,X_min,Xmax,dimensions,fobj,G);
%结果分析
Best_pos = round(Best_pos);
disp(['GWO算法寻优得到的最短路径是：',num2str(Best_score)])
route = [S(1) Best_pos E(1)];
path_GWO=generateContinuousRoute(route,G);
path_GWO=GenerateSmoothPath(path_GWO,G);  
path_GWO=GenerateSmoothPath(path_GWO,G);

[Best_score,Best_pos,VPPSO_curve]=VPPSO(num_polution,max_gen,X_min,Xmax,dimensions,fobj,G);
%结果分析
Best_pos = round(Best_pos);
disp(['VPPSO算法寻优得到的最短路径是：',num2str(Best_score)])
route = [S(1) Best_pos E(1)];
path_VPPSO=generateContinuousRoute(route,G);
path_VPPSO=GenerateSmoothPath(path_VPPSO,G);  
path_VPPSO=GenerateSmoothPath(path_VPPSO,G);

[Best_score,Best_pos,DE_curve]=DE(num_polution,max_gen,X_min,Xmax,dimensions,fobj,G);
%结果分析
Best_pos = round(Best_pos);
disp(['DE算法寻优得到的最短路径是：',num2str(Best_score)])
route = [S(1) Best_pos E(1)];
path_DE=generateContinuousRoute(route,G);
path_DE=GenerateSmoothPath(path_DE,G);  
path_DE=GenerateSmoothPath(path_DE,G);



%% 画寻优曲线
figure(1)
plot(GA_curve,'k-o')
hold on
plot(SSA_curve,'y-^')
hold on
plot(PSO_curve,'b-*')
hold on
plot(GWO_curve,'c-v')
hold on
plot(VPPSO_curve,'m-x')
hold on
plot(DE_curve,'g-.o')
legend('GA','SSA','PSO','GWO','VPPSO','DE')
title('简单路径下各算法的收敛曲线')
% === 新增代码：y 轴刻度标签除以 10 ===
current_ticks = get(gca, 'YTick');
new_labels = arrayfun(@(x) num2str(x/10), current_ticks, 'UniformOutput', false);
set(gca, 'YTickLabel', new_labels);
ylabel('y 轴（单位×0.1）');
%% 画路径
figure(2)
for i=1:num/2  
    for j=1:num
        m=G(i,j);
        n=G(num+1-i,j);
        G(i,j)=n;
        G(num+1-i,j)=m;
    end
end
 
n=num;
for i=1:num
    for j=1:num
        if G(i,j)==1 
            x1=j-1;y1=n-i; 
            x2=j;y2=n-i; 
            x3=j;y3=n-i+1; 
            x4=j-1;y4=n-i+1; 
             p=fill([x1,x2,x3,x4],[y1,y2,y3,y4],[0, 0, 0],'FaceAlpha', 1);
            p.LineStyle="none";
            hold on 
        else 
            x1=j-1;y1=n-i; 
            x2=j;y2=n-i; 
            x3=j;y3=n-i+1; 
            x4=j-1;y4=n-i+1; 
            p=fill([x1,x2,x3,x4],[y1,y2,y3,y4],[1,1,1],'FaceAlpha', 0.3); 
            p.LineStyle="none";
            hold on 
        end 
    end 
end 
hold on
grid on;
set(gca, 'XTick', 0:num, 'YTick', 0:num);  % 设置网格线间隔为1
set(gca, 'GridColor', [0.8, 0.8, 0.8], 'GridAlpha', 1);  % 设置网格线颜色为浅灰色，完全不透明
axis equal;  % 保持X、Y轴比例一致
set(gca,'layer','top');  % 确保网格线显示在最上层

% 调整坐标轴，使y轴靠右，x轴和y轴0点重合
xlim([0 num]);  % 设置x轴范围
ylim([0 num]);  % 设置y轴范围
ax = gca;
ax.XAxisLocation = 'bottom';  % 将x轴放到底部
ax.YAxisLocation = 'right';   % 将y轴放到右边


drawPath(path_GA,'k')
hold on
drawPath(path_SSA,'y')
hold on
drawPath(path_PSO,'b')
hold on
drawPath(path_GWO,'c')
hold on
drawPath(path_VPPSO,'m')
hold on
drawPath(path_DE,'g')
hold on
% 将左侧的y轴保留并显示刻度
yyaxis left
ax.YAxis(1).Visible = 'on';   % 左侧y轴刻度标签保持可见

% 隐藏右侧的y轴
yyaxis right
ax.YAxis(2).Visible = 'off';  % 隐藏右侧y轴和数字

