function [yy, fitnesszbest, zbest] = VPPSO(lb, ub, dim, fobj, Popsize, maxgen, model)
%% 边界处理
lb = lb(:)';
ub = ub(:)';

if numel(lb) == 1
    lb = lb .* ones(1, dim);
end
if numel(ub) == 1
    ub = ub .* ones(1, dim);
end

%% 参数设置
NT = Popsize;              % 总粒子数
N  = round(NT * 0.5);      % 第一子群数量

c1 = 1.5;
c2 = 1.5;

X_min = lb;
X_max = ub;
V_max = (ub - lb) .* 0.25; % 速度上限
V_min = -V_max;

fitnesszbest = inf;        % 全局最优适应度

%% 初始化
Position = zeros(NT, dim);
Velocity = zeros(N, dim);      % 只有第一子群需要速度
fitness  = inf(1, NT);

Pbest = zeros(N, dim);
Pbest_fitness = inf(1, N);

% 初始化全部粒子位置
for i = 1:NT
    Position(i,:) = X_min + (X_max - X_min) .* rand(1, dim);
end

% 初始化第一子群
for i = 1:N
    Velocity(i,:) = zeros(1, dim);

   
    fitness(i) = fobj(SphericalToCart(Position(i,:), model));

    Pbest(i,:) = Position(i,:);
    Pbest_fitness(i) = fitness(i);

    if Pbest_fitness(i) < fitnesszbest
        zbest = Pbest(i,:);
        fitnesszbest = Pbest_fitness(i);
    end
end

% 初始化第二子群
for i = N+1:NT
    fitness(i) = fobj(SphericalToCart(Position(i,:), model));

    if fitness(i) < fitnesszbest
        zbest = Position(i,:);
        fitnesszbest = fitness(i);
    end
end

%% 主循环
yy = zeros(1, maxgen);

for t = 1:maxgen

    w = exp(-(2.5 * t / maxgen)^2.5);   % 原文中的 ww(t)

    
    for i = 1:N

        if rand < 0.3
            % VPPSO 的速度暂停/幂次更新机制
            Velocity(i,:) = abs(Velocity(i,:)).^(rand * w) ...
                          + rand * c1 .* (Pbest(i,:) - Position(i,:)) ...
                          + rand * c2 .* (zbest      - Position(i,:));
        end

        % 速度边界
        Velocity(i,:) = min(max(Velocity(i,:), V_min), V_max);

        % 位置更新
        Position(i,:) = Position(i,:) + Velocity(i,:);

        % 位置边界
        Position(i,:) = min(max(Position(i,:), lb), ub);
    end

  
    for i = N+1:NT
        for j = 1:dim
            CC = w * rand * abs(zbest(j))^w;

            if rand < 0.5
                Position(i,j) = zbest(j) + CC;
            else
                Position(i,j) = zbest(j) - CC;
            end
        end

        % 位置边界
        Position(i,:) = min(max(Position(i,:), lb), ub);
    end

    %% 适应度计算与最优更新
    for i = 1:NT

        % --- 关键修改：统一基于球坐标转实际路径后评估 ---
        fitness(i) = fobj(SphericalToCart(Position(i,:), model));

        if i <= N
            % 更新个体最优
            if fitness(i) < Pbest_fitness(i)
                Pbest(i,:) = Position(i,:);
                Pbest_fitness(i) = fitness(i);
            end

            % 更新全局最优
            if Pbest_fitness(i) < fitnesszbest
                zbest = Pbest(i,:);
                fitnesszbest = Pbest_fitness(i);
            end

        else
            % 第二子群只参与全局最优更新
            if fitness(i) < fitnesszbest
                zbest = Position(i,:);
                fitnesszbest = fitness(i);
            end
        end
    end

    yy(t) = fitnesszbest;
end
end