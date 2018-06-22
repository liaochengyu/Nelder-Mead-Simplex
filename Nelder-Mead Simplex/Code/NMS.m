function [x,fval,flag,time,object_value]=NMS(fun,x0,max_time,eps)
% realization of Nelder-Mead Simplex
% max_time:the max number of iteration ,the default value is 10000
% eps: accuracy, the default value is 1e-5

% examine the parameters
if nargin<2
    error('please enter 2 parameters at least, including funtion and starting point')
end

% set default value for parameter
if nargin<3
    max_time=10000;
end
if nargin<4
    eps=1e-5;
end

% Initialize  parameters
lambda=0.7; rho=1; chi=2; gama=0.5; sigma=0.5;

n=length(x0);% get dimension
p=[];
p(:,1)=x0(:); % transpose the matrix
object_value=x0(:);

% compulate the starting point
for i=2:(n+1)
    e=zeros(n,1);
    e(i-1)=1;
    p(:,i)=p(:,1)+lambda*e;
end

% compulate the value
for i=1:(n+1)
    value(:,i)=feval(fun,p(:,i));
end

% sorting and ready to iterate
[value, index]=sort(value);
p=p(:,index);

% start iteration
while max_time
    % breaking condition
    if max(max(abs(p(:,2:n+1)-p(:,1:n)))) <eps
        break
    end
    
    % selet the three point
    best_point=p(:,1);
    best_point_value=value(:,1);
    sub_worst_point=p(:,n);
    sub_worst_point_value=value(:,n);
    worst_point=p(:,n+1);
    worst_point_value=value(:,n+1);
    
    % Reflection
    center=(best_point+sub_worst_point)/2;
    reflection_point=center+rho*(center-worst_point);
    reflection_point_value=feval(fun,reflection_point);
    
    if reflection_point_value < best_point_value
        % Expansion
        expansion_point=center+chi*(reflection_point-center);
        expansion_point_value=feval(fun,expansion_point);
        if expansion_point_value<reflection_point_value
            p(:,n+1)=expansion_point;
            value(:,n+1)=expansion_point_value;
        else
            p(:,n+1)=reflection_point;
            value(:,n+1)=reflection_point_value;
        end       
    else
        if reflection_point_value<sub_worst_point_value
            p(:,n+1)=reflection_point;
            value(:,n+1)=reflection_point_value;
        else
            % Outside Constraction
            shrink=0;
            if reflection_point_value < worst_point_value
                outside_constraction_point=center+gama*(reflection_point-center);
                outside_constraction_point_value=feval(fun,outside_constraction_point);
                if outside_constraction_point_value < worst_point_value
                    p(:,n+1)=outside_constraction_point;
                    value(:,n+1)=outside_constraction_point_value ;
                else
                    shrink=true;
                end
                % Inside Constraction
            else
                inside_constraction_point=center+gama*(worst_point-center);
                inside_constraction_point_value=feval(fun,inside_constraction_point);
                if inside_constraction_point_value < worst_point_value
                    p(:,n+1)=inside_constraction_point;
                    value(:,n+1)=inside_constraction_point_value ;
                else
                    shrink=1;
                end
            end
            
            % Shrinkage
            if shrink
                for i=2:n+1
                    p(:,i)=best_point+sigma*(p(:,i)-best_point);
                    value(:,i)=feval(fun,p(:,i));
                end
            end
        end
    end
    
    
    %  resort and ready to iterate
    [value, index]=sort(value);
    p=p(:,index);
    max_time=max_time-1;
    object_value=[object_value p(:,1)];
end


x=p(:,1);
fval=value(:,1);
time=max_time;
if max_time>0
    flag=1;
else
    flag=0;
end

end

% http://www.360doc.com/content/14/0405/10/13256259_366532138.shtml