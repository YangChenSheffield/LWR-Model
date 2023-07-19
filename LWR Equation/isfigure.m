function flag = isfigure(h) 
% flag = isfigure(h) 
% �ж�h�ǲ���ͼ�ξ��
% See Also: isaxes, plot_with_arrow
% ��ȡ����Matlab/Simulinkԭ�����Ϻͳ������ע΢�Ź��ںţ�Matlab Fans

if ishandle(h)
    if strcmp( 'figure' , get(h,'type') )
       flag = 1;
    else
        flag = 0;
    end
else
    flag = 0;
end

end