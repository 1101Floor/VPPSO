function [gbest_fitness, gbest, Fitness_Curve] = VPPSO(NT, max_iteration, lb, ub, dim, fobj, G)

lb = lb .* ones(1, dim);
ub = ub .* ones(1, dim);

N = round(NT * 0.5);  % 第一群的粒子数量

c1 = 1.5;  % 个体学习因子
c2 = 1.2;  % 全局学习因子

X_min = lb;
X_max = ub;
V_max = ones(1, dim) .* (ub - lb) .* 0.25;  % 速度最大值
V_min = -V_max;
gbest_fitness = inf;

% 初始化
Position = zeros(NT, dim);
Velocity = zeros(NT, dim);
Pbest = zeros(NT, dim);
Pbest_finess = inf(1, NT);
fitness = inf(1, NT);

% 粒子位置初始化为栅格地图上的自由位置
for i = 1:NT
    for j = 1:dim
        column = G(:, j + 1);  % 获取当前列的栅格
        free_cells = find(column == 0);  % 找到自由栅格
        Position(i, j) = free_cells(randi(length(free_cells)));  % 随机选择一个自由栅格
    end
    fitness(i) = fobj(Position(i, :));  % 计算初始适应度
    Pbest(i, :) = Position(i, :);  % 初始化个体最优解
    Pbest_finess(i) = fitness(i);
    if Pbest_finess(i) < gbest_fitness
        gbest = Pbest(i, :);  % 初始化全局最优解
        gbest_fitness = Pbest_finess(i);
    end
end

% 开始迭代
for t = 1:max_iteration
    ww(t) = exp(-(2.5 * t / max_iteration)^2.5);  % 惯性权重随迭代次数调整

    % 更新粒子速度和位置（第一群粒子）
    for i = 1:N
        if rand < 0.5
            % 更新速度
            Velocity(i, :) = abs(Velocity(i, :)).^(rand * ww(t)) + rand * c1 * (Pbest(i, :) - Position(i, :)) + rand * c2 * (gbest - Position(i, :));
        end

        % 速度限幅
        Velocity(i, Velocity(i, :) > V_max) = V_max(Velocity(i, :) > V_max);
        Velocity(i, Velocity(i, :) < V_min) = V_min(Velocity(i, :) < V_min);

        % 更新位置
        Position(i, :) = Position(i, :) + Velocity(i, :);

        % 边界检查，确保粒子不会离开自由栅格
        for j = 1:dim
            column = G(:, j + 1);  % 获取当前列的栅格
            if Position(i, j) > ub(j) || Position(i, j) < lb(j) || column(round(Position(i, j))) == 1
                free_cells = find(column == 0);  % 获取自由栅格
                Position(i, j) = free_cells(randi(length(free_cells)));  % 返回到自由栅格
            end
        end
    end

    % 第二群粒子基于全局最优解进行更新
    for i = N+1:NT
        for j = 1:dim
            CC = ww(t) * rand * abs(gbest(j))^ww(t);
            if rand < 0.5
                Position(i, j) = gbest(j) + CC;
            else
                Position(i, j) = gbest(j) - CC;
            end

            % 边界检查，确保粒子位于自由栅格
            column = G(:, j + 1);
            if Position(i, j) > ub(j) || Position(i, j) < lb(j) || column(round(Position(i, j))) == 1
                free_cells = find(column == 0);
                Position(i, j) = free_cells(randi(length(free_cells)));
            end
        end
    end

    % 计算适应度
    for i = 1:NT
        fitness(i) = fobj(Position(i, :));

        % 更新个体最优
        if fitness(i) < Pbest_finess(i)
            Pbest(i, :) = Position(i, :);
            Pbest_finess(i) = fitness(i);
            if Pbest_finess(i) < gbest_fitness
                gbest = Pbest(i, :);
                gbest_fitness = Pbest_finess(i);
            end
        end
    end

    % 记录适应度随迭代变化
    Fitness_Curve(t) = gbest_fitness;
    % Ensure that the fitness curve (VPPSO_curve) is returned
    VPPSO_curve = Fitness_Curve;  % 返回适应度曲线
end
end




