    
%% 空间清理
clc
clear
close all

global VarMax

%% 地图及问题建模
startPos = [200 100 150];
goalPos = [800 800 150];
map_select = 1; 
map_complexity =2; % 两个复杂度 自选1或2
flight_num = 10; % 航展点数量

model = Create_Select_Model(map_select,map_complexity,startPos,goalPos,flight_num); 

%% 算法参数定义
% 直角坐标的xyz范围
VarMin.x=model.xmin;           
VarMax.x=model.xmax;           
VarMin.y=model.ymin;           
VarMax.y=model.ymax;           
VarMin.z=model.zmin;           
VarMax.z=model.zmax;                 

% 球形坐标范围
VarMax.r=2*norm(model.start-model.end)/flight_num;           
VarMin.r=0;
% 仰角（极角）
AngleRange = pi/4; % Limit the angle range for better solutions
VarMin.psi=-AngleRange;            
VarMax.psi=AngleRange;          
% 方位角
dirVector = model.end - model.start;
phi0 = atan2(dirVector(2),dirVector(1));
VarMin.phi=phi0 - AngleRange;           
VarMax.phi=phi0 + AngleRange;

% 整合成熟悉的形式
[lb,ub,dim,fobj] = Get_Spherical_details(VarMax, VarMin, model,flight_num);

% 智能优化算法参数定义
SearchAgents_no = 100;
Max_iteration = 1000;

%% 多算法求解
%% 粒子群算法求解
[PSO_Curve , PSO_fitness, PSO_chorm] = PSO(lb,ub,dim,fobj,SearchAgents_no,Max_iteration,model);
disp ' ---  PSO 完成 ---'

%% 灰狼算法求解
[GWO_Curve , GWO_fitness, GWO_chorm] = GWO(lb,ub,dim,fobj,SearchAgents_no,Max_iteration,model);
disp ' ---  GWO 完成 ---'

%% 鲸鱼算法求解
[WOA_Curve , WOA_fitness, WOA_chorm] = WOA(lb,ub,dim,fobj,SearchAgents_no,Max_iteration,model);
disp ' ---  WOA 完成 ---'

%% 哈里斯鹰算法求解
[HHO_Curve , HHO_fitness, HHO_chorm] = HHO(lb,ub,dim,fobj,SearchAgents_no,Max_iteration,model);
disp ' ---  HHO 完成 ---'

%% 蜣螂算法求解
[DBO_Curve , DBO_fitness, DBO_chorm] = DBO(lb,ub,dim,fobj,SearchAgents_no,Max_iteration,model);
disp ' ---  DBO 完成 ---'
%% 速度暂停算法求解
[VPPSO_Curve , VPPSO_fitness, VPPSO_chorm] = VPPSO(lb,ub,dim,fobj,SearchAgents_no,Max_iteration,model);
disp ' ---  VPPSO 完成 ---'


%% 结果
results.algo = {'PSO','GWO','WOA','HHO','DBO','VPPSO'};
results.Curve = [PSO_Curve; GWO_Curve; WOA_Curve; HHO_Curve; DBO_Curve; VPPSO_Curve];
results.Chorm = [PSO_chorm; GWO_chorm; WOA_chorm; HHO_chorm; DBO_chorm; VPPSO_chorm];

Draw_results(results,model);
